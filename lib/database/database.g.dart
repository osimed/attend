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
  static const VerificationMeta _sapMeta = const VerificationMeta('sap');
  @override
  late final GeneratedColumn<int> sap = GeneratedColumn<int>(
    'sap',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sap,
    firstName,
    lastName,
    team,
    job,
    collected,
    leaveDate,
    leaveReason,
    sortOrder,
    createdAt,
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
    if (data.containsKey('sap')) {
      context.handle(
        _sapMeta,
        sap.isAcceptableOrUnknown(data['sap']!, _sapMeta),
      );
    } else if (isInserting) {
      context.missing(_sapMeta);
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
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
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
      sap: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sap'],
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
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EmployeeTableTable createAlias(String alias) {
    return $EmployeeTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Team, String, String> $converterteam =
      const EnumNameConverter<Team>(Team.values);
  static JsonTypeConverter2<Duration, int, int> $convertercollected =
      const DurationConverter();
  static JsonTypeConverter2<LeaveReason, String, String> $converterleaveReason =
      const EnumNameConverter<LeaveReason>(LeaveReason.values);
  static JsonTypeConverter2<LeaveReason?, String?, String?>
  $converterleaveReasonn = JsonTypeConverter2.asNullable($converterleaveReason);
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final int sap;
  final String firstName;
  final String lastName;
  final Team team;
  final String job;
  final Duration collected;
  final DateTime? leaveDate;
  final LeaveReason? leaveReason;
  final int sortOrder;
  final DateTime createdAt;
  const Employee({
    required this.id,
    required this.sap,
    required this.firstName,
    required this.lastName,
    required this.team,
    required this.job,
    required this.collected,
    this.leaveDate,
    this.leaveReason,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sap'] = Variable<int>(sap);
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
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EmployeeTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeeTableCompanion(
      id: Value(id),
      sap: Value(sap),
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
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      sap: serializer.fromJson<int>(json['sap']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      team: $EmployeeTableTable.$converterteam.fromJson(
        serializer.fromJson<String>(json['team']),
      ),
      job: serializer.fromJson<String>(json['job']),
      collected: $EmployeeTableTable.$convertercollected.fromJson(
        serializer.fromJson<int>(json['collected']),
      ),
      leaveDate: serializer.fromJson<DateTime?>(json['leaveDate']),
      leaveReason: $EmployeeTableTable.$converterleaveReasonn.fromJson(
        serializer.fromJson<String?>(json['leaveReason']),
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sap': serializer.toJson<int>(sap),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'team': serializer.toJson<String>(
        $EmployeeTableTable.$converterteam.toJson(team),
      ),
      'job': serializer.toJson<String>(job),
      'collected': serializer.toJson<int>(
        $EmployeeTableTable.$convertercollected.toJson(collected),
      ),
      'leaveDate': serializer.toJson<DateTime?>(leaveDate),
      'leaveReason': serializer.toJson<String?>(
        $EmployeeTableTable.$converterleaveReasonn.toJson(leaveReason),
      ),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Employee copyWith({
    int? id,
    int? sap,
    String? firstName,
    String? lastName,
    Team? team,
    String? job,
    Duration? collected,
    Value<DateTime?> leaveDate = const Value.absent(),
    Value<LeaveReason?> leaveReason = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => Employee(
    id: id ?? this.id,
    sap: sap ?? this.sap,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    team: team ?? this.team,
    job: job ?? this.job,
    collected: collected ?? this.collected,
    leaveDate: leaveDate.present ? leaveDate.value : this.leaveDate,
    leaveReason: leaveReason.present ? leaveReason.value : this.leaveReason,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  Employee copyWithCompanion(EmployeeTableCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      sap: data.sap.present ? data.sap.value : this.sap,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      team: data.team.present ? data.team.value : this.team,
      job: data.job.present ? data.job.value : this.job,
      collected: data.collected.present ? data.collected.value : this.collected,
      leaveDate: data.leaveDate.present ? data.leaveDate.value : this.leaveDate,
      leaveReason: data.leaveReason.present
          ? data.leaveReason.value
          : this.leaveReason,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('sap: $sap, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('team: $team, ')
          ..write('job: $job, ')
          ..write('collected: $collected, ')
          ..write('leaveDate: $leaveDate, ')
          ..write('leaveReason: $leaveReason, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sap,
    firstName,
    lastName,
    team,
    job,
    collected,
    leaveDate,
    leaveReason,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.sap == this.sap &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.team == this.team &&
          other.job == this.job &&
          other.collected == this.collected &&
          other.leaveDate == this.leaveDate &&
          other.leaveReason == this.leaveReason &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class EmployeeTableCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<int> sap;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<Team> team;
  final Value<String> job;
  final Value<Duration> collected;
  final Value<DateTime?> leaveDate;
  final Value<LeaveReason?> leaveReason;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const EmployeeTableCompanion({
    this.id = const Value.absent(),
    this.sap = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.team = const Value.absent(),
    this.job = const Value.absent(),
    this.collected = const Value.absent(),
    this.leaveDate = const Value.absent(),
    this.leaveReason = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EmployeeTableCompanion.insert({
    this.id = const Value.absent(),
    required int sap,
    required String firstName,
    required String lastName,
    required Team team,
    this.job = const Value.absent(),
    this.collected = const Value.absent(),
    this.leaveDate = const Value.absent(),
    this.leaveReason = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : sap = Value(sap),
       firstName = Value(firstName),
       lastName = Value(lastName),
       team = Value(team);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<int>? sap,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? team,
    Expression<String>? job,
    Expression<int>? collected,
    Expression<DateTime>? leaveDate,
    Expression<String>? leaveReason,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sap != null) 'sap': sap,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (team != null) 'team': team,
      if (job != null) 'job': job,
      if (collected != null) 'collected': collected,
      if (leaveDate != null) 'leave_date': leaveDate,
      if (leaveReason != null) 'leave_reason': leaveReason,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EmployeeTableCompanion copyWith({
    Value<int>? id,
    Value<int>? sap,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<Team>? team,
    Value<String>? job,
    Value<Duration>? collected,
    Value<DateTime?>? leaveDate,
    Value<LeaveReason?>? leaveReason,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return EmployeeTableCompanion(
      id: id ?? this.id,
      sap: sap ?? this.sap,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      team: team ?? this.team,
      job: job ?? this.job,
      collected: collected ?? this.collected,
      leaveDate: leaveDate ?? this.leaveDate,
      leaveReason: leaveReason ?? this.leaveReason,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sap.present) {
      map['sap'] = Variable<int>(sap.value);
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
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeTableCompanion(')
          ..write('id: $id, ')
          ..write('sap: $sap, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('team: $team, ')
          ..write('job: $job, ')
          ..write('collected: $collected, ')
          ..write('leaveDate: $leaveDate, ')
          ..write('leaveReason: $leaveReason, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
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
  static JsonTypeConverter2<TimeOfDay, int, int> $converterenter =
      const TimeOfDayConverter();
  static JsonTypeConverter2<TimeOfDay?, int?, int?> $converterentern =
      JsonTypeConverter2.asNullable($converterenter);
  static JsonTypeConverter2<TimeOfDay, int, int> $converterleave =
      const TimeOfDayConverter();
  static JsonTypeConverter2<TimeOfDay?, int?, int?> $converterleaven =
      JsonTypeConverter2.asNullable($converterleave);
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
      enter: $AttendanceTableTable.$converterentern.fromJson(
        serializer.fromJson<int?>(json['enter']),
      ),
      leave: $AttendanceTableTable.$converterleaven.fromJson(
        serializer.fromJson<int?>(json['leave']),
      ),
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
      'enter': serializer.toJson<int?>(
        $AttendanceTableTable.$converterentern.toJson(enter),
      ),
      'leave': serializer.toJson<int?>(
        $AttendanceTableTable.$converterleaven.toJson(leave),
      ),
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

class $MonthlyBalanceTableTable extends MonthlyBalanceTable
    with TableInfo<$MonthlyBalanceTableTable, MonthlyBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyBalanceTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<DateTime> month = GeneratedColumn<DateTime>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> closingBalence =
      GeneratedColumn<int>(
        'closing_balence',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Duration>(
        $MonthlyBalanceTableTable.$converterclosingBalence,
      );
  @override
  List<GeneratedColumn> get $columns => [employeeId, month, closingBalence];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_balance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyBalance> instance, {
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
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, month};
  @override
  MonthlyBalance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyBalance(
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}month'],
      )!,
      closingBalence: $MonthlyBalanceTableTable.$converterclosingBalence
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}closing_balence'],
            )!,
          ),
    );
  }

  @override
  $MonthlyBalanceTableTable createAlias(String alias) {
    return $MonthlyBalanceTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Duration, int, int> $converterclosingBalence =
      const DurationConverter();
}

class MonthlyBalance extends DataClass implements Insertable<MonthlyBalance> {
  final int employeeId;
  final DateTime month;
  final Duration closingBalence;
  const MonthlyBalance({
    required this.employeeId,
    required this.month,
    required this.closingBalence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<int>(employeeId);
    map['month'] = Variable<DateTime>(month);
    {
      map['closing_balence'] = Variable<int>(
        $MonthlyBalanceTableTable.$converterclosingBalence.toSql(
          closingBalence,
        ),
      );
    }
    return map;
  }

  MonthlyBalanceTableCompanion toCompanion(bool nullToAbsent) {
    return MonthlyBalanceTableCompanion(
      employeeId: Value(employeeId),
      month: Value(month),
      closingBalence: Value(closingBalence),
    );
  }

  factory MonthlyBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyBalance(
      employeeId: serializer.fromJson<int>(json['employeeId']),
      month: serializer.fromJson<DateTime>(json['month']),
      closingBalence: $MonthlyBalanceTableTable.$converterclosingBalence
          .fromJson(serializer.fromJson<int>(json['closingBalence'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<int>(employeeId),
      'month': serializer.toJson<DateTime>(month),
      'closingBalence': serializer.toJson<int>(
        $MonthlyBalanceTableTable.$converterclosingBalence.toJson(
          closingBalence,
        ),
      ),
    };
  }

  MonthlyBalance copyWith({
    int? employeeId,
    DateTime? month,
    Duration? closingBalence,
  }) => MonthlyBalance(
    employeeId: employeeId ?? this.employeeId,
    month: month ?? this.month,
    closingBalence: closingBalence ?? this.closingBalence,
  );
  MonthlyBalance copyWithCompanion(MonthlyBalanceTableCompanion data) {
    return MonthlyBalance(
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      month: data.month.present ? data.month.value : this.month,
      closingBalence: data.closingBalence.present
          ? data.closingBalence.value
          : this.closingBalence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyBalance(')
          ..write('employeeId: $employeeId, ')
          ..write('month: $month, ')
          ..write('closingBalence: $closingBalence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, month, closingBalence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyBalance &&
          other.employeeId == this.employeeId &&
          other.month == this.month &&
          other.closingBalence == this.closingBalence);
}

class MonthlyBalanceTableCompanion extends UpdateCompanion<MonthlyBalance> {
  final Value<int> employeeId;
  final Value<DateTime> month;
  final Value<Duration> closingBalence;
  final Value<int> rowid;
  const MonthlyBalanceTableCompanion({
    this.employeeId = const Value.absent(),
    this.month = const Value.absent(),
    this.closingBalence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyBalanceTableCompanion.insert({
    required int employeeId,
    required DateTime month,
    required Duration closingBalence,
    this.rowid = const Value.absent(),
  }) : employeeId = Value(employeeId),
       month = Value(month),
       closingBalence = Value(closingBalence);
  static Insertable<MonthlyBalance> custom({
    Expression<int>? employeeId,
    Expression<DateTime>? month,
    Expression<int>? closingBalence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (month != null) 'month': month,
      if (closingBalence != null) 'closing_balence': closingBalence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyBalanceTableCompanion copyWith({
    Value<int>? employeeId,
    Value<DateTime>? month,
    Value<Duration>? closingBalence,
    Value<int>? rowid,
  }) {
    return MonthlyBalanceTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      month: month ?? this.month,
      closingBalence: closingBalence ?? this.closingBalence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (month.present) {
      map['month'] = Variable<DateTime>(month.value);
    }
    if (closingBalence.present) {
      map['closing_balence'] = Variable<int>(
        $MonthlyBalanceTableTable.$converterclosingBalence.toSql(
          closingBalence.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyBalanceTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('month: $month, ')
          ..write('closingBalence: $closingBalence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChangeLogTableTable extends ChangeLogTable
    with TableInfo<$ChangeLogTableTable, ChangeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChangeLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tableMeta = const VerificationMeta('table');
  @override
  late final GeneratedColumn<String> table = GeneratedColumn<String>(
    'table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    timestamp,
    table,
    operation,
    payload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'change_log_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChangeLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('table')) {
      context.handle(
        _tableMeta,
        table.isAcceptableOrUnknown(data['table']!, _tableMeta),
      );
    } else if (isInserting) {
      context.missing(_tableMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChangeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChangeLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      table: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $ChangeLogTableTable createAlias(String alias) {
    return $ChangeLogTableTable(attachedDatabase, alias);
  }
}

class ChangeLog extends DataClass implements Insertable<ChangeLog> {
  final String id;
  final String deviceId;
  final DateTime timestamp;
  final String table;
  final String operation;
  final String payload;
  const ChangeLog({
    required this.id,
    required this.deviceId,
    required this.timestamp,
    required this.table,
    required this.operation,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['table'] = Variable<String>(table);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  ChangeLogTableCompanion toCompanion(bool nullToAbsent) {
    return ChangeLogTableCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      timestamp: Value(timestamp),
      table: Value(table),
      operation: Value(operation),
      payload: Value(payload),
    );
  }

  factory ChangeLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChangeLog(
      id: serializer.fromJson<String>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      table: serializer.fromJson<String>(json['table']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'table': serializer.toJson<String>(table),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
    };
  }

  ChangeLog copyWith({
    String? id,
    String? deviceId,
    DateTime? timestamp,
    String? table,
    String? operation,
    String? payload,
  }) => ChangeLog(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    timestamp: timestamp ?? this.timestamp,
    table: table ?? this.table,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
  );
  ChangeLog copyWithCompanion(ChangeLogTableCompanion data) {
    return ChangeLog(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      table: data.table.present ? data.table.value : this.table,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChangeLog(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('table: $table, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deviceId, timestamp, table, operation, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChangeLog &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.timestamp == this.timestamp &&
          other.table == this.table &&
          other.operation == this.operation &&
          other.payload == this.payload);
}

class ChangeLogTableCompanion extends UpdateCompanion<ChangeLog> {
  final Value<String> id;
  final Value<String> deviceId;
  final Value<DateTime> timestamp;
  final Value<String> table;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> rowid;
  const ChangeLogTableCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.table = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChangeLogTableCompanion.insert({
    required String id,
    required String deviceId,
    required DateTime timestamp,
    required String table,
    required String operation,
    required String payload,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       deviceId = Value(deviceId),
       timestamp = Value(timestamp),
       table = Value(table),
       operation = Value(operation),
       payload = Value(payload);
  static Insertable<ChangeLog> custom({
    Expression<String>? id,
    Expression<String>? deviceId,
    Expression<DateTime>? timestamp,
    Expression<String>? table,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (timestamp != null) 'timestamp': timestamp,
      if (table != null) 'table': table,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChangeLogTableCompanion copyWith({
    Value<String>? id,
    Value<String>? deviceId,
    Value<DateTime>? timestamp,
    Value<String>? table,
    Value<String>? operation,
    Value<String>? payload,
    Value<int>? rowid,
  }) {
    return ChangeLogTableCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      timestamp: timestamp ?? this.timestamp,
      table: table ?? this.table,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (table.present) {
      map['table'] = Variable<String>(table.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChangeLogTableCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('table: $table, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncCursorTableTable extends SyncCursorTable
    with TableInfo<$SyncCursorTableTable, SyncCursor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncCursorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _remoteDeviceIdMeta = const VerificationMeta(
    'remoteDeviceId',
  );
  @override
  late final GeneratedColumn<String> remoteDeviceId = GeneratedColumn<String>(
    'remote_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedMeta = const VerificationMeta(
    'lastSynced',
  );
  @override
  late final GeneratedColumn<DateTime> lastSynced = GeneratedColumn<DateTime>(
    'last_synced',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [remoteDeviceId, lastSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_cursor_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncCursor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('remote_device_id')) {
      context.handle(
        _remoteDeviceIdMeta,
        remoteDeviceId.isAcceptableOrUnknown(
          data['remote_device_id']!,
          _remoteDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remoteDeviceIdMeta);
    }
    if (data.containsKey('last_synced')) {
      context.handle(
        _lastSyncedMeta,
        lastSynced.isAcceptableOrUnknown(data['last_synced']!, _lastSyncedMeta),
      );
    } else if (isInserting) {
      context.missing(_lastSyncedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {remoteDeviceId};
  @override
  SyncCursor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncCursor(
      remoteDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_device_id'],
      )!,
      lastSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced'],
      )!,
    );
  }

  @override
  $SyncCursorTableTable createAlias(String alias) {
    return $SyncCursorTableTable(attachedDatabase, alias);
  }
}

class SyncCursor extends DataClass implements Insertable<SyncCursor> {
  final String remoteDeviceId;
  final DateTime lastSynced;
  const SyncCursor({required this.remoteDeviceId, required this.lastSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['remote_device_id'] = Variable<String>(remoteDeviceId);
    map['last_synced'] = Variable<DateTime>(lastSynced);
    return map;
  }

  SyncCursorTableCompanion toCompanion(bool nullToAbsent) {
    return SyncCursorTableCompanion(
      remoteDeviceId: Value(remoteDeviceId),
      lastSynced: Value(lastSynced),
    );
  }

  factory SyncCursor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncCursor(
      remoteDeviceId: serializer.fromJson<String>(json['remoteDeviceId']),
      lastSynced: serializer.fromJson<DateTime>(json['lastSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'remoteDeviceId': serializer.toJson<String>(remoteDeviceId),
      'lastSynced': serializer.toJson<DateTime>(lastSynced),
    };
  }

  SyncCursor copyWith({String? remoteDeviceId, DateTime? lastSynced}) =>
      SyncCursor(
        remoteDeviceId: remoteDeviceId ?? this.remoteDeviceId,
        lastSynced: lastSynced ?? this.lastSynced,
      );
  SyncCursor copyWithCompanion(SyncCursorTableCompanion data) {
    return SyncCursor(
      remoteDeviceId: data.remoteDeviceId.present
          ? data.remoteDeviceId.value
          : this.remoteDeviceId,
      lastSynced: data.lastSynced.present
          ? data.lastSynced.value
          : this.lastSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursor(')
          ..write('remoteDeviceId: $remoteDeviceId, ')
          ..write('lastSynced: $lastSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(remoteDeviceId, lastSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncCursor &&
          other.remoteDeviceId == this.remoteDeviceId &&
          other.lastSynced == this.lastSynced);
}

class SyncCursorTableCompanion extends UpdateCompanion<SyncCursor> {
  final Value<String> remoteDeviceId;
  final Value<DateTime> lastSynced;
  final Value<int> rowid;
  const SyncCursorTableCompanion({
    this.remoteDeviceId = const Value.absent(),
    this.lastSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncCursorTableCompanion.insert({
    required String remoteDeviceId,
    required DateTime lastSynced,
    this.rowid = const Value.absent(),
  }) : remoteDeviceId = Value(remoteDeviceId),
       lastSynced = Value(lastSynced);
  static Insertable<SyncCursor> custom({
    Expression<String>? remoteDeviceId,
    Expression<DateTime>? lastSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (remoteDeviceId != null) 'remote_device_id': remoteDeviceId,
      if (lastSynced != null) 'last_synced': lastSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncCursorTableCompanion copyWith({
    Value<String>? remoteDeviceId,
    Value<DateTime>? lastSynced,
    Value<int>? rowid,
  }) {
    return SyncCursorTableCompanion(
      remoteDeviceId: remoteDeviceId ?? this.remoteDeviceId,
      lastSynced: lastSynced ?? this.lastSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (remoteDeviceId.present) {
      map['remote_device_id'] = Variable<String>(remoteDeviceId.value);
    }
    if (lastSynced.present) {
      map['last_synced'] = Variable<DateTime>(lastSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursorTableCompanion(')
          ..write('remoteDeviceId: $remoteDeviceId, ')
          ..write('lastSynced: $lastSynced, ')
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
  late final $MonthlyBalanceTableTable monthlyBalanceTable =
      $MonthlyBalanceTableTable(this);
  late final $ChangeLogTableTable changeLogTable = $ChangeLogTableTable(this);
  late final $SyncCursorTableTable syncCursorTable = $SyncCursorTableTable(
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
    monthlyBalanceTable,
    changeLogTable,
    syncCursorTable,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'employee_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('monthly_balance_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$EmployeeTableTableCreateCompanionBuilder =
    EmployeeTableCompanion Function({
      Value<int> id,
      required int sap,
      required String firstName,
      required String lastName,
      required Team team,
      Value<String> job,
      Value<Duration> collected,
      Value<DateTime?> leaveDate,
      Value<LeaveReason?> leaveReason,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$EmployeeTableTableUpdateCompanionBuilder =
    EmployeeTableCompanion Function({
      Value<int> id,
      Value<int> sap,
      Value<String> firstName,
      Value<String> lastName,
      Value<Team> team,
      Value<String> job,
      Value<Duration> collected,
      Value<DateTime?> leaveDate,
      Value<LeaveReason?> leaveReason,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
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

  static MultiTypedResultKey<$MonthlyBalanceTableTable, List<MonthlyBalance>>
  _monthlyBalanceTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.monthlyBalanceTable,
        aliasName: $_aliasNameGenerator(
          db.employeeTable.id,
          db.monthlyBalanceTable.employeeId,
        ),
      );

  $$MonthlyBalanceTableTableProcessedTableManager get monthlyBalanceTableRefs {
    final manager = $$MonthlyBalanceTableTableTableManager(
      $_db,
      $_db.monthlyBalanceTable,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _monthlyBalanceTableRefsTable($_db),
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

  ColumnFilters<int> get sap => $composableBuilder(
    column: $table.sap,
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

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
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

  Expression<bool> monthlyBalanceTableRefs(
    Expression<bool> Function($$MonthlyBalanceTableTableFilterComposer f) f,
  ) {
    final $$MonthlyBalanceTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBalanceTable,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBalanceTableTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBalanceTable,
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

  ColumnOrderings<int> get sap => $composableBuilder(
    column: $table.sap,
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

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  GeneratedColumn<int> get sap =>
      $composableBuilder(column: $table.sap, builder: (column) => column);

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

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

  Expression<T> monthlyBalanceTableRefs<T extends Object>(
    Expression<T> Function($$MonthlyBalanceTableTableAnnotationComposer a) f,
  ) {
    final $$MonthlyBalanceTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.monthlyBalanceTable,
          getReferencedColumn: (t) => t.employeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyBalanceTableTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyBalanceTable,
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
          PrefetchHooks Function({
            bool attendanceTableRefs,
            bool monthlyBalanceTableRefs,
          })
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
                Value<int> sap = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<Team> team = const Value.absent(),
                Value<String> job = const Value.absent(),
                Value<Duration> collected = const Value.absent(),
                Value<DateTime?> leaveDate = const Value.absent(),
                Value<LeaveReason?> leaveReason = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmployeeTableCompanion(
                id: id,
                sap: sap,
                firstName: firstName,
                lastName: lastName,
                team: team,
                job: job,
                collected: collected,
                leaveDate: leaveDate,
                leaveReason: leaveReason,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sap,
                required String firstName,
                required String lastName,
                required Team team,
                Value<String> job = const Value.absent(),
                Value<Duration> collected = const Value.absent(),
                Value<DateTime?> leaveDate = const Value.absent(),
                Value<LeaveReason?> leaveReason = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmployeeTableCompanion.insert(
                id: id,
                sap: sap,
                firstName: firstName,
                lastName: lastName,
                team: team,
                job: job,
                collected: collected,
                leaveDate: leaveDate,
                leaveReason: leaveReason,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmployeeTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attendanceTableRefs = false, monthlyBalanceTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attendanceTableRefs) db.attendanceTable,
                    if (monthlyBalanceTableRefs) db.monthlyBalanceTable,
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
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.employeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyBalanceTableRefs)
                        await $_getPrefetchedData<
                          Employee,
                          $EmployeeTableTable,
                          MonthlyBalance
                        >(
                          currentTable: table,
                          referencedTable: $$EmployeeTableTableReferences
                              ._monthlyBalanceTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EmployeeTableTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyBalanceTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.employeeId == item.id,
                              ),
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
      PrefetchHooks Function({
        bool attendanceTableRefs,
        bool monthlyBalanceTableRefs,
      })
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
typedef $$MonthlyBalanceTableTableCreateCompanionBuilder =
    MonthlyBalanceTableCompanion Function({
      required int employeeId,
      required DateTime month,
      required Duration closingBalence,
      Value<int> rowid,
    });
typedef $$MonthlyBalanceTableTableUpdateCompanionBuilder =
    MonthlyBalanceTableCompanion Function({
      Value<int> employeeId,
      Value<DateTime> month,
      Value<Duration> closingBalence,
      Value<int> rowid,
    });

final class $$MonthlyBalanceTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MonthlyBalanceTableTable,
          MonthlyBalance
        > {
  $$MonthlyBalanceTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EmployeeTableTable _employeeIdTable(_$AppDatabase db) =>
      db.employeeTable.createAlias(
        $_aliasNameGenerator(
          db.monthlyBalanceTable.employeeId,
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

class $$MonthlyBalanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyBalanceTableTable> {
  $$MonthlyBalanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Duration, Duration, int> get closingBalence =>
      $composableBuilder(
        column: $table.closingBalence,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

class $$MonthlyBalanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyBalanceTableTable> {
  $$MonthlyBalanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get closingBalence => $composableBuilder(
    column: $table.closingBalence,
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

class $$MonthlyBalanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyBalanceTableTable> {
  $$MonthlyBalanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Duration, int> get closingBalence =>
      $composableBuilder(
        column: $table.closingBalence,
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

class $$MonthlyBalanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyBalanceTableTable,
          MonthlyBalance,
          $$MonthlyBalanceTableTableFilterComposer,
          $$MonthlyBalanceTableTableOrderingComposer,
          $$MonthlyBalanceTableTableAnnotationComposer,
          $$MonthlyBalanceTableTableCreateCompanionBuilder,
          $$MonthlyBalanceTableTableUpdateCompanionBuilder,
          (MonthlyBalance, $$MonthlyBalanceTableTableReferences),
          MonthlyBalance,
          PrefetchHooks Function({bool employeeId})
        > {
  $$MonthlyBalanceTableTableTableManager(
    _$AppDatabase db,
    $MonthlyBalanceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyBalanceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyBalanceTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MonthlyBalanceTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> employeeId = const Value.absent(),
                Value<DateTime> month = const Value.absent(),
                Value<Duration> closingBalence = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyBalanceTableCompanion(
                employeeId: employeeId,
                month: month,
                closingBalence: closingBalence,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int employeeId,
                required DateTime month,
                required Duration closingBalence,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyBalanceTableCompanion.insert(
                employeeId: employeeId,
                month: month,
                closingBalence: closingBalence,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyBalanceTableTableReferences(db, table, e),
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
                                    $$MonthlyBalanceTableTableReferences
                                        ._employeeIdTable(db),
                                referencedColumn:
                                    $$MonthlyBalanceTableTableReferences
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

typedef $$MonthlyBalanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyBalanceTableTable,
      MonthlyBalance,
      $$MonthlyBalanceTableTableFilterComposer,
      $$MonthlyBalanceTableTableOrderingComposer,
      $$MonthlyBalanceTableTableAnnotationComposer,
      $$MonthlyBalanceTableTableCreateCompanionBuilder,
      $$MonthlyBalanceTableTableUpdateCompanionBuilder,
      (MonthlyBalance, $$MonthlyBalanceTableTableReferences),
      MonthlyBalance,
      PrefetchHooks Function({bool employeeId})
    >;
typedef $$ChangeLogTableTableCreateCompanionBuilder =
    ChangeLogTableCompanion Function({
      required String id,
      required String deviceId,
      required DateTime timestamp,
      required String table,
      required String operation,
      required String payload,
      Value<int> rowid,
    });
typedef $$ChangeLogTableTableUpdateCompanionBuilder =
    ChangeLogTableCompanion Function({
      Value<String> id,
      Value<String> deviceId,
      Value<DateTime> timestamp,
      Value<String> table,
      Value<String> operation,
      Value<String> payload,
      Value<int> rowid,
    });

class $$ChangeLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChangeLogTableTable> {
  $$ChangeLogTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get table => $composableBuilder(
    column: $table.table,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChangeLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChangeLogTableTable> {
  $$ChangeLogTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get table => $composableBuilder(
    column: $table.table,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChangeLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChangeLogTableTable> {
  $$ChangeLogTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get table =>
      $composableBuilder(column: $table.table, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$ChangeLogTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChangeLogTableTable,
          ChangeLog,
          $$ChangeLogTableTableFilterComposer,
          $$ChangeLogTableTableOrderingComposer,
          $$ChangeLogTableTableAnnotationComposer,
          $$ChangeLogTableTableCreateCompanionBuilder,
          $$ChangeLogTableTableUpdateCompanionBuilder,
          (
            ChangeLog,
            BaseReferences<_$AppDatabase, $ChangeLogTableTable, ChangeLog>,
          ),
          ChangeLog,
          PrefetchHooks Function()
        > {
  $$ChangeLogTableTableTableManager(
    _$AppDatabase db,
    $ChangeLogTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChangeLogTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChangeLogTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChangeLogTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> table = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChangeLogTableCompanion(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                table: table,
                operation: operation,
                payload: payload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String deviceId,
                required DateTime timestamp,
                required String table,
                required String operation,
                required String payload,
                Value<int> rowid = const Value.absent(),
              }) => ChangeLogTableCompanion.insert(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                table: table,
                operation: operation,
                payload: payload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChangeLogTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChangeLogTableTable,
      ChangeLog,
      $$ChangeLogTableTableFilterComposer,
      $$ChangeLogTableTableOrderingComposer,
      $$ChangeLogTableTableAnnotationComposer,
      $$ChangeLogTableTableCreateCompanionBuilder,
      $$ChangeLogTableTableUpdateCompanionBuilder,
      (
        ChangeLog,
        BaseReferences<_$AppDatabase, $ChangeLogTableTable, ChangeLog>,
      ),
      ChangeLog,
      PrefetchHooks Function()
    >;
typedef $$SyncCursorTableTableCreateCompanionBuilder =
    SyncCursorTableCompanion Function({
      required String remoteDeviceId,
      required DateTime lastSynced,
      Value<int> rowid,
    });
typedef $$SyncCursorTableTableUpdateCompanionBuilder =
    SyncCursorTableCompanion Function({
      Value<String> remoteDeviceId,
      Value<DateTime> lastSynced,
      Value<int> rowid,
    });

class $$SyncCursorTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncCursorTableTable> {
  $$SyncCursorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get remoteDeviceId => $composableBuilder(
    column: $table.remoteDeviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncCursorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncCursorTableTable> {
  $$SyncCursorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get remoteDeviceId => $composableBuilder(
    column: $table.remoteDeviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncCursorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncCursorTableTable> {
  $$SyncCursorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get remoteDeviceId => $composableBuilder(
    column: $table.remoteDeviceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => column,
  );
}

class $$SyncCursorTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncCursorTableTable,
          SyncCursor,
          $$SyncCursorTableTableFilterComposer,
          $$SyncCursorTableTableOrderingComposer,
          $$SyncCursorTableTableAnnotationComposer,
          $$SyncCursorTableTableCreateCompanionBuilder,
          $$SyncCursorTableTableUpdateCompanionBuilder,
          (
            SyncCursor,
            BaseReferences<_$AppDatabase, $SyncCursorTableTable, SyncCursor>,
          ),
          SyncCursor,
          PrefetchHooks Function()
        > {
  $$SyncCursorTableTableTableManager(
    _$AppDatabase db,
    $SyncCursorTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncCursorTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncCursorTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncCursorTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> remoteDeviceId = const Value.absent(),
                Value<DateTime> lastSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorTableCompanion(
                remoteDeviceId: remoteDeviceId,
                lastSynced: lastSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String remoteDeviceId,
                required DateTime lastSynced,
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorTableCompanion.insert(
                remoteDeviceId: remoteDeviceId,
                lastSynced: lastSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncCursorTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncCursorTableTable,
      SyncCursor,
      $$SyncCursorTableTableFilterComposer,
      $$SyncCursorTableTableOrderingComposer,
      $$SyncCursorTableTableAnnotationComposer,
      $$SyncCursorTableTableCreateCompanionBuilder,
      $$SyncCursorTableTableUpdateCompanionBuilder,
      (
        SyncCursor,
        BaseReferences<_$AppDatabase, $SyncCursorTableTable, SyncCursor>,
      ),
      SyncCursor,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmployeeTableTableTableManager get employeeTable =>
      $$EmployeeTableTableTableManager(_db, _db.employeeTable);
  $$AttendanceTableTableTableManager get attendanceTable =>
      $$AttendanceTableTableTableManager(_db, _db.attendanceTable);
  $$MonthlyBalanceTableTableTableManager get monthlyBalanceTable =>
      $$MonthlyBalanceTableTableTableManager(_db, _db.monthlyBalanceTable);
  $$ChangeLogTableTableTableManager get changeLogTable =>
      $$ChangeLogTableTableTableManager(_db, _db.changeLogTable);
  $$SyncCursorTableTableTableManager get syncCursorTable =>
      $$SyncCursorTableTableTableManager(_db, _db.syncCursorTable);
}
