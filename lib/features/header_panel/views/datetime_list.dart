import 'package:attend/core/extensions.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _chipWidth = 80.0;
const _chipMargin = 8.0;

class DateTimeList extends StatelessWidget {
  final DateTime month;

  const DateTimeList({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: _chipWidth + _chipMargin,
      padding: EdgeInsets.only(top: 3, bottom: 3),
      controller: ScrollController(initialScrollOffset: dateToOffset(month)),
      scrollDirection: .horizontal,
      itemBuilder: (context, index) {
        final indexDate = dateFromIndex(index);
        final selectedDate = DateTime(month.year, month.month);
        return Padding(
          padding: const EdgeInsets.only(right: _chipMargin),
          child: SizedBox(
            width: _chipWidth,
            child: FilledButton(
              onPressed: () {
                BlocProvider.of<HeaderPanelBloc>(
                  context,
                ).add(HeaderPanelChangeDateTime(month: indexDate));
              },
              style: FilledButton.styleFrom(
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      indexDate.isAtSameMomentAs(selectedDate) ? 25 : 8,
                    ),
                  ),
                ),
                backgroundColor: indexDate.isAtSameMomentAs(selectedDate)
                    ? Theme.of(context).colorScheme.tertiary
                    : null,
              ),
              child: Text(
                indexDate.formatMonth(),
                style: TextStyle(wordSpacing: -1.3),
              ),
            ),
          ),
        );
      },
    );
  }
}

const _leastYear = 2000;

double dateToOffset(DateTime month) {
  final off = 12 * (month.year - _leastYear) + (month.month - 1);
  return off * (_chipWidth + _chipMargin) - _chipMargin;
}

DateTime dateFromIndex(int index) {
  return DateTime(index ~/ 12 + _leastYear, index % 12 + 1);
}
