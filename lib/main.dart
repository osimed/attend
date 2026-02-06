import 'package:attend/theme.dart';
import 'package:flutter/material.dart';

void main() {
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
