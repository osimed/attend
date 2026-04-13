import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

const _cellWidth = 65.0;
const _cellHeight = 55.0;

class AttendanceCell extends StatelessWidget {
  final TableVicinity vicinity;

  const AttendanceCell({super.key, required this.vicinity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarGridBloc, CalendarGridState>(
      buildWhen: (previous, current) {
        if (current is CalendarCellRefreshed) {
          return current.cell == vicinity;
        }
        if (current is MonthlyCalendarLoaded) {
          final len = current.calendar.length;
          return vicinity.row - 1 < len;
        }
        return false;
      },
      builder: (context, state) {
        final entry = state.calendar[vicinity.row - 1];
        final attendance = entry.attendances[vicinity.column];

        final colDay = DateTime(
          state.month.year,
          state.month.month,
          vicinity.column,
        );
        if (state is CalendarCellViewDiff && state.cell == vicinity) {
          final entry = state.calendar[state.cell.row - 1];
          final attendance =
              entry.attendances[state.cell.column] ??
              Attendance(
                employeeId: entry.employee.id,
                date: DateTime(
                  state.month.year,
                  state.month.month,
                  vicinity.column,
                ),
                lunchBreak: true,
                status: .empty,
              );
          return InkWell(
            onTap: () {
              context.read<HeaderPanelBloc>().add(
                SelectAttendance(cell: state.cell, attendance: attendance),
              );
            },
            onDoubleTap: () {
              context.read<CalendarGridBloc>().add(
                RefreshCalendarCell(cell: vicinity, attendance: attendance),
              );
            },
            child: Center(child: Text(state.diff.formatTime())),
          );
        }
        if (attendance == null || attendance.status == .empty) {
          if (colDay.weekday == DateTime.sunday) {
            return InkWell(
              onTap: () {
                context.read<HeaderPanelBloc>().add(
                  SelectAttendance(
                    cell: vicinity,
                    attendance:
                        attendance ??
                        Attendance(
                          employeeId: entry.employee.id,
                          date: DateTime(
                            state.month.year,
                            state.month.month,
                            vicinity.column,
                          ),
                          lunchBreak: true,
                          status: .empty,
                        ),
                  ),
                );
              },
              child: ClipRRect(
                child: CustomPaint(
                  painter: DiagonalHatchPainter(
                    offset:
                        vicinity.row * _cellHeight +
                        vicinity.column * _cellWidth,
                  ),
                ),
              ),
            );
          }
        }
        return Padding(
          padding: const EdgeInsets.all(.5),
          child: Material(
            color: attendance?.status.color,
            child: InkWell(
              onTap: () {
                context.read<HeaderPanelBloc>().add(
                  SelectAttendance(
                    cell: vicinity,
                    attendance:
                        attendance ??
                        Attendance(
                          employeeId: entry.employee.id,
                          date: DateTime(
                            state.month.year,
                            state.month.month,
                            vicinity.column,
                          ),
                          lunchBreak: true,
                          status: .empty,
                        ),
                  ),
                );
              },
              onDoubleTap: () {
                context.read<CalendarGridBloc>().add(
                  CalcAttendanceDiff(cell: vicinity),
                );
              },
              onLongPress: () {
                context.read<HeaderPanelBloc>().add(
                  SaveAttendance(
                    cell: vicinity,
                    attendance: Attendance(
                      employeeId: entry.employee.id,
                      date: DateTime(
                        state.month.year,
                        state.month.month,
                        vicinity.column,
                      ),
                      lunchBreak: true,
                      status: .empty,
                    ),
                  ),
                );
              },
              child: switch (attendance?.status) {
                null || .empty => const SizedBox.shrink(),
                .p => Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        attendance!.enter?.displayTime() ?? '--:--',
                        style: const TextStyle(
                          fontWeight: .w700,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(width: 40, child: Divider(height: 8)),
                      Text(
                        attendance.leave?.displayTime() ?? '--:--',
                        style: const TextStyle(
                          fontWeight: .w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                _ => Center(
                  child: Text(
                    attendance!.status.name.toUpperCase(),
                    style: const TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                ),
              },
            ),
          ),
        );
      },
    );
  }
}

class DiagonalHatchPainter extends CustomPainter {
  final double offset;
  final double gap;

  DiagonalHatchPainter({super.repaint, required this.offset, this.gap = 8});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withAlpha(140)
      ..strokeWidth = 1.5;

    for (double i = -size.height; i < size.width; i += gap) {
      canvas.drawLine(
        Offset(i + offset % gap, 0),
        Offset(i + size.height + offset % gap, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) {
    return false;
  }
}
