import 'package:attend/database/database.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/services/attend_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => AttendService(locator.get<AppDatabase>()));
  locator.registerLazySingleton(() => CalendarGridBloc(locator.get<AttendService>()));
  locator.registerLazySingleton(() => HeaderPanelBloc(locator.get<AttendService>()));
}
