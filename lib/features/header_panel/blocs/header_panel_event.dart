import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class HeaderPanelEvent {}

class HeaderPanelChangeDateTime extends HeaderPanelEvent {
  final DateTime? month;

  HeaderPanelChangeDateTime({this.month});
}

class HeaderPanelChangeEmployee extends HeaderPanelEvent {
  final DateTime? month;
  final Employee? employee;

  HeaderPanelChangeEmployee({this.month, this.employee});
}

class HeaderPanelChangeAttendance extends HeaderPanelEvent {
  final TableVicinity cell;
  final Attendance attendance;

  HeaderPanelChangeAttendance({required this.cell, required this.attendance});
}
