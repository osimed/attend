import 'package:attend/features/calendar/blocs/calendar_bloc.dart';
import 'package:attend/theme.dart';
import 'package:attend/features/calendar/views/calendar_page.dart';
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
        create: (_) => CalendarBloc(),
        child: const CalendarPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
