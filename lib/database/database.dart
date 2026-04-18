import 'dart:io' as io;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show TimeOfDay, Color, Colors;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

enum Status {
  empty,
  p,
  r,
  c,
  a,
  j,
  m,
  ac,
  dc;

  String get fullname {
    return switch (this) {
      .r => 'RÉCUP',
      .c => 'CONGÉ',
      .a => 'ABSENCE',
      .j => 'JOUR FÉRIÉ',
      .m => 'MALADIE',
      .ac => 'ACC. TRAVAIL',
      .dc => 'DÉCÈS',
      _ => '',
    };
  }

  double dayValue(DateTime day) {
    if (this == .r || this == .c) {
      return day.weekday == DateTime.saturday ? 0.5 : 1;
    }
    return 0;
  }

  Color? get color {
    return switch (this) {
      .c => Colors.redAccent.shade100,
      .a => Colors.amber,
      .r => Colors.tealAccent.shade700,
      .j => Colors.blueAccent.shade100,
      .m => Colors.lime.shade600,
      .ac => Colors.pink.shade200,
      .dc => Colors.brown.shade200,
      _ => null,
    };
  }
}

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

enum Team {
  exp,
  rss;

  String get fullname {
    return switch (this) {
      .exp => 'Expédition',
      .rss => 'Rassemblement',
    };
  }
}

enum LeaveReason {
  resignation,
  termination,
  abandonment;

  String get fullname {
    return switch (this) {
      .resignation => 'DÉMISSION',
      .abandonment => 'ABANDON DE POSTE',
      .termination => 'ARRÊT DU CONTRAT',
    };
  }
}

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
  TextColumn get leaveReason => textEnum<LeaveReason>().nullable()();
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
  int get schemaVersion => 4;

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
      if (from < 4) {
        await m.addColumn(employeeTable, employeeTable.leaveReason);
        final stmt = """
          UPDATE employee_table SET leave_reason = 'resignation'
          WHERE leave_date IS NOT NULL
        """;
        await customStatement(stmt);
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

  Future<Map<int, List<Attendance>>> getAttendancesUpToMonth(
    Team team,
    DateTime month,
  ) async {
    final query = select(employeeTable).join([
      leftOuterJoin(
        attendanceTable,
        attendanceTable.employeeId.equalsExp(employeeTable.id) &
            attendanceTable.date.isSmallerThanValue(month),
      ),
    ]);
    query.where(employeeTable.team.equalsValue(team));

    final result = await query.get();
    final attns = <int, List<Attendance>>{};

    for (final row in result) {
      final empl = row.readTable(employeeTable);
      final attn = row.readTableOrNull(attendanceTable);

      final entry = attns.putIfAbsent(empl.id, () => []);
      if (attn != null) entry.add(attn);
    }
    return attns;
  }

  Future<void> saveAttendance(Attendance attendance) async {
    attendanceTable.insertOnConflictUpdate(
      AttendanceTableCompanion(
        employeeId: Value(attendance.employeeId),
        date: Value(attendance.date),
        status: Value(attendance.status),
        enter: Value(attendance.enter),
        leave: Value(attendance.leave),
        lunchBreak: Value(attendance.lunchBreak),
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
        job: Value(employee.job),
        collected: Value(employee.collected),
        leaveDate: Value(employee.leaveDate),
      ),
    );
  }

  Future<bool> deleteEmployee(Employee employee) async {
    return employeeTable.deleteOne(employee);
  }

  Future<void> layoffEmployee(
    int employeeId,
    DateTime? date,
    LeaveReason? reason,
  ) async {
    final query = employeeTable.update()
      ..where((empl) => empl.id.equals(employeeId));
    await query.write(
      EmployeeTableCompanion(
        leaveDate: Value(date),
        leaveReason: Value(reason),
      ),
    );
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final newDir = await getApplicationSupportDirectory();
      final newFile = io.File(join(newDir.path, 'attend.db'));
      if (!await newFile.exists()) {
        final oldDir = await getApplicationDocumentsDirectory();
        final oldFile = io.File(join(oldDir.path, 'attend.db'));
        if (await oldFile.exists()) {
          await oldFile.copy(newFile.path);
          await oldFile.delete();
        }
      }
      return NativeDatabase(newFile);
    });
  }
}
