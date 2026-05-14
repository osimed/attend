import 'dart:io' as io;
import 'dart:typed_data' show Uint8List;

import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/database_sync/blocs/database_sync_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/services/attend_service.dart';
import 'package:attend/services/calendar_service.dart';
import 'package:attend/services/dbsync_service.dart';
import 'package:attend/services/export_service.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;

void registerLazySingletons() {
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => AttendService());
  locator.registerLazySingleton(
    () => DBSyncService(locator.get<AttendService>()),
  );
  locator.registerLazySingleton(() => CalendarService());
  locator.registerLazySingleton(
    () => ExportService(locator.get<AttendService>()),
  );
  locator.registerLazySingleton(
    () => DatabaseSyncBloc(
      locator.get<AttendService>(),
      locator.get<DBSyncService>(),
    ),
  );
  locator.registerLazySingleton(
    () => CalendarGridBloc(locator.get<AttendService>()),
  );
  locator.registerLazySingleton(
    () => HeaderPanelBloc(locator.get<AttendService>()),
  );
}

Future<void> reloadDatabase(Uint8List bytes) async {
  final oldDB = locator.get<AppDatabase>();
  await locator.resetLazySingleton<AppDatabase>(
    instance: oldDB,
    disposingFunction: (db) async {
      await db.close();
    },
  );

  final dbDir = await getApplicationSupportDirectory();
  final dbFile = io.File(join(dbDir.path, 'attend.db'));
  await dbFile.writeAsBytes(bytes, flush: true);
}
