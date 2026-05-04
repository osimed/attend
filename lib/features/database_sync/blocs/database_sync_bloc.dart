import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:attend/core/device_info.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/database_sync/blocs/database_sync_event.dart';
import 'package:attend/features/database_sync/blocs/database_sync_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:attend/services/dbsync_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseSyncBloc extends Bloc<DatabaseSyncEvent, DatabaseSyncState> {
  final AttendService _attendService;
  final DBSyncService _dbSyncService;

  StreamSubscription? _sub;

  DatabaseSyncBloc(this._attendService, this._dbSyncService)
    : super(DatabaseSyncNormalMode()) {
    on<DatabaseSyncServerToggle>(_onDatabaseSyncServerToggle);
    on<DatabaseSyncServerConnect>(_onDatabaseSyncServerConnect);
    on<DatabaseSyncServerSync>(_onDatabaseSyncServerSync);
    on<DatabaseSyncServerSubEvent>(_onDatabaseSyncServerSubEvent);
    on<DatabaseSyncServerScanQR>(_onDatabaseSyncServerScanQR);
    on<DatabaseSyncServerShowQR>(_onDatabaseSyncServerShowQR);

    _sub = _dbSyncService.event.listen((ev) {
      add(DatabaseSyncServerSubEvent(ev: ev));
    });
  }

  Future<void> _onDatabaseSyncServerToggle(
    DatabaseSyncServerToggle event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    if (_dbSyncService.isRunning) {
      await _dbSyncService.close();
      emit(DatabaseSyncNormalMode(isRunning: false));
    } else {
      _dbSyncService.start();
      emit(DatabaseSyncNormalMode(isRunning: true));
    }
  }

  Future<void> _onDatabaseSyncServerConnect(
    DatabaseSyncServerConnect event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    if (event.qr.barcodes.length != 1) {
      emit(DatabaseSyncScanQRMode(isRunning: state.isRunning));
      return;
    }
    final hosts = event.qr.barcodes.first.rawValue ?? '';
    for (final host in hosts.split('|')) {
      try {
        io.HttpClient client = io.HttpClient();
        final url = Uri.parse('http://$host:$port/info');
        final resp = await (await client.getUrl(url)).close();
        if (resp.statusCode != 200) continue;
        final respStr = resp.transform(utf8.decoder).join();
        final data = jsonDecode(await respStr);
        if (data is! Map<String, dynamic>) continue;
        final deviceId = data["id"] as String;
        final deviceName = data["name"] as String;
        emit(
          DatabaseSyncNormalMode(
            isRunning: state.isRunning,
            device: (host: host, id: deviceId, name: deviceName),
          ),
        );
        return;
      } catch (_) {
        continue;
      }
    }
    emit(DatabaseSyncNormalMode(isRunning: state.isRunning));
  }

  Future<void> _onDatabaseSyncServerSync(
    DatabaseSyncServerSync event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    emit(
      DatabaseSyncNormalMode(
        isRunning: state.isRunning,
        device: event.device,
        isSyncing: true,
      ),
    );
    final id = event.device.id;
    final host = event.device.host;
    final info = await deviceInfo();
    final device = {"id": info.$1, "name": info.$2};
    bool allSynced = false;

    while (!allSynced) {
      final logs = await _attendService.getChangeLogs(id);
      io.HttpClient client = io.HttpClient();
      try {
        final url = Uri.parse('http://$host:$port/sync');
        final req = await client.postUrl(url);
        final payload = jsonEncode({"logs": logs, "device": device});
        req.add(utf8.encoder.convert(payload));
        await req.flush();
        final resp = await req.close();
        if (resp.statusCode != 200) throw Exception();

        final respStr = resp.transform(utf8.decoder).join();
        final data = jsonDecode(await respStr);
        if (data is! Map<String, dynamic>) return;
        final rChanges = data["logs"] as List;
        final rLogs = rChanges.map((l) => ChangeLog.fromJson(l)).toList();
        await _attendService.syncRemoteChanges(rLogs);
        final ts = rLogs.isNotEmpty ? rLogs.last.timestamp : DateTime.now();
        await _attendService.updateSyncCursor(id, ts);

        allSynced = rLogs.length < 1000 && logs.length < 1000;
      } catch (_) {
        emit(
          DatabaseSyncSyncedMode(
            isRunning: state.isRunning,
            device: event.device,
            isSuccess: false,
          ),
        );
        return;
      } finally {
        client.close(force: true);
      }
    }
    emit(
      DatabaseSyncSyncedMode(
        isRunning: state.isRunning,
        device: event.device,
        isSuccess: true,
      ),
    );
  }

  Future<void> _onDatabaseSyncServerShowQR(
    DatabaseSyncServerShowQR event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    if (state is DatabaseSyncViewQRMode) {
      emit(DatabaseSyncNormalMode(isRunning: state.isRunning));
    } else {
      emit(DatabaseSyncViewQRMode(isRunning: state.isRunning));
    }
  }

  Future<void> _onDatabaseSyncServerScanQR(
    DatabaseSyncServerScanQR event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    if (state is DatabaseSyncScanQRMode) {
      emit(DatabaseSyncNormalMode(isRunning: state.isRunning));
    } else {
      emit(DatabaseSyncScanQRMode(isRunning: state.isRunning));
    }
  }

  Future<void> _onDatabaseSyncServerSubEvent(
    DatabaseSyncServerSubEvent event,
    Emitter<DatabaseSyncState> emit,
  ) async {
    final msg = event.ev.split('#');
    final device = (host: null, id: msg[1], name: msg[2]);
    if (msg.first == 'syncing') {
      emit(
        DatabaseSyncNormalMode(
          isRunning: state.isRunning,
          isSyncing: true,
          device: device,
        ),
      );
    }
    if (msg.first == 'synced') {
      emit(
        DatabaseSyncSyncedMode(
          isRunning: true,
          isSuccess: msg[3] == 'true',
          device: device,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _sub = null;
    return super.close();
  }
}
