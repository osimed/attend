import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridEvent {}

class LoadMonthlyCalendar extends CalendarGridEvent {
  final DateTime? month;
  final Team? team;

  LoadMonthlyCalendar({this.month, this.team});
}

class RefreshCalendarCell extends CalendarGridEvent {
  final TableVicinity cell;
  final Attendance attendance;

  RefreshCalendarCell({required this.cell, required this.attendance});
}

class CalcAttendanceDiff extends CalendarGridEvent {
  final TableVicinity cell;

  CalcAttendanceDiff({required this.cell});
}
