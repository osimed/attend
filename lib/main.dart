import 'package:attend/core/locator.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/database_sync/blocs/database_sync_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/pages/calendar_page.dart';
import 'package:attend/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerLazySingletons();
  runApp(const Attend());
}

class Attend extends StatelessWidget {
  const Attend({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attend',
      theme: MaterialTheme.light(),
      darkTheme: MaterialTheme.dark(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: locator.get<HeaderPanelBloc>()),
          BlocProvider.value(
            value: locator.get<CalendarGridBloc>()..add(LoadMonthlyCalendar()),
          ),
          BlocProvider.value(value: locator.get<DatabaseSyncBloc>()),
        ],
        child: const CalendarPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
