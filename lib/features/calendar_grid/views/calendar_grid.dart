import 'package:attend/core/locator.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
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
    return BlocSelector<
      CalendarGridBloc,
      CalendarGridState,
      CalendarGridLoaded?
    >(
      selector: (state) => state is CalendarGridLoaded ? state : null,
      builder: (context, state) {
        if (state == null) {
          return const SizedBox.shrink();
        }
        return TableView.builder(
          rowCount: state.employees.length + 1,
          columnCount:
              DateUtils.getDaysInMonth(state.month.year, state.month.month) + 1,
          horizontalDetails: ScrollableDetails.horizontal(
            controller: ScrollController(
              initialScrollOffset: (state.month.day - 1) * _cellWidth,
            ),
          ),
          pinnedRowCount: 1,
          pinnedColumnCount: 1,
          diagonalDragBehavior: .free,
          rowBuilder: (index) {
            return _buildTableSpan(context, index, true);
          },
          columnBuilder: (index) {
            return _buildTableSpan(context, index, false);
          },
          cellBuilder: (context, vicinity) {
            if (vicinity.row == 0 && vicinity.column == 0) {
              return const TableViewCell(child: SizedBox.shrink());
            }
            if (vicinity.row == 0) {
              return TableViewCell(
                child: CalendarDay(month: state.month, vicinity: vicinity),
              );
            }
            final employee = state.employees[vicinity.row - 1];
            if (vicinity.column == 0) {
              return TableViewCell(child: _employeeNameCell(employee));
            }
            return TableViewCell(
              child: InkWell(onTap: () {}, child: const Placeholder()),
            );
          },
        );
      },
    );
  }

  Widget _employeeNameCell(Employee employee) {
    return InkWell(
      onLongPress: () {
        locator.get<HeaderPanelBloc>().add(
          HeaderPanelChangeEmployee(employee: employee),
        );
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
