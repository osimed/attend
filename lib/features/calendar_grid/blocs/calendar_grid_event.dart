import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridEvent {}

class LoadMonthlyCalendar extends CalendarGridEvent {
  final DateTime? month;

  LoadMonthlyCalendar({this.month});
}

class RefreshCalendarCell extends CalendarGridEvent {
  final TableVicinity cell;
  final Attendance attendance;

  RefreshCalendarCell({
    required this.cell,
    required this.attendance,
  });
}
