import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

class PointingView extends StatelessWidget {
  final TableVicinity cell;
  final Attendance attendance;

  const PointingView({super.key, required this.cell, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: attendance.status == .p
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(80, 80),
                      foregroundColor: attendance.status == .p
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : null,
                    ),
                    onPressed: () async {
                      final bloc = context.read<HeaderPanelBloc>();
                      final enter = await showTimePicker(
                        context: context,
                        initialTime:
                            attendance.enter ??
                            const TimeOfDay(hour: 08, minute: 00),
                      );
                      if (enter == null) return;

                      final newAtt = attendance.copyWith(
                        status: .p,
                        enter: Value(enter),
                      );
                      bloc.add(
                        SaveAttendance(cell: cell, attendance: newAtt),
                      );
                    },
                    child: Text(
                      attendance.enter?.displayTime() ?? '--:--',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: .w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(80, 80),
                      foregroundColor: attendance.status == .p
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : null,
                    ),
                    onPressed: () async {
                      final bloc = context.read<HeaderPanelBloc>();
                      final leave = await showTimePicker(
                        context: context,
                        initialTime:
                            attendance.leave ??
                            const TimeOfDay(hour: 17, minute: 00),
                      );
                      if (leave == null) return;

                      final newAtt = attendance.copyWith(
                        status: .p,
                        leave: Value(leave),
                      );
                      bloc.add(
                        SaveAttendance(cell: cell, attendance: newAtt),
                      );
                    },
                    child: Text(
                      attendance.leave?.displayTime() ?? '--:--',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: .w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView(
                scrollDirection: .horizontal,
                children: [
                  for (final status in Status.values)
                    if (status != .empty && status != .p)
                      TextButton(
                        onPressed: () {
                          context.read<HeaderPanelBloc>().add(
                            SaveAttendance(
                              cell: cell,
                              attendance: attendance.copyWith(status: status),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: status == attendance.status
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : null,
                          foregroundColor: status == attendance.status
                              ? Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer
                              : null,
                        ),
                        child: Text(
                          status.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: .w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                shape: const RoundedRectangleBorder(),
              ),
              child: const Center(
                child: Text(
                  'DIMISSION',
                  style: TextStyle(fontSize: 18, fontWeight: .w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
