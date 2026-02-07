import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderPanelBloc extends Bloc<HeaderPanelEvent, HeaderPanelState> {
  HeaderPanelBloc() : super(HeaderPanelDateTime(month: DateTime.now())) {
    on<HeaderPanelChangeDateTime>(_onHeaderPanelChangeDateTime);
    on<HeaderPanelChangeEmployee>(_onHeaderPanelChangeEmployee);
  }

  Future<void> _onHeaderPanelChangeDateTime(
    HeaderPanelChangeDateTime event,
    Emitter<HeaderPanelState> emit,
  ) async {
    emit(
      HeaderPanelDateTime(
        isOpen: !(state is HeaderPanelDateTime && state.isOpen),
        month: event.month ?? state.month,
      ),
    );
  }

  Future<void> _onHeaderPanelChangeEmployee(
    HeaderPanelChangeEmployee event,
    Emitter<HeaderPanelState> emit,
  ) async {
    emit(
      HeaderPanelEmployee(
        isOpen: !(state is HeaderPanelEmployee && state.isOpen),
        month: state.month,
      ),
    );
  }
}
