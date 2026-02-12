import 'package:flutter/material.dart';

extension FormatMonth on DateTime {
  String formatMonth() {
    return "${month.toString().padLeft(2, '0')} - $year";
  }
}

extension FormatTime on Duration {
  String formatTime() {
    final total = inMinutes.abs();
    final sign = isNegative ? '-' : '';
    final h = (total ~/ 60).toString().padLeft(2, '0');
    final m = (total % 60).toString().padLeft(2, '0');
    return '$sign$h,$m';
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

extension TimeFormat on TimeOfDay {
  String displayTime() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
