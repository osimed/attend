import 'dart:convert';
import 'dart:io' as io;

import 'package:attend/core/device_info.dart';
import 'package:uuid/uuid.dart';
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
      .ac => 'ACCOUCHEMENT',
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

  static LeaveReason? from(String? name) {
    return switch (name) {
      'resignation' => .resignation,
      'abandonment' => .abandonment,
      'termination' => .termination,
      _ => null,
    };
  }

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
  IntColumn get sap => integer().unique()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get team => textEnum<Team>()();
  TextColumn get job => text().withDefault(const Constant(''))();
  IntColumn get collected =>
      integer().map(const DurationConverter()).withDefault(const Constant(0))();
  DateTimeColumn get leaveDate => dateTime().nullable()();
  TextColumn get leaveReason => textEnum<LeaveReason>().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}

@DataClassName('ChangeLog')
class ChangeLogTable extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get table => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MonthlyBalance')
class MonthlyBalanceTable extends Table {
  IntColumn get employeeId =>
      integer().references(EmployeeTable, #id, onDelete: .cascade)();
  DateTimeColumn get month => dateTime()();
  IntColumn get closingBalence => integer().map(const DurationConverter())();

  @override
  Set<Column> get primaryKey => {employeeId, month};
}

@DataClassName('SyncCursor')
class SyncCursorTable extends Table {
  TextColumn get remoteDeviceId => text()();
  DateTimeColumn get lastSynced => dateTime()();

  @override
  Set<Column> get primaryKey => {remoteDeviceId};
}

class DurationConverter extends TypeConverter<Duration, int>
    with JsonTypeConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromSql(int fromDb) => Duration(minutes: fromDb);

  @override
  int toSql(Duration value) => value.inMinutes;

  @override
  Duration fromJson(int json) {
    return Duration(minutes: json);
  }

  @override
  int toJson(Duration value) {
    return value.inMinutes;
  }
}

class TimeOfDayConverter extends TypeConverter<TimeOfDay, int>
    with JsonTypeConverter<TimeOfDay, int> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromSql(int fromDb) =>
      TimeOfDay(hour: fromDb ~/ 60, minute: fromDb % 60);

  @override
  int toSql(TimeOfDay value) => value.hour * 60 + value.minute;

  @override
  TimeOfDay fromJson(int json) {
    return TimeOfDay(hour: json ~/ 60, minute: json % 60);
  }

  @override
  int toJson(TimeOfDay value) {
    return value.hour * 60 + value.minute;
  }
}

class CalendarRow {
  final Employee employee;
  final Map<int, Attendance> attendances;

  CalendarRow(this.employee, this.attendances);
}

@DriftDatabase(
  tables: [
    EmployeeTable,
    AttendanceTable,
    MonthlyBalanceTable,
    ChangeLogTable,
    SyncCursorTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 8;

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
      if (from < 5) {
        await m.createTable(changeLogTable);
      }
      if (from < 6) {
        await m.createTable(syncCursorTable);
      }
      if (from < 7) {
        await m.addColumn(employeeTable, employeeTable.createdAt);
      }
      if (from < 8) {
        await m.addColumn(employeeTable, employeeTable.sap);
        await m.addColumn(employeeTable, employeeTable.sortOrder);
        await m.createTable(monthlyBalanceTable);
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
    query.orderBy([OrderingTerm.asc(employeeTable.sortOrder)]);

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
    DateTime month, {
    int? employeeId,
  }) async {
    final query = select(employeeTable).join([
      leftOuterJoin(
        attendanceTable,
        attendanceTable.employeeId.equalsExp(employeeTable.id) &
            attendanceTable.date.isSmallerThanValue(month),
      ),
    ]);
    if (employeeId != null) {
      query.where(employeeTable.id.equals(employeeId));
    }
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

  Future<void> saveAttendance(Attendance attendance, {ChangeLog? log}) async {
    await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('attendance'),
            operation: const Value('save'),
            payload: Value(jsonEncode({'attendance': attendance.toJson()})),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      await attendanceTable.insertOnConflictUpdate(
        AttendanceTableCompanion(
          employeeId: Value(attendance.employeeId),
          date: Value(attendance.date),
          status: Value(attendance.status),
          enter: Value(attendance.enter),
          leave: Value(attendance.leave),
          lunchBreak: Value(attendance.lunchBreak),
        ),
      );
    });
  }

  Future<void> saveEmployee(Employee employee, {ChangeLog? log}) async {
    await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('employee'),
            operation: const Value('save'),
            payload: Value(jsonEncode({'employee': employee.toJson()})),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      employeeTable.insertOnConflictUpdate(
        EmployeeTableCompanion(
          id: employee.id != -1 ? Value(employee.id) : const Value.absent(),
          sap: Value(employee.sap),
          firstName: Value(employee.firstName),
          lastName: Value(employee.lastName),
          team: Value(employee.team),
          job: Value(employee.job),
          collected: Value(employee.collected),
          leaveDate: Value(employee.leaveDate),
          createdAt: Value(employee.createdAt),
        ),
      );
    });
  }

  Future<bool> deleteEmployee(Employee employee, {ChangeLog? log}) async {
    return await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('employee'),
            operation: const Value('delete'),
            payload: Value(jsonEncode({'employee': employee.toJson()})),
          );
      await changeLogTable.insertOnConflictUpdate(logC);
      return employeeTable.deleteOne(employee);
    });
  }

  Future<void> layoffEmployee(
    int employeeId,
    DateTime? date,
    LeaveReason? reason, {
    ChangeLog? log,
  }) async {
    await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('employee'),
            operation: const Value('layoff'),
            payload: Value(
              jsonEncode({
                'employeeId': employeeId,
                'date': date?.toIso8601String(),
                'reason': reason?.name,
              }),
            ),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      final query = employeeTable.update()
        ..where((empl) => empl.id.equals(employeeId));
      await query.write(
        EmployeeTableCompanion(
          leaveDate: Value(date),
          leaveReason: Value(reason),
        ),
      );
    });
  }

  Future<void> saveBulkAttendances(
    List<Attendance> attendances, {
    ChangeLog? log,
  }) async {
    await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('attendance'),
            operation: const Value('bulk-save'),
            payload: Value(
              jsonEncode({
                'attendances': attendances.map((a) => a.toJson()).toList(),
              }),
            ),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      for (final a in attendances) {
        if (a.status == .empty) {
          await attendanceTable.insertOnConflictUpdate(
            AttendanceTableCompanion(
              employeeId: Value(a.employeeId),
              date: Value(a.date),
              status: const Value(.empty),
              enter: const Value(null),
              leave: const Value(null),
              lunchBreak: const Value(true),
            ),
          );
        } else {
          await attendanceTable.insertOnConflictUpdate(a);
        }
      }
    });
  }

  Future<void> syncRemoteChanges(List<ChangeLog> changes) async {
    changes.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (final entry in changes) {
      final exists = await (select(
        changeLogTable,
      )..where((t) => t.id.equals(entry.id))).getSingleOrNull();
      if (exists != null) continue;

      final payload = jsonDecode(entry.payload);

      switch (entry.table) {
        case 'attendance':
          switch (entry.operation) {
            case 'save':
              final atten = Attendance.fromJson(payload["attendance"]);
              await saveAttendance(atten, log: entry);
            case 'bulk-save':
              final attens = payload["attendances"] as List;
              await saveBulkAttendances(
                attens.map((a) => Attendance.fromJson(a)).toList(),
                log: entry,
              );
          }
        case 'employee':
          switch (entry.operation) {
            case 'save':
              final empl = Employee.fromJson(payload["employee"]);
              await saveEmployee(empl, log: entry);
            case 'delete':
              final empl = Employee.fromJson(payload["employee"]);
              await deleteEmployee(empl, log: entry);
            case 'layoff':
              final emplId = payload["employeeId"] as int;
              final date = payload["date"] != null
                  ? DateTime.tryParse(payload["date"])
                  : null;
              final reason = LeaveReason.from(payload["reason"]);
              await layoffEmployee(emplId, date, reason, log: entry);
            case 'reorder':
              final empls = payload["employees"] as List;
              await reorderEmployees(
                empls.map((e) => Employee.fromJson(e)).toList(),
                log: entry,
              );
          }
        case 'monthly-balance':
          switch (entry.operation) {
            case 'save':
              final emplId = payload["employeeId"] as int;
              final month = DateTime.parse(payload["month"]);
              final balance = Duration(minutes: payload["balance"]);
              await saveMonthlyBalance(emplId, month, balance, log: entry);
          }
      }
    }
  }

  Future<List<ChangeLog>> getChangeLogs(String remoteDeviceId) async {
    final syncCursor = await (select(
      syncCursorTable,
    )..where((t) => t.remoteDeviceId.equals(remoteDeviceId))).getSingleOrNull();
    final lastSynced =
        syncCursor?.lastSynced ?? DateTime.fromMillisecondsSinceEpoch(0);

    return (select(changeLogTable)
          ..where((t) => t.timestamp.isBiggerThanValue(lastSynced))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)])
          ..limit(1000))
        .get();
  }

  Future<void> updateSyncCursor(
    String remoteDeviceId,
    DateTime lastSynced,
  ) async {
    await syncCursorTable.insertOnConflictUpdate(
      SyncCursorTableCompanion(
        remoteDeviceId: Value(remoteDeviceId),
        lastSynced: Value(lastSynced),
      ),
    );
  }

  Future<void> reorderEmployees(
    List<Employee> employees, {
    ChangeLog? log,
  }) async {
    await transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('employee'),
            operation: const Value('reorder'),
            payload: Value(
              jsonEncode({
                'employees': employees.map((a) => a.toJson()).toList(),
              }),
            ),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      for (int i = 0; i < employees.length; i++) {
        await (update(employeeTable)
              ..where((e) => e.id.equals(employees[i].id)))
            .write(EmployeeTableCompanion(sortOrder: Value(i)));
      }
    });
  }

  Future<void> saveMonthlyBalance(
    int employeeId,
    DateTime month,
    Duration balance, {
    ChangeLog? log,
  }) async {
    transaction(() async {
      // log the action
      final logC =
          log?.toCompanion(true) ??
          ChangeLogTableCompanion(
            id: Value(const Uuid().v7()),
            deviceId: Value((await deviceInfo()).$1),
            timestamp: Value(DateTime.now()),
            table: const Value('monthly-balance'),
            operation: const Value('save'),
            payload: Value(
              jsonEncode({
                'employeeId': employeeId,
                'month': month.toIso8601String(),
                'balance': balance.inMinutes,
              }),
            ),
          );
      await changeLogTable.insertOnConflictUpdate(logC);

      await monthlyBalanceTable.insertOnConflictUpdate(
        MonthlyBalanceTableCompanion(
          employeeId: Value(employeeId),
          month: Value(DateTime(month.year, month.month)),
          closingBalence: Value(balance),
        ),
      );
    });
  }

  Future<MonthlyBalance?> getLastMonthlyBalance(
    int employeeId,
    DateTime before,
  ) async {
    return (select(monthlyBalanceTable)
          ..where(
            (t) =>
                t.employeeId.equals(employeeId) &
                t.month.isSmallerThanValue(DateTime(before.year, before.month)),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.month)])
          ..limit(1))
        .getSingleOrNull();
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
