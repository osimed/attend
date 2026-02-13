import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class HeaderPanelState {
  final bool isOpen;
  final DateTime month;

  const HeaderPanelState({required this.month, this.isOpen = false});
}

class PickingAMonth extends HeaderPanelState {
  const PickingAMonth({required super.month, super.isOpen});
}

class EditingEmployee extends HeaderPanelState {
  final Employee? employee;

  const EditingEmployee({required super.month, super.isOpen, this.employee});
}

class EmployeeSaved extends EditingEmployee {
  const EmployeeSaved({required super.month, super.isOpen, super.employee});
}

class EmployeeDeleted extends EditingEmployee {
  const EmployeeDeleted({required super.month, super.isOpen, super.employee});
}

class EmployeeLaidOff extends EditingEmployee {
  const EmployeeLaidOff({required super.month, super.isOpen, super.employee});
}

class EditingAttendance extends HeaderPanelState {
  final TableVicinity cell;
  final Attendance attendance;

  const EditingAttendance({
    required super.month,
    super.isOpen,
    required this.cell,
    required this.attendance,
  });
}

class AttendanceSaved extends EditingAttendance {
  const AttendanceSaved({
    required super.month,
    super.isOpen,
    required super.cell,
    required super.attendance,
  });
}
