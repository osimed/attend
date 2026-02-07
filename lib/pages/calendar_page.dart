import 'package:attend/core/extensions.dart';
import 'package:attend/features/calendar_grid/views/calendar_grid.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:attend/features/header_panel/views/header_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HeaderPanelBloc, HeaderPanelState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                BlocProvider.of<HeaderPanelBloc>(
                  context,
                ).add(HeaderPanelChangeDateTime());
              },
              child: Row(
                mainAxisSize: .min,
                children: [
                  Text(
                    state.month.formatMonth(),
                    style: const TextStyle(fontSize: 18, wordSpacing: -2),
                  ),
                  const SizedBox(width: 3),
                  const Icon(CupertinoIcons.chevron_down_circle_fill, size: 16),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.person_add),
            onPressed: () {
              BlocProvider.of<HeaderPanelBloc>(
                context,
              ).add(HeaderPanelChangeEmployee());
            },
          ),
          IconButton(icon: const Icon(CupertinoIcons.doc_text), onPressed: () {}),
        ],
      ),
      body: const Column(
        children: [
          HeaderPanel(),
          Flexible(child: Padding(
            padding: EdgeInsets.all(2.0),
            child: CalendarGrid(),
          )),
        ],
      ),
    );
  }
}
