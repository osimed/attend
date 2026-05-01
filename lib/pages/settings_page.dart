import 'dart:io';

import 'package:attend/features/database_sync/blocs/database_sync_bloc.dart';
import 'package:attend/features/database_sync/blocs/database_sync_event.dart';
import 'package:attend/features/database_sync/blocs/database_sync_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseSyncBloc, DatabaseSyncState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
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
