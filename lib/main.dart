import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/pages/calendar_page.dart';
import 'package:attend/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: BlocProvider(
        create: (_) => HeaderPanelBloc(),
        child: const CalendarPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
