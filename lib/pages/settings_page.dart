import 'dart:io';
import 'dart:io' as io;

import 'package:attend/core/locator.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/database_sync/blocs/database_sync_bloc.dart';
import 'package:attend/features/database_sync/blocs/database_sync_event.dart';
import 'package:attend/features/database_sync/blocs/database_sync_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseSyncBloc, DatabaseSyncState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.import_export),
                onPressed: () {
                  context.read<DatabaseSyncBloc>().add(
                    DatabaseSyncImportExport(),
                  );
                },
              ),
              if (state.isRunning)
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    context.read<DatabaseSyncBloc>().add(
                      DatabaseSyncServerShowQR(),
                    );
                  },
                ),
              if (Platform.isAndroid)
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    context.read<DatabaseSyncBloc>().add(
                      DatabaseSyncServerScanQR(),
                    );
                  },
                ),
              FilledButton.icon(
                label: Text(state.isRunning ? 'pause' : 'start'),
                icon: Icon(state.isRunning ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  context.read<DatabaseSyncBloc>().add(
                    DatabaseSyncServerToggle(),
                  );
                },
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: SizedBox.expand(
            child: switch (state) {
              DatabaseSyncScanQRMode _ => MobileScanner(
                onDetect: (qr) {
                  context.read<DatabaseSyncBloc>().add(
                    DatabaseSyncServerConnect(qr: qr),
                  );
                },
              ),
              DatabaseSyncViewQRMode _ => Center(child: qrView()),
              DatabaseSyncSyncedMode state => Center(
                child: FilledButton.tonalIcon(
                  onPressed: state.device.host != null
                      ? () {
                          final device = (
                            host: state.device.host!,
                            id: state.device.id,
                            name: state.device.name,
                          );
                          context.read<DatabaseSyncBloc>().add(
                            DatabaseSyncServerSync(device: device),
                          );
                        }
                      : null,
                  icon: Icon(state.isSuccess ? Icons.done : Icons.error),
                  label: Text(state.device.name),
                ),
              ),
              DatabaseSyncNormalMode state => Center(
                child: FilledButton.tonalIcon(
                  onPressed: state.device != null && state.device!.host != null
                      ? () {
                          final device = (
                            host: state.device!.host!,
                            id: state.device!.id,
                            name: state.device!.name,
                          );
                          context.read<DatabaseSyncBloc>().add(
                            DatabaseSyncServerSync(device: device),
                          );
                        }
                      : null,
                  icon: state.isSyncing
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : const Icon(Icons.sync),
                  label: Text(state.device?.name ?? 'connect to a device'),
                ),
              ),
              DatabaseSyncImportExportMode _ => Center(
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    FilledButton(
                      onPressed: () async {
                        final dbDir = await getApplicationSupportDirectory();
                        final dbFile = io.File(join(dbDir.path, 'attend.db'));
                        final t = DateTime.now();
                        await FilePicker.saveFile(
                          fileName: 'attend-${t.year}-${t.month}-${t.day}.db',
                          allowedExtensions: ['db'],
                          bytes: await dbFile.readAsBytes(),
                        );
                      },
                      child: const Text('export'),
                    ),
                    FilledButton(
                      onPressed: () async {
                        final res = await FilePicker.pickFiles(
                          type: .custom,
                          allowedExtensions: ['db'],
                        );

                        final file = res?.xFiles.first;
                        final bytes = await file?.readAsBytes();
                        if (bytes == null) return;
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmationPopup(
                              title: "Import database",
                              message: "this will delete current database",
                              confirmText: "save",
                              cancelText: "cancel",
                              isDestructive: true,
                              onConfirm: () async {
                                await reloadDatabase(bytes);
                                locator.get<CalendarGridBloc>().add(
                                  LoadMonthlyCalendar(),
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: const Text('import'),
                    ),
                  ],
                ),
              ),
            },
          ),
        );
      },
    );
  }

  Widget qrView() {
    return FutureBuilder(
      future: NetworkInterface.list(type: .IPv4),
      builder: (context, snapshot) {
        if (snapshot.connectionState != .done) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('error');
        }
        final addresses = snapshot.data!
            .map((ni) => ni.addresses.map((a) => a.address).join('|'))
            .join('|');
        return QrImageView(
          data: addresses,
          size: 300,
          dataModuleStyle: QrDataModuleStyle(
            dataModuleShape: .square,
            color: Theme.of(context).brightness == .dark
                ? Colors.white
                : Colors.black,
          ),
          eyeStyle: QrEyeStyle(
            eyeShape: .square,
            color: Theme.of(context).brightness == .dark
                ? Colors.white
                : Colors.black,
          ),
        );
      },
    );
  }
}

class ConfirmationPopup extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final IconData icon;
  final Color? iconColor;
  final bool isDestructive;
  const ConfirmationPopup({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.icon = Icons.help_outline,
    this.iconColor,
    this.isDestructive = false,
  });
  @override
  Widget build(BuildContext context) {
    // 1. Determine the primary color (Red for destructive, Blue/Theme for normal)
    final primaryColor = isDestructive ? Colors.red : Colors.blue;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 2. Icon Area
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: (iconColor ?? primaryColor).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? primaryColor, size: 32),
            ),
            const SizedBox(height: 20),
            // 3. Title & Message
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 4. Action Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel ?? () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      cancelText,
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Confirm Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog first
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      confirmText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
