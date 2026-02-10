import 'package:attend/database/database.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

sealed class CalendarGridState {
  final DateTime month;

  const CalendarGridState({required this.month, employees});
}

class CalendarGridLoaded extends CalendarGridState {
  final List<EmployeeWithAttendances> employees;

  const CalendarGridLoaded({required super.month, required this.employees});
}

class CalendarGridUpdated extends CalendarGridState {
  final Attendance attendance;
  final TableVicinity cell;

  const CalendarGridUpdated({
    required super.month,
    required this.attendance,
    required this.cell,
  });
}
