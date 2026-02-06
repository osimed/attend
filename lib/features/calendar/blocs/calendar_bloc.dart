import 'package:attend/features/calendar/blocs/calendar_event.dart';
import 'package:attend/features/calendar/blocs/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarLoading(month: DateTime.now())) {
    on<CalendarSeek>(_onCalendarSeek);
  }

  Future<void> _onCalendarSeek(
    CalendarSeek event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarSeeked(isOpen: event.isOpen, month: event.month));
  }
}
