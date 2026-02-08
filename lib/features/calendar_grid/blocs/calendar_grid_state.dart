import 'package:attend/database/database.dart';

sealed class CalendarGridState {
  final DateTime month;

  const CalendarGridState({required this.month, employees});
}

class CalendarGridLoaded extends CalendarGridState {
  final List<Employee> employees;
  const CalendarGridLoaded({required super.month, required this.employees});
}

class CalendarGridUpdated extends CalendarGridState {
  const CalendarGridUpdated({required super.month});
}
