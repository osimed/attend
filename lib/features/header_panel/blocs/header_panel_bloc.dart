import 'package:attend/database/database.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderPanelBloc extends Bloc<HeaderPanelEvent, HeaderPanelState> {
  final AttendService _attendService;

  HeaderPanelBloc(this._attendService)
    : super(PickingAMonth(month: DateTime.now())) {
    on<CloseHeaderPanel>(_onCloseHeaderPanel);
    on<SeekToMonth>(_onSeekToMonth);
    on<SelectEmployee>(_onSelectEmployee);
    on<SaveEmployee>(_onSaveEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
    on<LayoffEmployee>(_onLayoffEmployee);
    on<SelectAttendance>(_onSelectAttendance);
    on<SaveAttendance>(_onSaveAttendance);
    on<BulkSelectDay>(_onBulkSelectDay);
    on<BulkSaveDay>(_onBulkSaveDay);
  }
  Future<void> _onCloseHeaderPanel(
    CloseHeaderPanel event,
    Emitter<HeaderPanelState> emit,
  ) async {
    emit(switch (state) {
      PickingAMonth s => PickingAMonth(isOpen: false, month: s.month),
      EditingEmployee s => EditingEmployee(
        isOpen: false,
        month: s.month,
        employee: s.employee,
      ),
      EditingAttendance s => EditingAttendance(
        isOpen: false,
        month: s.month,
        cell: s.cell,
        attendance: s.attendance,
      ),
      EditingBulkDay s => EditingBulkDay(
        isOpen: false,
        month: s.month,
        day: s.day,
        date: s.date,
        attendance: s.attendance,
      ),
    });
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
    emit(EmployeeSaved(month: state.month, isOpen: true, employee: null));
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

  Future<void> _onLayoffEmployee(
    LayoffEmployee event,
    Emitter<HeaderPanelState> emit,
  ) async {
    await _attendService.layoffEmployee(
      event.employeeId,
      event.left,
      event.reason,
    );
    emit(EmployeeLaidOff(month: state.month, isOpen: false));
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

  Future<void> _onBulkSelectDay(
    BulkSelectDay event,
    Emitter<HeaderPanelState> emit,
  ) async {
    final isOpen =
        state is EditingBulkDay &&
        state.isOpen &&
        (state as EditingBulkDay).day == event.day;
    emit(
      EditingBulkDay(
        isOpen: !isOpen,
        month: state.month,
        day: event.day,
        date: event.date,
        attendance: Attendance(
          employeeId: -1,
          date: event.date,
          status: .empty,
          lunchBreak: true,
        ),
      ),
    );
  }

  Future<void> _onBulkSaveDay(
    BulkSaveDay event,
    Emitter<HeaderPanelState> emit,
  ) async {
    emit(
      BulkDaySaved(
        isOpen: state.isOpen,
        month: state.month,
        day: event.day,
        date: event.date,
        attendance: event.attendance,
      ),
    );
  }
}
