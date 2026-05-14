import 'package:mobile_scanner/mobile_scanner.dart';

sealed class DatabaseSyncEvent {}

class DatabaseSyncServerToggle extends DatabaseSyncEvent {}

class DatabaseSyncServerConnect extends DatabaseSyncEvent {
  final BarcodeCapture qr;

  DatabaseSyncServerConnect({required this.qr});
}

class DatabaseSyncServerSync extends DatabaseSyncEvent {
  final ({String host, String id, String name}) device;
  DatabaseSyncServerSync({required this.device});
}

class DatabaseSyncServerSubEvent extends DatabaseSyncEvent {
  final String ev;

  DatabaseSyncServerSubEvent({required this.ev});
}

class DatabaseSyncServerScanQR extends DatabaseSyncEvent {}

class DatabaseSyncServerShowQR extends DatabaseSyncEvent {}

class DatabaseSyncImportExport extends DatabaseSyncEvent {}
