sealed class CalendarEvent {}

class CalendarSeek extends CalendarEvent {
  final bool isOpen;
  final DateTime month;

  CalendarSeek({required this.month, this.isOpen = false});
}
