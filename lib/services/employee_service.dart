import 'package:attend/core/locator.dart';
import 'package:attend/database/database.dart';
import 'package:drift/drift.dart';

class EmployeeService {
  final _database = locator.get<AppDatabase>();

  Future<List<Employee>> loadEmployees() async {
    return _database.employeeTable.select().get();
  }

  Future<void> insertEmployee(Employee employee) async {
    _database.employeeTable.insertOne(
      EmployeeTableCompanion(
        id: employee.id != -1 ? Value(employee.id) : const Value.absent(),
        firstName: Value(employee.firstName),
        lastName: Value(employee.lastName),
        team: Value(employee.team),
        collected: Value(employee.collected),
      ),
      mode: .insertOrReplace,
    );
  }
}
