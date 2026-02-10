import 'package:attend/core/locator.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarGridBloc extends Bloc<CalendarGridEvent, CalendarGridState> {
  final employeeService = locator.get<AttendService>();

  CalendarGridBloc()
    : super(CalendarGridLoaded(month: DateTime.now(), employees: [])) {
    on<CalendarGridLoadMonth>(_onCalendarGridLoadMonth);
    on<CalendarGridUpdateCell>(_onCalendarGridUpdateCell);
  }

  Future<void> _onCalendarGridLoadMonth(
    CalendarGridLoadMonth event,
    Emitter<CalendarGridState> emit,
  ) async {
    final month = event.month ?? state.month;
    final employees = await employeeService.loadEmployees(month);
    emit(CalendarGridLoaded(month: month, employees: employees));
  }

  Future<void> _onCalendarGridUpdateCell(
    CalendarGridUpdateCell event,
    Emitter<CalendarGridState> emit,
  ) async {
    emit(
      CalendarGridUpdated(
        month: event.month ?? state.month,
        attendance: event.attendance,
        cell: event.cell,
      ),
    );
  }
}
