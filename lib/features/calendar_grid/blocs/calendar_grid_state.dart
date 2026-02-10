import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridState {
  final DateTime month;
  final List<CalendarRow> calendar;

  const CalendarGridState({required this.month, required this.calendar});
}

/// when calendar fully loaded in a given month
class MonthlyCalendarLoaded extends CalendarGridState {
  const MonthlyCalendarLoaded({required super.month, required super.calendar});

  MonthlyCalendarLoaded.empty() : super(month: DateTime.now(), calendar: []);
}

/// when just one cell of the calendar needs refresh
class CalendarCellRefreshed extends CalendarGridState {
  final TableVicinity cell;

  const CalendarCellRefreshed({
    required super.month,
    required super.calendar,
    required this.cell,
  });
}
