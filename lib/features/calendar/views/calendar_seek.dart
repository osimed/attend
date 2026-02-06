import 'package:attend/core/extensions.dart';
import 'package:attend/features/calendar/blocs/calendar_bloc.dart';
import 'package:attend/features/calendar/blocs/calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _chipWidth = 80.0;
const _chipMargin = 8.0;

class CalendarSeekList extends StatelessWidget {
  final DateTime month;

  const CalendarSeekList({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: _chipWidth + _chipMargin,
      padding: EdgeInsets.only(top: 3, bottom: 3),
      controller: ScrollController(initialScrollOffset: dateToOffset(month)),
      scrollDirection: .horizontal,
      itemBuilder: (context, index) {
        final date = dateFromIndex(index);
        final targetDate = DateTime(month.year, month.month);
        return Padding(
          padding: const EdgeInsets.only(right: _chipMargin),
          child: SizedBox(
            width: _chipWidth,
            child: FilledButton(
              onPressed: () {
                BlocProvider.of<CalendarBloc>(
                  context,
                ).add(CalendarSeek(month: date));
              },
              style: FilledButton.styleFrom(
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(date.isAtSameMomentAs(targetDate) ? 25 : 8),
                  ),
                ),
                backgroundColor: date.isAtSameMomentAs(targetDate)
                    ? Theme.of(context).colorScheme.tertiary
                    : null,
              ),
              child: Text(
                date.formatMonth(),
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

DateTime dateFromIndex(int idx) {
  return DateTime(idx ~/ 12 + _leastYear, idx % 12 + 1);
}
