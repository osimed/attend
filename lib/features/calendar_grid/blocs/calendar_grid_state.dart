import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridState {
  final Team team;
  final DateTime month;
  final List<CalendarRow> calendar;

  const CalendarGridState({
    required this.team,
    required this.month,
    required this.calendar,
  });
}

/// when calendar fully loaded in a given month
class MonthlyCalendarLoaded extends CalendarGridState {
  const MonthlyCalendarLoaded({
    required super.team,
    required super.month,
    required super.calendar,
  });

  MonthlyCalendarLoaded.empty()
    : super(team: .exp, month: DateTime.now(), calendar: []);
}

/// when just one cell of the calendar needs refresh
class CalendarCellRefreshed extends CalendarGridState {
  final TableVicinity cell;

  const CalendarCellRefreshed({
    required super.team,
    required super.month,
    required super.calendar,
    required this.cell,
  });
}

class CalendarCellViewDiff extends CalendarCellRefreshed {
  final Duration diff;

  const CalendarCellViewDiff({
    required super.team,
    required super.month,
    required super.calendar,
    required super.cell,
    required this.diff,
  });
}
