import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderPanelBloc extends Bloc<HeaderPanelEvent, HeaderPanelState> {
  final AttendService _attendService;

  HeaderPanelBloc(this._attendService)
    : super(PickingAMonth(month: DateTime.now())) {
    on<SeekToMonth>(_onSeekToMonth);
    on<SelectEmployee>(_onSelectEmployee);
    on<SaveEmployee>(_onSaveEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
    on<SelectAttendance>(_onSelectAttendance);
    on<SaveAttendance>(_onSaveAttendance);
  }

  Future<void> _onSeekToMonth(
    SeekToMonth event,
    Emitter<HeaderPanelState> emit,
  ) async {
    emit(
      PickingAMonth(
        isOpen: !(state is PickingAMonth && state.isOpen),
        month: event.picked ?? state.month,
      ),
    );
  }

  Future<void> _onSelectEmployee(
    SelectEmployee event,
    Emitter<HeaderPanelState> emit,
  ) async {
    final isOpen = switch (state) {
      EditingEmployee state =>
        state.isOpen && state.employee?.id == event.employee?.id,
      _ => false,
    };
    emit(
      EditingEmployee(
        isOpen: !isOpen,
        month: state.month,
        employee: event.employee,
      ),
    );
  }

  Future<void> _onSaveEmployee(
    SaveEmployee event,
    Emitter<HeaderPanelState> emit,
  ) async {
    await _attendService.saveEmployee(event.employee);
    emit(
      EmployeeSaved(month: state.month, isOpen: true, employee: event.employee),
    );
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployee event,
    Emitter<HeaderPanelState> emit,
  ) async {
    await _attendService.deleteEmployee(event.employee);
    emit(
      EmployeeDeleted(
        month: state.month,
        isOpen: false,
        employee: event.employee,
      ),
    );
  }

  Future<void> _onSelectAttendance(
    SelectAttendance event,
    Emitter<HeaderPanelState> emit,
  ) async {
    final isOpen = switch (state) {
      EditingAttendance state =>
        state.isOpen &&
            state.attendance.date == event.attendance.date &&
            state.attendance.employeeId == event.attendance.employeeId,
      _ => false,
    };
    emit(
      EditingAttendance(
        isOpen: !isOpen,
        month: state.month,
        attendance: event.attendance,
        cell: event.cell,
      ),
    );
  }

  Future<void> _onSaveAttendance(
    SaveAttendance event,
    Emitter<HeaderPanelState> emit,
  ) async {
    await _attendService.saveAttendance(event.attendance);
    emit(
      AttendanceSaved(
        isOpen: state.isOpen,
        month: state.month,
        attendance: event.attendance,
        cell: event.cell,
      ),
    );
  }
}
