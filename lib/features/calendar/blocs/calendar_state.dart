sealed class CalendarState {
  final DateTime month;

  const CalendarState({required this.month});
}

class CalendarLoading extends CalendarState {
  const CalendarLoading({required super.month});
}

class CalendarSeeked extends CalendarState {
  final bool isOpen;

  const CalendarSeeked({required this.isOpen, required super.month});
}
