// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EmployeeTableTable extends EmployeeTable
    with TableInfo<$EmployeeTableTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Team, String> team =
      GeneratedColumn<String>(
        'team',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Team>($EmployeeTableTable.$converterteam);
  static const VerificationMeta _jobMeta = const VerificationMeta('job');
  @override
  late final GeneratedColumn<String> job = GeneratedColumn<String>(
    'job',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> collected =
      GeneratedColumn<int>(
        'collected',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Duration>($EmployeeTableTable.$convertercollected);
  static const VerificationMeta _leaveDateMeta = const VerificationMeta(
    'leaveDate',
  );
  @override
  late final GeneratedColumn<DateTime> leaveDate = GeneratedColumn<DateTime>(
    'leave_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LeaveReason?, String>
  leaveReason = GeneratedColumn<String>(
    'leave_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<LeaveReason?>($EmployeeTableTable.$converterleaveReasonn);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    team,
    job,
    collected,
    leaveDate,
    leaveReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('job')) {
      context.handle(
        _jobMeta,
        job.isAcceptableOrUnknown(data['job']!, _jobMeta),
      );
    }
    if (data.containsKey('leave_date')) {
      context.handle(
        _leaveDateMeta,
        leaveDate.isAcceptableOrUnknown(data['leave_date']!, _leaveDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      team: $EmployeeTableTable.$converterteam.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}team'],
        )!,
      ),
      job: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job'],
      )!,
      collected: $EmployeeTableTable.$convertercollected.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}collected'],
        )!,
      ),
      leaveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}leave_date'],
      ),
      leaveReason: $EmployeeTableTable.$converterleaveReasonn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}leave_reason'],
        ),
      ),
    );
  }

  @override
  $EmployeeTableTable createAlias(String alias) {
    return $EmployeeTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Team, String, String> $converterteam =
      const EnumNameConverter<Team>(Team.values);
  static TypeConverter<Duration, int> $convertercollected =
      const DurationConverter();
  static JsonTypeConverter2<LeaveReason, String, String> $converterleaveReason =
      const EnumNameConverter<LeaveReason>(LeaveReason.values);
  static JsonTypeConverter2<LeaveReason?, String?, String?>
  $converterleaveReasonn = JsonTypeConverter2.asNullable($converterleaveReason);
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String firstName;
  final String lastName;
  final Team team;
  final String job;
  final Duration collected;
  final DateTime? leaveDate;
  final LeaveReason? leaveReason;
  const Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.team,
    required this.job,
    required this.collected,
    this.leaveDate,
    this.leaveReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    {
      map['team'] = Variable<String>(
        $EmployeeTableTable.$converterteam.toSql(team),
      );
    }
    map['job'] = Variable<String>(job);
    {
      map['collected'] = Variable<int>(
        $EmployeeTableTable.$convertercollected.toSql(collected),
      );
    }
    if (!nullToAbsent || leaveDate != null) {
      map['leave_date'] = Variable<DateTime>(leaveDate);
    }
    if (!nullToAbsent || leaveReason != null) {
      map['leave_reason'] = Variable<String>(
        $EmployeeTableTable.$converterleaveReasonn.toSql(leaveReason),
      );
    }
    return map;
  }

  EmployeeTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeeTableCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      team: Value(team),
      job: Value(job),
      collected: Value(collected),
      leaveDate: leaveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(leaveDate),
      leaveReason: leaveReason == null && nullToAbsent
          ? const Value.absent()
          : Value(leaveReason),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      team: $EmployeeTableTable.$converterteam.fromJson(
        serializer.fromJson<String>(json['team']),
      ),
      job: serializer.fromJson<String>(json['job']),
      collected: serializer.fromJson<Duration>(json['collected']),
      leaveDate: serializer.fromJson<DateTime?>(json['leaveDate']),
      leaveReason: $EmployeeTableTable.$converterleaveReasonn.fromJson(
        serializer.fromJson<String?>(json['leaveReason']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'team': serializer.toJson<String>(
        $EmployeeTableTable.$converterteam.toJson(team),
      ),
      'job': serializer.toJson<String>(job),
      'collected': serializer.toJson<Duration>(collected),
      'leaveDate': serializer.toJson<DateTime?>(leaveDate),
      'leaveReason': serializer.toJson<String?>(
        $EmployeeTableTable.$converterleaveReasonn.toJson(leaveReason),
      ),
    };
  }

  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    Team? team,
    String? job,
    Duration? collected,
    Value<DateTime?> leaveDate = const Value.absent(),
    Value<LeaveReason?> leaveReason = const Value.absent(),
  }) => Employee(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    team: team ?? this.team,
    job: job ?? this.job,
    collected: collected ?? this.collected,
    leaveDate: leaveDate.present ? leaveDate.value : this.leaveDate,
    leaveReason: leaveReason.present ? leaveReason.value : this.leaveReason,
  );
  Employee copyWithCompanion(EmployeeTableCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      team: data.team.present ? data.team.value : this.team,
      job: data.job.present ? data.job.value : this.job,
      collected: data.collected.present ? data.collected.value : this.collected,
      leaveDate: data.leaveDate.present ? data.leaveDate.value : this.leaveDate,
      leaveReason: data.leaveReason.present
          ? data.leaveReason.value
          : this.leaveReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('team: $team, ')
          ..write('job: $job, ')
          ..write('collected: $collected, ')
          ..write('leaveDate: $leaveDate, ')
          ..write('leaveReason: $leaveReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    team,
    job,
    collected,
    leaveDate,
    leaveReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.team == this.team &&
          other.job == this.job &&
          other.collected == this.collected &&
          other.leaveDate == this.leaveDate &&
          other.leaveReason == this.leaveReason);
}

class EmployeeTableCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<Team> team;
  final Value<String> job;
  final Value<Duration> collected;
  final Value<DateTime?> leaveDate;
  final Value<LeaveReason?> leaveReason;
  const EmployeeTableCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.team = const Value.absent(),
    this.job = const Value.absent(),
    this.collected = const Value.absent(),
    this.leaveDate = const Value.absent(),
    this.leaveReason = const Value.absent(),
  });
  EmployeeTableCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required Team team,
    this.job = const Value.absent(),
    this.collected = const Value.absent(),
    this.leaveDate = const Value.absent(),
    this.leaveReason = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       team = Value(team);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? team,
    Expression<String>? job,
    Expression<int>? collected,
    Expression<DateTime>? leaveDate,
    Expression<String>? leaveReason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (team != null) 'team': team,
      if (job != null) 'job': job,
      if (collected != null) 'collected': collected,
      if (leaveDate != null) 'leave_date': leaveDate,
      if (leaveReason != null) 'leave_reason': leaveReason,
    });
  }

  EmployeeTableCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<Team>? team,
    Value<String>? job,
    Value<Duration>? collected,
    Value<DateTime?>? leaveDate,
    Value<LeaveReason?>? leaveReason,
  }) {
    return EmployeeTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      team: team ?? this.team,
      job: job ?? this.job,
      collected: collected ?? this.collected,
      leaveDate: leaveDate ?? this.leaveDate,
      leaveReason: leaveReason ?? this.leaveReason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (team.present) {
      map['team'] = Variable<String>(
        $EmployeeTableTable.$converterteam.toSql(team.value),
      );
    }
    if (job.present) {
      map['job'] = Variable<String>(job.value);
    }
    if (collected.present) {
      map['collected'] = Variable<int>(
        $EmployeeTableTable.$convertercollected.toSql(collected.value),
      );
    }
    if (leaveDate.present) {
      map['leave_date'] = Variable<DateTime>(leaveDate.value);
    }
    if (leaveReason.present) {
      map['leave_reason'] = Variable<String>(
        $EmployeeTableTable.$converterleaveReasonn.toSql(leaveReason.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('team: $team, ')
          ..write('job: $job, ')
          ..write('collected: $collected, ')
          ..write('leaveDate: $leaveDate, ')
          ..write('leaveReason: $leaveReason')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTableTable extends AttendanceTable
    with TableInfo<$AttendanceTableTable, Attendance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employee_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Status>($AttendanceTableTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay?, int> enter =
      GeneratedColumn<int>(
        'enter',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<TimeOfDay?>($AttendanceTableTable.$converterentern);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay?, int> leave =
      GeneratedColumn<int>(
        'leave',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<TimeOfDay?>($AttendanceTableTable.$converterleaven);
  static const VerificationMeta _lunchBreakMeta = const VerificationMeta(
    'lunchBreak',
  );
  @override
  late final GeneratedColumn<bool> lunchBreak = GeneratedColumn<bool>(
    'lunch_break',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("lunch_break" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    employeeId,
    date,
    status,
    enter,
    leave,
    lunchBreak,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attendance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('lunch_break')) {
      context.handle(
        _lunchBreakMeta,
        lunchBreak.isAcceptableOrUnknown(data['lunch_break']!, _lunchBreakMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, date};
  @override
  Attendance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attendance(
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      status: $AttendanceTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      enter: $AttendanceTableTable.$converterentern.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}enter'],
        ),
      ),
      leave: $AttendanceTableTable.$converterleaven.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}leave'],
        ),
      ),
      lunchBreak: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}lunch_break'],
      )!,
    );
  }

  @override
  $AttendanceTableTable createAlias(String alias) {
    return $AttendanceTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
  static TypeConverter<TimeOfDay, int> $converterenter =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay?, int?> $converterentern =
      NullAwareTypeConverter.wrap($converterenter);
  static TypeConverter<TimeOfDay, int> $converterleave =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay?, int?> $converterleaven =
      NullAwareTypeConverter.wrap($converterleave);
}

class Attendance extends DataClass implements Insertable<Attendance> {
  final int employeeId;
  final DateTime date;
  final Status status;
  final TimeOfDay? enter;
  final TimeOfDay? leave;
  final bool lunchBreak;
  const Attendance({
    required this.employeeId,
    required this.date,
    required this.status,
    this.enter,
    this.leave,
    required this.lunchBreak,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<int>(employeeId);
    map['date'] = Variable<DateTime>(date);
    {
      map['status'] = Variable<String>(
        $AttendanceTableTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || enter != null) {
      map['enter'] = Variable<int>(
        $AttendanceTableTable.$converterentern.toSql(enter),
      );
    }
    if (!nullToAbsent || leave != null) {
      map['leave'] = Variable<int>(
        $AttendanceTableTable.$converterleaven.toSql(leave),
      );
    }
    map['lunch_break'] = Variable<bool>(lunchBreak);
    return map;
  }

  AttendanceTableCompanion toCompanion(bool nullToAbsent) {
    return AttendanceTableCompanion(
      employeeId: Value(employeeId),
      date: Value(date),
      status: Value(status),
      enter: enter == null && nullToAbsent
          ? const Value.absent()
          : Value(enter),
      leave: leave == null && nullToAbsent
          ? const Value.absent()
          : Value(leave),
      lunchBreak: Value(lunchBreak),
    );
  }

  factory Attendance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attendance(
      employeeId: serializer.fromJson<int>(json['employeeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: $AttendanceTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      enter: serializer.fromJson<TimeOfDay?>(json['enter']),
      leave: serializer.fromJson<TimeOfDay?>(json['leave']),
      lunchBreak: serializer.fromJson<bool>(json['lunchBreak']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<int>(employeeId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(
        $AttendanceTableTable.$converterstatus.toJson(status),
      ),
      'enter': serializer.toJson<TimeOfDay?>(enter),
      'leave': serializer.toJson<TimeOfDay?>(leave),
      'lunchBreak': serializer.toJson<bool>(lunchBreak),
    };
  }

  Attendance copyWith({
    int? employeeId,
    DateTime? date,
    Status? status,
    Value<TimeOfDay?> enter = const Value.absent(),
    Value<TimeOfDay?> leave = const Value.absent(),
    bool? lunchBreak,
  }) => Attendance(
    employeeId: employeeId ?? this.employeeId,
    date: date ?? this.date,
    status: status ?? this.status,
    enter: enter.present ? enter.value : this.enter,
    leave: leave.present ? leave.value : this.leave,
    lunchBreak: lunchBreak ?? this.lunchBreak,
  );
  Attendance copyWithCompanion(AttendanceTableCompanion data) {
    return Attendance(
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      enter: data.enter.present ? data.enter.value : this.enter,
      leave: data.leave.present ? data.leave.value : this.leave,
      lunchBreak: data.lunchBreak.present
          ? data.lunchBreak.value
          : this.lunchBreak,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attendance(')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('enter: $enter, ')
          ..write('leave: $leave, ')
          ..write('lunchBreak: $lunchBreak')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(employeeId, date, status, enter, leave, lunchBreak);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attendance &&
          other.employeeId == this.employeeId &&
          other.date == this.date &&
          other.status == this.status &&
          other.enter == this.enter &&
          other.leave == this.leave &&
          other.lunchBreak == this.lunchBreak);
}

class AttendanceTableCompanion extends UpdateCompanion<Attendance> {
  final Value<int> employeeId;
  final Value<DateTime> date;
  final Value<Status> status;
  final Value<TimeOfDay?> enter;
  final Value<TimeOfDay?> leave;
  final Value<bool> lunchBreak;
  final Value<int> rowid;
  const AttendanceTableCompanion({
    this.employeeId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.enter = const Value.absent(),
    this.leave = const Value.absent(),
    this.lunchBreak = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceTableCompanion.insert({
    required int employeeId,
    required DateTime date,
    required Status status,
    this.enter = const Value.absent(),
    this.leave = const Value.absent(),
    this.lunchBreak = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : employeeId = Value(employeeId),
       date = Value(date),
       status = Value(status);
  static Insertable<Attendance> custom({
    Expression<int>? employeeId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<int>? enter,
    Expression<int>? leave,
    Expression<bool>? lunchBreak,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (enter != null) 'enter': enter,
      if (leave != null) 'leave': leave,
      if (lunchBreak != null) 'lunch_break': lunchBreak,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceTableCompanion copyWith({
    Value<int>? employeeId,
    Value<DateTime>? date,
    Value<Status>? status,
    Value<TimeOfDay?>? enter,
    Value<TimeOfDay?>? leave,
    Value<bool>? lunchBreak,
    Value<int>? rowid,
  }) {
    return AttendanceTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      status: status ?? this.status,
      enter: enter ?? this.enter,
      leave: leave ?? this.leave,
      lunchBreak: lunchBreak ?? this.lunchBreak,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $AttendanceTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (enter.present) {
      map['enter'] = Variable<int>(
        $AttendanceTableTable.$converterentern.toSql(enter.value),
      );
    }
    if (leave.present) {
      map['leave'] = Variable<int>(
        $AttendanceTableTable.$converterleaven.toSql(leave.value),
      );
    }
    if (lunchBreak.present) {
      map['lunch_break'] = Variable<bool>(lunchBreak.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('enter: $enter, ')
          ..write('leave: $leave, ')
          ..write('lunchBreak: $lunchBreak, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmployeeTableTable employeeTable = $EmployeeTableTable(this);
  late final $AttendanceTableTable attendanceTable = $AttendanceTableTable(
    this,
  );
  late final Index dateIdx = Index(
    'date_idx',
    'CREATE INDEX date_idx ON attendance_table (date)',
  );
  late final Index employeeIdIdx = Index(
    'employee_id_idx',
    'CREATE INDEX employee_id_idx ON attendance_table (employee_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    employeeTable,
    attendanceTable,
    dateIdx,
    employeeIdIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'employee_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$EmployeeTableTableCreateCompanionBuilder =
    EmployeeTableCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required Team team,
      Value<String> job,
      Value<Duration> collected,
      Value<DateTime?> leaveDate,
      Value<LeaveReason?> leaveReason,
    });
typedef $$EmployeeTableTableUpdateCompanionBuilder =
    EmployeeTableCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<Team> team,
      Value<String> job,
      Value<Duration> collected,
      Value<DateTime?> leaveDate,
      Value<LeaveReason?> leaveReason,
    });

final class $$EmployeeTableTableReferences
    extends BaseReferences<_$AppDatabase, $EmployeeTableTable, Employee> {
  $$EmployeeTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AttendanceTableTable, List<Attendance>>
  _attendanceTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendanceTable,
    aliasName: $_aliasNameGenerator(
      db.employeeTable.id,
      db.attendanceTable.employeeId,
    ),
  );

  $$AttendanceTableTableProcessedTableManager get attendanceTableRefs {
    final manager = $$AttendanceTableTableTableManager(
      $_db,
      $_db.attendanceTable,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmployeeTableTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Team, Team, String> get team =>
      $composableBuilder(
        column: $table.team,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Duration, Duration, int> get collected =>
      $composableBuilder(
        column: $table.collected,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get leaveDate => $composableBuilder(
    column: $table.leaveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LeaveReason?, LeaveReason, String>
  get leaveReason => $composableBuilder(
    column: $table.leaveReason,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> attendanceTableRefs(
    Expression<bool> Function($$AttendanceTableTableFilterComposer f) f,
  ) {
    final $$AttendanceTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceTable,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableTableFilterComposer(
            $db: $db,
            $table: $db.attendanceTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get team => $composableBuilder(
    column: $table.team,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collected => $composableBuilder(
    column: $table.collected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get leaveDate => $composableBuilder(
    column: $table.leaveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leaveReason => $composableBuilder(
    column: $table.leaveReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Team, String> get team =>
      $composableBuilder(column: $table.team, builder: (column) => column);

  GeneratedColumn<String> get job =>
      $composableBuilder(column: $table.job, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Duration, int> get collected =>
      $composableBuilder(column: $table.collected, builder: (column) => column);

  GeneratedColumn<DateTime> get leaveDate =>
      $composableBuilder(column: $table.leaveDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LeaveReason?, String> get leaveReason =>
      $composableBuilder(
        column: $table.leaveReason,
        builder: (column) => column,
      );

  Expression<T> attendanceTableRefs<T extends Object>(
    Expression<T> Function($$AttendanceTableTableAnnotationComposer a) f,
  ) {
    final $$AttendanceTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceTable,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableTableAnnotationComposer(
            $db: $db,
            $table: $db.attendanceTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeeTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeeTableTable,
          Employee,
          $$EmployeeTableTableFilterComposer,
          $$EmployeeTableTableOrderingComposer,
          $$EmployeeTableTableAnnotationComposer,
          $$EmployeeTableTableCreateCompanionBuilder,
          $$EmployeeTableTableUpdateCompanionBuilder,
          (Employee, $$EmployeeTableTableReferences),
          Employee,
          PrefetchHooks Function({bool attendanceTableRefs})
        > {
  $$EmployeeTableTableTableManager(_$AppDatabase db, $EmployeeTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<Team> team = const Value.absent(),
                Value<String> job = const Value.absent(),
                Value<Duration> collected = const Value.absent(),
                Value<DateTime?> leaveDate = const Value.absent(),
                Value<LeaveReason?> leaveReason = const Value.absent(),
              }) => EmployeeTableCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                team: team,
                job: job,
                collected: collected,
                leaveDate: leaveDate,
                leaveReason: leaveReason,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required Team team,
                Value<String> job = const Value.absent(),
                Value<Duration> collected = const Value.absent(),
                Value<DateTime?> leaveDate = const Value.absent(),
                Value<LeaveReason?> leaveReason = const Value.absent(),
              }) => EmployeeTableCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                team: team,
                job: job,
                collected: collected,
                leaveDate: leaveDate,
                leaveReason: leaveReason,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmployeeTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({attendanceTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (attendanceTableRefs) db.attendanceTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attendanceTableRefs)
                    await $_getPrefetchedData<
                      Employee,
                      $EmployeeTableTable,
                      Attendance
                    >(
                      currentTable: table,
                      referencedTable: $$EmployeeTableTableReferences
                          ._attendanceTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EmployeeTableTableReferences(
                            db,
                            table,
                            p0,
                          ).attendanceTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.employeeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EmployeeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeeTableTable,
      Employee,
      $$EmployeeTableTableFilterComposer,
      $$EmployeeTableTableOrderingComposer,
      $$EmployeeTableTableAnnotationComposer,
      $$EmployeeTableTableCreateCompanionBuilder,
      $$EmployeeTableTableUpdateCompanionBuilder,
      (Employee, $$EmployeeTableTableReferences),
      Employee,
      PrefetchHooks Function({bool attendanceTableRefs})
    >;
typedef $$AttendanceTableTableCreateCompanionBuilder =
    AttendanceTableCompanion Function({
      required int employeeId,
      required DateTime date,
      required Status status,
      Value<TimeOfDay?> enter,
      Value<TimeOfDay?> leave,
      Value<bool> lunchBreak,
      Value<int> rowid,
    });
typedef $$AttendanceTableTableUpdateCompanionBuilder =
    AttendanceTableCompanion Function({
      Value<int> employeeId,
      Value<DateTime> date,
      Value<Status> status,
      Value<TimeOfDay?> enter,
      Value<TimeOfDay?> leave,
      Value<bool> lunchBreak,
      Value<int> rowid,
    });

final class $$AttendanceTableTableReferences
    extends BaseReferences<_$AppDatabase, $AttendanceTableTable, Attendance> {
  $$AttendanceTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EmployeeTableTable _employeeIdTable(_$AppDatabase db) =>
      db.employeeTable.createAlias(
        $_aliasNameGenerator(
          db.attendanceTable.employeeId,
          db.employeeTable.id,
        ),
      );

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<int>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager(
      $_db,
      $_db.employeeTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay?, TimeOfDay, int> get enter =>
      $composableBuilder(
        column: $table.enter,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TimeOfDay?, TimeOfDay, int> get leave =>
      $composableBuilder(
        column: $table.leave,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get lunchBreak => $composableBuilder(
    column: $table.lunchBreak,
    builder: (column) => ColumnFilters(column),
  );

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeTableTableFilterComposer(
            $db: $db,
            $table: $db.employeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enter => $composableBuilder(
    column: $table.enter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leave => $composableBuilder(
    column: $table.leave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lunchBreak => $composableBuilder(
    column: $table.lunchBreak,
    builder: (column) => ColumnOrderings(column),
  );

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeTableTableOrderingComposer(
            $db: $db,
            $table: $db.employeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Status, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDay?, int> get enter =>
      $composableBuilder(column: $table.enter, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDay?, int> get leave =>
      $composableBuilder(column: $table.leave, builder: (column) => column);

  GeneratedColumn<bool> get lunchBreak => $composableBuilder(
    column: $table.lunchBreak,
    builder: (column) => column,
  );

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.employeeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTableTable,
          Attendance,
          $$AttendanceTableTableFilterComposer,
          $$AttendanceTableTableOrderingComposer,
          $$AttendanceTableTableAnnotationComposer,
          $$AttendanceTableTableCreateCompanionBuilder,
          $$AttendanceTableTableUpdateCompanionBuilder,
          (Attendance, $$AttendanceTableTableReferences),
          Attendance,
          PrefetchHooks Function({bool employeeId})
        > {
  $$AttendanceTableTableTableManager(
    _$AppDatabase db,
    $AttendanceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> employeeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<Status> status = const Value.absent(),
                Value<TimeOfDay?> enter = const Value.absent(),
                Value<TimeOfDay?> leave = const Value.absent(),
                Value<bool> lunchBreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceTableCompanion(
                employeeId: employeeId,
                date: date,
                status: status,
                enter: enter,
                leave: leave,
                lunchBreak: lunchBreak,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int employeeId,
                required DateTime date,
                required Status status,
                Value<TimeOfDay?> enter = const Value.absent(),
                Value<TimeOfDay?> leave = const Value.absent(),
                Value<bool> lunchBreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceTableCompanion.insert(
                employeeId: employeeId,
                date: date,
                status: status,
                enter: enter,
                leave: leave,
                lunchBreak: lunchBreak,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttendanceTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (employeeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.employeeId,
                                referencedTable:
                                    $$AttendanceTableTableReferences
                                        ._employeeIdTable(db),
                                referencedColumn:
                                    $$AttendanceTableTableReferences
                                        ._employeeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTableTable,
      Attendance,
      $$AttendanceTableTableFilterComposer,
      $$AttendanceTableTableOrderingComposer,
      $$AttendanceTableTableAnnotationComposer,
      $$AttendanceTableTableCreateCompanionBuilder,
      $$AttendanceTableTableUpdateCompanionBuilder,
      (Attendance, $$AttendanceTableTableReferences),
      Attendance,
      PrefetchHooks Function({bool employeeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmployeeTableTableTableManager get employeeTable =>
      $$EmployeeTableTableTableManager(_db, _db.employeeTable);
  $$AttendanceTableTableTableManager get attendanceTable =>
      $$AttendanceTableTableTableManager(_db, _db.attendanceTable);
}
