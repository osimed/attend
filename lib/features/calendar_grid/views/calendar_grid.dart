import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/features/calendar_grid/views/attendance_cell.dart';
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
                child: buildGridTeamSelector(state, context),
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
            final lDate = entry.employee.leaveDate;
            final isLeave =
                lDate != null &&
                lDate.year == state.month.year &&
                lDate.month == state.month.month &&
                lDate.day <= vicinity.column;
            if (isLeave) {
              return TableViewCell(
                columnMergeStart: lDate.day,
                columnMergeSpan: daysInMonth - lDate.day + 1,
                child: GestureDetector(
                  onLongPress: () {
                    context.read<HeaderPanelBloc>().add(
                      LayoffEmployee(employeeId: entry.employee.id, left: null),
                    );
                  },
                  child: CustomPaint(
                    painter: TextBannerPainter(text: 'DEMISSION'),
                  ),
                ),
              );
            }
            return TableViewCell(child: AttendanceCell(vicinity: vicinity));
          },
        );
      },
    );
  }

  Padding buildGridTeamSelector(
    MonthlyCalendarLoaded state,
    BuildContext context,
  ) {
    return Padding(
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

class TextBannerPainter extends CustomPainter {
  final String text;

  TextBannerPainter({super.repaint, required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= _cellWidth * 2) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(fontSize: 11, fontWeight: .w800),
        ),
        textDirection: .ltr,
      );
      painter.layout();
      final dx = size.width - painter.width;
      painter.paint(canvas, Offset(dx / 2, 21));
      return;
    }

    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 20, fontWeight: .w800),
      ),
      textDirection: .ltr,
    );
    painter.layout();

    const padding = 80;
    final stride = painter.width + padding;
    final elements = size.width ~/ stride;
    final leftover = size.width - stride * elements + padding;

    if (leftover / 2 > padding) {
      drawLines(canvas, [
        leftover / 2 - 30,
        leftover / 2 - 40,
        leftover / 2 - 50,
      ]);
    }
    for (int i = 0; i < elements; i++) {
      final x = leftover / 2 + i * stride;
      painter.paint(canvas, Offset(x, 16));

      final lastElem = i == elements - 1;
      if (leftover / 2 > padding || !lastElem) {
        drawLines(canvas, [
          x + painter.width + 30,
          x + painter.width + 40,
          x + painter.width + 50,
        ]);
      }
    }
  }

  void drawLines(Canvas canvas, List<double> offsets) {
    for (final offset in offsets) {
      canvas.drawPath(
        Path()
          ..moveTo(offset, 10)
          ..lineTo(offset - 5, 45)
          ..lineTo(offset, 45)
          ..lineTo(offset + 5, 10)
          ..close(),
        Paint()..color = Colors.amber,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) {
    return false;
  }
}
