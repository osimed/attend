import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/features/calendar_grid/views/calendar_day.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

const _cellWidth = 65.0;
const _cellHeight = 55.0;

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarGridBloc, CalendarGridState>(
      buildWhen: (previous, current) => current is MonthlyCalendarLoaded,
      builder: (context, state) {
        if (state is! MonthlyCalendarLoaded) {
          return const SizedBox.shrink();
        }
        final daysInMonth = DateUtils.getDaysInMonth(
          state.month.year,
          state.month.month,
        );
        return TableView.builder(
          rowCount: state.calendar.length + 1,
          columnCount: daysInMonth + 1,
          horizontalDetails: ScrollableDetails.horizontal(
            controller: ScrollController(
              initialScrollOffset: (state.month.day - 1) * _cellWidth,
            ),
          ),
          pinnedRowCount: 1,
          pinnedColumnCount: 1,
          diagonalDragBehavior: .free,
          rowBuilder: (index) => _buildTableSpan(context, index, true),
          columnBuilder: (index) => _buildTableSpan(context, index, false),
          cellBuilder: (context, vicinity) {
            if (vicinity.row == 0 && vicinity.column == 0) {
              return TableViewCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<Team>(
                    isExpanded: true,
                    value: state.team,
                    underline: const SizedBox.shrink(),
                    items: [
                      for (final t in Team.values)
                        DropdownMenuItem(value: t, child: Text(t.name)),
                    ],
                    onChanged: (t) => BlocProvider.of<CalendarGridBloc>(
                      context,
                    ).add(LoadMonthlyCalendar(month: state.month, team: t)),
                  ),
                ),
              );
            }
            if (vicinity.row == 0) {
              return TableViewCell(
                child: CalendarDay(month: state.month, vicinity: vicinity),
              );
            }
            final entry = state.calendar[vicinity.row - 1];
            if (vicinity.column == 0) {
              return TableViewCell(
                child: _EmployeeNameCell(employee: entry.employee),
              );
            }
            return TableViewCell(
              child: BlocBuilder<CalendarGridBloc, CalendarGridState>(
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
                  return Padding(
                    padding: const EdgeInsets.all(.5),
                    child: Material(
                      color: switch (attendance?.status) {
                        .c => Colors.redAccent,
                        .a => Colors.amber,
                        .r => Colors.teal,
                        .j => Colors.blueAccent,
                        .m => Colors.lime.shade600,
                        _ => null,
                      },
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
                                    status: .empty,
                                  ),
                            ),
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
                                const SizedBox(
                                  width: 40,
                                  child: Divider(height: 8),
                                ),
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  TableSpan _buildTableSpan(BuildContext context, int index, bool isRow) {
    final double width = index == 0 ? 110 : _cellWidth;
    final double height = index == 0 ? 45 : _cellHeight;
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return TableSpan(
      extent: FixedSpanExtent(isRow ? height : width),
      backgroundDecoration: TableSpanDecoration(
        border: TableSpanBorder(
          leading: index == 0 ? BorderSide(color: color) : BorderSide.none,
          trailing: BorderSide(color: color),
        ),
      ),
    );
  }
}

class _EmployeeNameCell extends StatelessWidget {
  final Employee employee;

  const _EmployeeNameCell({required this.employee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<HeaderPanelBloc>().add(SelectEmployee(employee: employee));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Text(
              employee.lastName.toUpperCase(),
              style: const TextStyle(fontSize: 15, fontWeight: .w800),
            ),
            Text(
              employee.firstName.toUpperCase(),
              style: const TextStyle(fontSize: 13, fontWeight: .w300),
            ),
          ],
        ),
      ),
    );
  }
}
