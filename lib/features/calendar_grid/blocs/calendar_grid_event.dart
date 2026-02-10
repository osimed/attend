import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridEvent {}

class CalendarGridLoadMonth extends CalendarGridEvent {
  final DateTime? month;

  CalendarGridLoadMonth({this.month});
}

class CalendarGridUpdateCell extends CalendarGridEvent {
  final DateTime? month;
  final Attendance attendance;
  final TableVicinity cell;

  CalendarGridUpdateCell({
    this.month,
    required this.attendance,
    required this.cell,
  });
}
