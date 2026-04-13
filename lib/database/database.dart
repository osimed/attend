import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show TimeOfDay;

part 'database.g.dart';

enum Status { empty, p, r, c, a, j, m, ac, dc }

@TableIndex(name: 'date_idx', columns: {#date})
@TableIndex(name: 'employee_id_idx', columns: {#employeeId})
@DataClassName('Attendance')
class AttendanceTable extends Table {
  IntColumn get employeeId =>
      integer().references(EmployeeTable, #id, onDelete: .cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => textEnum<Status>()();
  IntColumn get enter => integer().map(const TimeOfDayConverter()).nullable()();
  IntColumn get leave => integer().map(const TimeOfDayConverter()).nullable()();
  BoolColumn get lunchBreak => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {employeeId, date};
}

enum Team { exp, rss }

@DataClassName('Employee')
class EmployeeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get team => textEnum<Team>()();
  TextColumn get job => text().withDefault(const Constant(''))();
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(attendanceTable, attendanceTable.lunchBreak);
      }
      if (from < 3) {
        await m.addColumn(employeeTable, employeeTable.job);
      }
    },
    beforeOpen: (d) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  Future<List<CalendarRow>> loadCalendar(
    DateTime start,
    DateTime end,
    Team team,
  ) async {
    final query = select(employeeTable).join([
      leftOuterJoin(
        attendanceTable,
        attendanceTable.employeeId.equalsExp(employeeTable.id) &
            attendanceTable.date.isBetweenValues(start, end),
      ),
    ]);
    query.where(
      employeeTable.team.equalsValue(team) &
          (employeeTable.leaveDate.isNull() |
              employeeTable.leaveDate.isBiggerOrEqualValue(start)),
    );

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
    attendanceTable.insertOnConflictUpdate(
      AttendanceTableCompanion(
        employeeId: Value(attendance.employeeId),
        date: Value(attendance.date),
        status: Value(attendance.status),
        enter: Value(attendance.enter),
        leave: Value(attendance.leave),
      ),
    );
  }

  Future<void> saveEmployee(Employee employee) async {
    employeeTable.insertOnConflictUpdate(
      EmployeeTableCompanion(
        id: employee.id != -1 ? Value(employee.id) : const Value.absent(),
        firstName: Value(employee.firstName),
        lastName: Value(employee.lastName),
        team: Value(employee.team),
        collected: Value(employee.collected),
        leaveDate: Value(employee.leaveDate),
      ),
    );
  }

  Future<bool> deleteEmployee(Employee employee) async {
    return employeeTable.deleteOne(employee);
  }

  Future<void> layoffEmployee(int employeeId, DateTime? date) async {
    final query = employeeTable.update()
      ..where((empl) => empl.id.equals(employeeId));
    await query.write(EmployeeTableCompanion(leaveDate: Value(date)));
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'attend');
  }
}
