import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:attend/core/device_info.dart';
import 'package:attend/database/database.dart';
import 'package:attend/services/attend_service.dart';

const port = 46072;

class DBSyncService {
  HttpServer? server;
  final AttendService _attendService;
  final _ctrl = StreamController<String>.broadcast();

  DBSyncService(this._attendService);

  Future<bool> start() async {
    final ip = InternetAddress.anyIPv4;
    try {
      server ??= await HttpServer.bind(ip, port);
      if (server == null) return false;
      await for (final req in server!) {
        _handleRequest(req);
      }
    } catch (_) {
      return false;
    }
    return true;
  }

  bool get isRunning => server != null;

  Stream<String> get event => _ctrl.stream;

  Future<void> close() async {
    await server?.close();
    server = null;
  }

  Future<void> serveDeviceInfo(HttpRequest req) async {
    final info = await deviceInfo();
    final payload = {"id": info.$1, "name": info.$2};
    req.response.write(jsonEncode(payload));
  }

  Future<void> serveSyncDatabase(HttpRequest req) async {
    // get remote logs
    final payload = utf8.decoder.bind(req);
    final data = jsonDecode(await payload.join());

    if (data is! Map<String, dynamic>) {
      req.response.statusCode = 400;
      return;
    }
    final remoteDeviceId = data["device"]["id"] as String;
    final remoteDeviceName = data["device"]["name"] as String;
    _ctrl.add('syncing#$remoteDeviceId#$remoteDeviceName');

    try {
      final logs = data["logs"] as List;
      final changes = logs.map((l) => ChangeLog.fromJson(l));
      await _attendService.syncRemoteChanges(changes.toList());
      final ts = changes.isNotEmpty ? changes.last.timestamp : DateTime.now();
      await _attendService.updateSyncCursor(remoteDeviceId, ts);

      // send local logs
      final dLogs = await _attendService.getChangeLogs(remoteDeviceId);
      req.response.write(jsonEncode({"logs": dLogs}));

      _ctrl.add('synced#$remoteDeviceId#$remoteDeviceName#true');
    } catch (_) {
      _ctrl.add('synced#$remoteDeviceId#$remoteDeviceName#false');
    }
  }

  void _handleRequest(HttpRequest req) async {
    try {
      if (req.method == 'GET' && req.requestedUri.path == '/info') {
        await serveDeviceInfo(req);
        return;
      }
      if (req.method == 'POST' && req.requestedUri.path == '/sync') {
        await serveSyncDatabase(req);
        return;
      }
      req.response.statusCode = 404;
    } catch (_) {
      req.response.statusCode = 500;
    } finally {
      await req.response.flush();
      await req.response.close();
    }
  }
}
