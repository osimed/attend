import 'package:attend/database/database.dart';
import 'package:flutter/material.dart' show DateUtils;

class AttendService {
  final AppDatabase _database;

  AttendService(this._database);

  Future<List<CalendarRow>> loadCalendar(DateTime month, Team team) async {
    final days = DateUtils.getDaysInMonth(month.year, month.month);
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month, days);
    return _database.loadCalendar(start, end, team);
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

  Duration? calcTimeDiff(Attendance? attendance) {
    if (attendance == null) return null;
    final date = attendance.date;
    if (attendance.status == .r) {
      if (date.weekday == DateTime.saturday) {
        return -const Duration(hours: 4);
      }
      return -const Duration(hours: 8);
    }
    if (attendance.status != .p) return null;
    final (e, l) = (attendance.enter, attendance.leave);
    if (e == null || l == null) return null;

    DateTime enter = date.copyWith(hour: e.hour, minute: e.minute);
    DateTime leave = date.copyWith(hour: l.hour, minute: l.minute);

    if (leave.hour < 8) {
      leave = leave.add(const Duration(days: 1));
    }

    Duration worked = leave.difference(enter);
    if (attendance.lunchBreak) {
      worked -= _lunchBreakPause(enter, leave);
    }
    if (date.weekday == DateTime.saturday) {
      return worked - const Duration(hours: 4);
    }
    return worked - const Duration(hours: 8);
  }
}

Duration _lunchBreakPause(DateTime enter, DateTime leave) {
  final pStart = enter.copyWith(hour: 12, minute: 0);
  final pEnd = enter.copyWith(hour: 13, minute: 0);

  final lStart = enter.isAfter(pStart) ? enter : pStart;
  final lEnd = leave.isBefore(pEnd) ? leave : pEnd;

  if (lStart.isBefore(lEnd)) return lEnd.difference(lStart);
  return .zero;
}
