import 'package:attend/database/database.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

String dayName(DateTime date) {
  const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  return days[date.weekday - 1];
}

class CalendarDay extends StatelessWidget {
  final DateTime month;
  final TableVicinity vicinity;

  const CalendarDay({super.key, required this.month, required this.vicinity});

  @override
  Widget build(BuildContext context) {
    final targetDate = DateTime(month.year, month.month, vicinity.column);
    final diffFromNow = DateTime.now().difference(targetDate).inHours;
    return Padding(
      padding: const EdgeInsets.only(top: 0.5, right: 0.5, bottom: 0.5),
      child: Material(
        color: diffFromNow >= 0 && diffFromNow < 24
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: () {
            context.read<HeaderPanelBloc>().add(
              BulkSelectDay(day: vicinity.column, date: targetDate),
            );
          },
          onLongPress: () {
            final empty = Attendance(
              employeeId: -1,
              date: targetDate,
              status: .empty,
              lunchBreak: true,
            );
            context.read<HeaderPanelBloc>().add(
              BulkSaveDay(
                day: vicinity.column,
                date: targetDate,
                attendance: empty,
              ),
            );
          },
          child: Center(
            child: RichText(
              text: TextSpan(
                text: '${dayName(targetDate)} ',
                children: [
                  TextSpan(
                    text: '${vicinity.column}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: .w600,
                  color: diffFromNow >= 0 && diffFromNow < 24
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
