import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class HeaderPanelEvent {}

class SeekToMonth extends HeaderPanelEvent {
  final DateTime? picked;

  SeekToMonth({this.picked});
}

class SelectEmployee extends HeaderPanelEvent {
  final Employee? employee;

  SelectEmployee({this.employee});
}

class ConfirmSaveEmployee extends HeaderPanelEvent {
  final Employee employee;

  ConfirmSaveEmployee(this.employee);
}

class ConfirmDeleteEmployee extends HeaderPanelEvent {
  final Employee employee;

  ConfirmDeleteEmployee(this.employee);
}

class SaveAttendance extends HeaderPanelEvent {
  final TableVicinity cell;
  final Attendance attendance;

  SaveAttendance({required this.cell, required this.attendance});
}
