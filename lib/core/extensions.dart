extension FormatMonth on DateTime {
  String formatMonth() {
    return "${month.toString().padLeft(2, '0')} - $year";
  }
}

extension FormatTime on Duration {
  String formatTime() {
    return '${inMinutes ~/ 60},${inMinutes % 60}';
  }
}

extension HoursParser on String {
  Duration? parseTime() {
    if (isEmpty) return .zero;
    final time = replaceAll(',', '.');
    final value = double.tryParse(time);
    if (value == null) return null;
    final parsedTime = value.abs().toString().split('.');
    final h = int.parse(parsedTime.first);
    final m = int.parse(parsedTime.last);
    if (m < 0 || m > 60) return null;
    final dur = Duration(hours: h, minutes: m);
    return value.isNegative ? -dur : dur;
  }
}
