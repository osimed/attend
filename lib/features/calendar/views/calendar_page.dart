import 'package:attend/core/extensions.dart';
import 'package:attend/features/calendar/blocs/calendar_bloc.dart';
import 'package:attend/features/calendar/blocs/calendar_event.dart';
import 'package:attend/features/calendar/blocs/calendar_state.dart';
import 'package:attend/features/calendar/views/calendar_seek.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                final isOpen = state is CalendarSeeked && state.isOpen;
                context.read<CalendarBloc>().add(
                  CalendarSeek(isOpen: !isOpen, month: state.month),
                );
              },
              child: Row(
                mainAxisSize: .min,
                children: [
                  Text(
                    state.month.formatMonth(),
                    style: TextStyle(fontSize: 18, wordSpacing: -2),
                  ),
                  const SizedBox(width: 3),
                  Icon(CupertinoIcons.chevron_down_circle_fill, size: 16),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(icon: Icon(CupertinoIcons.person_add), onPressed: () {}),
          IconButton(icon: Icon(CupertinoIcons.doc_text), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          AnimatedSize(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 180),
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                return switch (state) {
                  CalendarSeeked state => SizedBox(
                    width: double.infinity,
                    height: state.isOpen ? 50 : 0,
                    child: CalendarSeekList(month: state.month),
                  ),
                  _ => SizedBox(height: 0, width: double.infinity),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
