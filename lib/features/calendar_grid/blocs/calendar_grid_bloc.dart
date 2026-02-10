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
  }

  Future<void> _onLoadMonthlyCalendar(
    LoadMonthlyCalendar event,
    Emitter<CalendarGridState> emit,
  ) async {
    final month = event.month ?? state.month;
    final calendar = await _attendService.loadCalendar(month);
    emit(MonthlyCalendarLoaded(month: month, calendar: calendar));
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
        month: state.month,
        calendar: updatedCalendar,
        cell: event.cell,
      ),
    );
  }
}
