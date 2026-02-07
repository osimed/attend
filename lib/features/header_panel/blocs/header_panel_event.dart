import 'package:attend/database/database.dart';

sealed class HeaderPanelEvent {}

class HeaderPanelChangeDateTime extends HeaderPanelEvent {
  final DateTime? month;

  HeaderPanelChangeDateTime({this.month});
}

class HeaderPanelChangeEmployee extends HeaderPanelEvent {
  final DateTime? month;
  final Employee? employee;

  HeaderPanelChangeEmployee({this.month, this.employee});
}
