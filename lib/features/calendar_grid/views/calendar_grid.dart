import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

const _cellWidth = 65.0;
const _cellHeight = 55.0;

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      rowCount: 15,
      columnCount: 15,
      pinnedRowCount: 1,
      pinnedColumnCount: 1,
      diagonalDragBehavior: .free,

      rowBuilder: (index) {
        return _buildTableSpan(context, index, true);
      },

      columnBuilder: (index) {
        return _buildTableSpan(context, index, false);
      },
      cellBuilder: (context, v) {
        return TableViewCell(
          child: InkWell(
            onTap: () {},
            child: const Placeholder(),
          ),
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
