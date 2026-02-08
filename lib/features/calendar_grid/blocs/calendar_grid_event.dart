import 'package:attend/database/database.dart';

sealed class CalendarGridEvent {}

class CalendarGridLoadMonth extends CalendarGridEvent {
  final DateTime? month;

  CalendarGridLoadMonth({this.month});
}

class CalendarGridUpdateCell extends CalendarGridEvent {
  final DateTime? month;
  final Employee? employee;

  CalendarGridUpdateCell({this.month, this.employee});
}
