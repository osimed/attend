import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class HeaderPanelState {
  final bool isOpen;
  final DateTime month;

  const HeaderPanelState({required this.month, this.isOpen = false});
}

class HeaderPanelDateTime extends HeaderPanelState {
  const HeaderPanelDateTime({required super.month, super.isOpen});
}

class HeaderPanelEmployee extends HeaderPanelState {
  final Employee? employee;

  const HeaderPanelEmployee({
    required super.month,
    super.isOpen,
    this.employee,
  });
}

class HeaderPanelAttendance extends HeaderPanelState {
  final TableVicinity cell;
  final Attendance attendance;

  const HeaderPanelAttendance({
    required super.month,
    super.isOpen,
    required this.cell,
    required this.attendance,
  });
}
