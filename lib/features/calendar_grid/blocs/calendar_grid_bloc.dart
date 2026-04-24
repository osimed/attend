import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarGridBloc extends Bloc<CalendarGridEvent, CalendarGridState> {
  final AttendService _attendService;

  CalendarGridBloc(this._attendService) : super(MonthlyCalendarLoaded.empty()) {
    on<LoadMonthlyCalendar>(_onLoadMonthlyCalendar);
    on<RefreshCalendarCell>(_onRefreshCalendarCell);
    on<CalcAttendanceDiff>(_onCalcAttendanceDiff);
    on<BulkSaveAttendances>(_onBulkSaveAttendances);
  }

  Future<void> _onLoadMonthlyCalendar(
    LoadMonthlyCalendar event,
    Emitter<CalendarGridState> emit,
  ) async {
    final month = event.month ?? state.month;
    final team = event.team ?? state.team;
    final calendar = await _attendService.loadCalendar(month, team);
    emit(MonthlyCalendarLoaded(team: team, month: month, calendar: calendar));
  }

  Future<void> _onRefreshCalendarCell(
    RefreshCalendarCell event,
    Emitter<CalendarGridState> emit,
  ) async {
    final updatedCalendar = [
      for (final row in state.calendar)
        if (row.employee.id == event.attendance.employeeId)
          CalendarRow(row.employee, {
            ...row.attendances,
            event.attendance.date.day: event.attendance,
          })
        else
          row,
    ];
    emit(
      CalendarCellRefreshed(
        team: state.team,
        month: state.month,
        calendar: updatedCalendar,
        cell: event.cell,
      ),
    );
  }

  Future<void> _onCalcAttendanceDiff(
    CalcAttendanceDiff event,
    Emitter<CalendarGridState> emit,
  ) async {
    state.calendar;
    final entry = state.calendar[event.cell.row - 1];
    final attendance = entry.attendances[event.cell.column];
    final diff = _attendService.calcTimeDiff(attendance);
    if (diff == null) return;
    emit(
      CalendarCellViewDiff(
        team: state.team,
        month: state.month,
        calendar: state.calendar,
        cell: event.cell,
        diff: diff,
      ),
    );
  }

  Future<void> _onBulkSaveAttendances(
    BulkSaveAttendances event,
    Emitter<CalendarGridState> emit,
  ) async {
    final attendances = state.calendar
        .where(
          (row) =>
              row.employee.leaveDate == null ||
              !event.date.isAfter(row.employee.leaveDate!),
        )
        .map(
          (row) => Attendance(
            employeeId: row.employee.id,
            date: event.date,
            status: event.template.status,
            enter: event.template.enter,
            leave: event.template.leave,
            lunchBreak: event.template.lunchBreak,
          ),
        )
        .toList();
    await _attendService.saveBulkAttendances(attendances);
    final calendar = await _attendService.loadCalendar(state.month, state.team);
    emit(
      MonthlyCalendarLoaded(
        team: state.team,
        month: state.month,
        calendar: calendar,
      ),
    );
  }
}
