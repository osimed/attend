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

@DriftDatabase(tables: [EmployeeTable, AttendanceTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'attend');
  }
}
