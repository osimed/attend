import 'package:attend/core/locator.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart'
    show TableVicinity;

class AttendService {
  final _database = locator.get<AppDatabase>();

  Future<List<EmployeeWithAttendances>> loadEmployees(DateTime month) async {
    return _database.loadAttendances(month);
  }

  Future<void> saveAttendance(Attendance attendance, TableVicinity cell) async {
    locator.get<CalendarGridBloc>().add(
      CalendarGridUpdateCell(attendance: attendance, cell: cell),
    );
    return _database.saveAttendance(attendance);
  }

  Future<void> saveEmployee(Employee employee) async {
    return _database.saveEmployee(employee);
  }

  Future<bool> deleteEmployee(Employee employee) async {
    return _database.deleteEmployee(employee);
  }
}
