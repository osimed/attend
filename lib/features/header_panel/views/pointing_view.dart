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
      padding: const EdgeInsets.all(4.0),
      child: LayoutBuilder(
        builder: (context, boxC) {
          if (boxC.maxWidth > 700) {
            return SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  SizedBox(width: 240, child: buildTimeSelector(context)),
                  Flexible(child: buildStatusSelector(context)),
                  buildEmployeeLayoffButton(context),
                ],
              ),
            );
          }
          return SizedBox(
            height: 140,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Flexible(child: buildTimeSelector(context)),
                      buildEmployeeLayoffButton(context),
                    ],
                  ),
                ),
                Flexible(child: buildStatusSelector(context)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTimeSelector(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        children: [
          Expanded(child: buildPickEnterTime(context)),
          FilledButton(
            onPressed: () {
              final bloc = context.read<HeaderPanelBloc>();
              final newAtt = attendance.copyWith(
                status: .p,
                lunchBreak: !attendance.lunchBreak,
              );
              bloc.add(SaveAttendance(cell: cell, attendance: newAtt));
            },
            style: FilledButton.styleFrom(
              padding: .zero,
              foregroundColor: attendance.lunchBreak
                  ? Colors.black
                  : Colors.grey.shade300,
              backgroundColor: attendance.lunchBreak
                  ? Colors.amber.shade500
                  : Colors.grey.shade600,
              minimumSize: const Size(38, 38),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              elevation: 0,
            ),
            child: const Text(
              '1h',
              style: TextStyle(fontWeight: .w700, fontSize: 15),
            ),
          ),
          Expanded(child: buildPickLeaveTime(context)),
        ],
      ),
    );
  }

  TextButton buildPickEnterTime(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        minimumSize: Size.infinite,
      ),
      onPressed: () async {
        final bloc = context.read<HeaderPanelBloc>();
        final fallbackEnter = const TimeOfDay(hour: 08, minute: 00);
        final enter = await showTimePicker(
          context: context,
          initialTime: attendance.enter ?? fallbackEnter,
        );
        if (enter == null) return;

        final newAtt = attendance.copyWith(status: .p, enter: Value(enter));
        bloc.add(SaveAttendance(cell: cell, attendance: newAtt));
      },
      child: Text(
        attendance.enter?.displayTime() ?? '--:--',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: .w700,
          letterSpacing: 1,
        ),
      ),
    );
  }

  TextButton buildPickLeaveTime(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        minimumSize: Size.infinite,
      ),
      onPressed: () async {
        final bloc = context.read<HeaderPanelBloc>();
        final fallbackLeave = const TimeOfDay(hour: 17, minute: 00);
        final leave = await showTimePicker(
          context: context,
          initialTime: attendance.leave ?? fallbackLeave,
        );
        if (leave == null) return;

        final newAtt = attendance.copyWith(status: .p, leave: Value(leave));
        bloc.add(SaveAttendance(cell: cell, attendance: newAtt));
      },
      child: Text(
        attendance.leave?.displayTime() ?? '--:--',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: .w700,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget buildStatusSelector(BuildContext context) {
    return Card(
      elevation: 0,
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
                      attendance: attendance.copyWith(
                        status: status,
                        enter: const Value(null),
                        leave: const Value(null),
                        lunchBreak: true,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: status == attendance.status
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : null,
                  foregroundColor: status == attendance.status
                      ? Theme.of(context).colorScheme.onTertiaryContainer
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
    );
  }

  Widget buildEmployeeLayoffButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilledButton(
        onPressed: () {
          final bloc = context.read<HeaderPanelBloc>();
          bloc.add(
            LayoffEmployee(
              employeeId: attendance.employeeId,
              left: attendance.date,
            ),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Center(
          child: Text(
            'DEMISSION',
            style: TextStyle(fontSize: 18, fontWeight: .w800),
          ),
        ),
      ),
    );
  }
}
