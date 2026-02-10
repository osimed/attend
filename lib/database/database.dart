import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show TimeOfDay;

part 'database.g.dart';

enum Status { empty, p, r, c, a, j, m, ac, dc }

@TableIndex(name: 'date_idx', columns: {#date})
@TableIndex(name: 'employee_id_idx', columns: {#employeeId})
@DataClassName('Attendance')
class AttendanceTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employeeId => integer().references(EmployeeTable, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => textEnum<Status>()();
  IntColumn get enter => integer().map(const TimeOfDayConverter()).nullable()();
  IntColumn get leave => integer().map(const TimeOfDayConverter()).nullable()();
}

enum Team { exp, rss }

@DataClassName('Employee')
class EmployeeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get team => textEnum<Team>()();
  IntColumn get collected =>
      integer().map(const DurationConverter()).withDefault(const Constant(0))();
  DateTimeColumn get leaveDate => dateTime().nullable()();
}

class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromSql(int fromDb) => Duration(minutes: fromDb);

  @override
  int toSql(Duration value) => value.inMinutes;
}

class TimeOfDayConverter extends TypeConverter<TimeOfDay, int> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromSql(int fromDb) =>
      TimeOfDay(hour: fromDb ~/ 60, minute: fromDb % 60);

  @override
  int toSql(TimeOfDay value) => value.hour * 60 + value.minute;
}

class CalendarRow {
  final Employee employee;
  final Map<int, Attendance> attendances;

  CalendarRow(this.employee, this.attendances);
}

@DriftDatabase(tables: [EmployeeTable, AttendanceTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<CalendarRow>> loadCalendar(DateTime start, DateTime end) async {
    final query = select(employeeTable).join([
      leftOuterJoin(
        attendanceTable,
        attendanceTable.employeeId.equalsExp(employeeTable.id) &
            attendanceTable.date.isBetweenValues(start, end),
      ),
    ]);

    final result = await query.get();
    final calendar = <int, CalendarRow>{};

    for (final row in result) {
      final empl = row.readTable(employeeTable);
      final attn = row.readTableOrNull(attendanceTable);

      CalendarRow calRow() => CalendarRow(empl, {});
      final entry = calendar.putIfAbsent(empl.id, calRow);
      if (attn != null) {
        entry.attendances[attn.date.day] = attn;
      }
    }
    return calendar.values.toList();
  }

  Future<void> saveAttendance(Attendance attendance) async {
    attendanceTable.insertOne(
      AttendanceTableCompanion(
        id: attendance.id != -1 ? Value(attendance.id) : const Value.absent(),
        employeeId: Value(attendance.employeeId),
        date: Value(attendance.date),
        status: Value(attendance.status),
        enter: Value(attendance.enter),
        leave: Value(attendance.leave),
      ),
      mode: .insertOrReplace,
    );
  }

  Future<void> saveEmployee(Employee employee) async {
    employeeTable.insertOne(
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

  Future<bool> deleteEmployee(Employee employee) async {
    return employeeTable.deleteOne(employee);
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'attend');
  }
}
