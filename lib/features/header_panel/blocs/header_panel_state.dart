import 'package:attend/database/database.dart';

sealed class HeaderPanelState {
  final bool isOpen;
  final DateTime month;

  const HeaderPanelState({required this.month, this.isOpen = false});
}

class HeaderPanelDateTime extends HeaderPanelState {
  const HeaderPanelDateTime({required super.month, super.isOpen});
}

class HeaderPanelEmployee extends HeaderPanelState {
  final Employee? employee;
  const HeaderPanelEmployee({
    required super.month,
    super.isOpen,
    this.employee,
  });
}
