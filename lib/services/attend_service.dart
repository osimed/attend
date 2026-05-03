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

  Future<void> layoffEmployee(
    int employeeId,
    DateTime? date,
    LeaveReason? reason,
  ) async {
    return _database.layoffEmployee(employeeId, date, reason);
  }

  Future<Map<int, List<Attendance>>> getAttendancesUpToMonth(
    Team team,
    DateTime month,
  ) async {
    return _database.getAttendancesUpToMonth(team, month);
  }

  Future<List<ChangeLog>> getChangeLogs(String remoteDeviceId) async {
    return _database.getChangeLogs(remoteDeviceId);
  }

  Future<void> syncRemoteChanges(List<ChangeLog> changes) async {
    return _database.syncRemoteChanges(changes);
  }

  Future<void> updateSyncCursor(String remoteDeviceId, DateTime lastSynced) async {
    return _database.updateSyncCursor(remoteDeviceId, lastSynced);
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
    if (date.weekday != DateTime.sunday) {
      return worked - const Duration(hours: 8);
    }
    return worked;
  }

  Duration calcCollected(List<Attendance>? prevAttn) {
    if (prevAttn == null) return .zero;
    Duration total = .zero;
    for (final attn in prevAttn) {
      total += calcTimeDiff(attn) ?? .zero;
    }
    return total;
  }

  Future<void> saveBulkAttendances(List<Attendance> attendances) async {
    return _database.saveBulkAttendances(attendances);
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
