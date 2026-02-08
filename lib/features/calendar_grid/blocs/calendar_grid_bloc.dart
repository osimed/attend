import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarGridBloc extends Bloc<CalendarGridEvent, CalendarGridState> {
  CalendarGridBloc()
    : super(CalendarGridLoaded(month: DateTime.now(), employees: [])) {
    on<CalendarGridLoadMonth>(_onCalendarGridLoadMonth);
    on<CalendarGridUpdateCell>(_onCalendarGridUpdateCell);
  }

  Future<void> _onCalendarGridLoadMonth(
    CalendarGridLoadMonth event,
    Emitter<CalendarGridState> emit,
  ) async {
    emit(
      CalendarGridLoaded(
        month: event.month ?? state.month,
        employees: [],
      ),
    );
  }

  Future<void> _onCalendarGridUpdateCell(
    CalendarGridUpdateCell event,
    Emitter<CalendarGridState> emit,
  ) async {
    // emit();
  }
}
