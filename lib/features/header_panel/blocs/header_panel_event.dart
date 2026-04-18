import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class HeaderPanelEvent {}

class CloseHeaderPanel extends HeaderPanelEvent {}

class SeekToMonth extends HeaderPanelEvent {
  final DateTime? picked;

  SeekToMonth({this.picked});
}

class SelectEmployee extends HeaderPanelEvent {
  final Employee? employee;

  SelectEmployee({this.employee});
}

class SaveEmployee extends HeaderPanelEvent {
  final Employee employee;

  SaveEmployee(this.employee);
}

class DeleteEmployee extends HeaderPanelEvent {
  final Employee employee;

  DeleteEmployee(this.employee);
}

class LayoffEmployee extends HeaderPanelEvent {
  final int employeeId;
  final DateTime? left;
  final LeaveReason? reason;

  LayoffEmployee({
    required this.employeeId,
    required this.left,
    required this.reason,
  });
}

class SelectAttendance extends HeaderPanelEvent {
  final TableVicinity cell;
  final Attendance attendance;

  SelectAttendance({required this.cell, required this.attendance});
}

class SaveAttendance extends HeaderPanelEvent {
  final TableVicinity cell;
  final Attendance attendance;

  SaveAttendance({required this.cell, required this.attendance});
}

class BulkSelectDay extends HeaderPanelEvent {
  final int day;
  final DateTime date;

  BulkSelectDay({required this.day, required this.date});
}

class BulkSaveDay extends HeaderPanelEvent {
  final int day;
  final DateTime date;
  final Attendance attendance;

  BulkSaveDay({
    required this.day,
    required this.date,
    required this.attendance,
  });
}
