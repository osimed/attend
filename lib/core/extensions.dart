extension FormatMonth on DateTime {
  String formatMonth() {
    return "${month.toString().padLeft(2, '0')} - $year";
  }
}
