import 'package:attend/theme.dart';
import 'package:flutter/material.dart';

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
      home: const Scaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
