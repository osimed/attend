sealed class DatabaseSyncState {
  final bool isRunning;

  DatabaseSyncState({this.isRunning = false});
}

class DatabaseSyncNormalMode extends DatabaseSyncState {
  final bool isSyncing;
  final ({String? host, String id, String name})? device;

  DatabaseSyncNormalMode({
    super.isRunning,
    this.device,
    this.isSyncing = false,
  });
}

class DatabaseSyncSyncedMode extends DatabaseSyncState {
  final bool isSuccess;
  final ({String? host, String id, String name}) device;

  DatabaseSyncSyncedMode({
    super.isRunning = true,
    required this.isSuccess,
    required this.device,
  });
}

class DatabaseSyncScanQRMode extends DatabaseSyncState {
  DatabaseSyncScanQRMode({super.isRunning});
}

class DatabaseSyncViewQRMode extends DatabaseSyncState {
  DatabaseSyncViewQRMode({super.isRunning = true});
}

class DatabaseSyncImportExportMode extends DatabaseSyncState {
  DatabaseSyncImportExportMode({super.isRunning});
}
