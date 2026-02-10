import 'package:attend/database/database.dart';
import 'package:flutter/material.dart' show DateUtils;

class AttendService {
  final AppDatabase _database;

  AttendService(this._database);

  Future<List<CalendarRow>> loadCalendar(DateTime month) async {
    final days = DateUtils.getDaysInMonth(month.year, month.month);
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month, days);
    return _database.loadCalendar(start, end);
  }

  Future<void> saveAttendance(Attendance attendance) async {
    return _database.saveAttendance(attendance);
  }

  Future<void> saveEmployee(Employee employee) async {
    return _database.saveEmployee(employee);
  }

  Future<bool> deleteEmployee(Employee employee) async {
    return _database.deleteEmployee(employee);
  }
}
