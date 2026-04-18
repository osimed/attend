import 'dart:io';

import 'package:attend/core/extensions.dart';
import 'package:attend/core/locator.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/views/calendar_grid.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:attend/features/header_panel/views/header_panel.dart';
import 'package:attend/services/export_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeaderPanelBloc, HeaderPanelState>(
      listener: (context, state) {
        if (state is EmployeeDeleted ||
            state is EmployeeSaved ||
            state is EmployeeLaidOff) {
          context.read<CalendarGridBloc>().add(LoadMonthlyCalendar());
        }
        if (state is AttendanceSaved) {
          context.read<CalendarGridBloc>().add(
            RefreshCalendarCell(attendance: state.attendance, cell: state.cell),
          );
        }
        if (state is BulkDaySaved) {
          context.read<CalendarGridBloc>().add(
            BulkSaveAttendances(
              day: state.day,
              date: state.date,
              template: state.attendance,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HeaderPanelBloc, HeaderPanelState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  context.read<HeaderPanelBloc>().add(SeekToMonth());
                },
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      state.month.formatMonth(),
                      style: const TextStyle(fontSize: 18, wordSpacing: -2),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      CupertinoIcons.chevron_down_circle_fill,
                      size: 16,
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final currentState = context.read<CalendarGridBloc>().state;
                final month = currentState.month;
                final rows = currentState.calendar;
                if (rows.isEmpty) return;
                final pdf = await locator.get<ExportService>().genTeamPdf(
                  rows,
                  month,
                );
                final team = currentState.team.fullname.toLowerCase();
                final dir = await getApplicationCacheDirectory();
                final pdfName = '$team-${month.month}-${month.year}.pdf';
                final pdfFile = File(join(dir.path, pdfName));
                if (await pdfFile.exists()) await pdfFile.delete();
                await pdfFile.writeAsBytes(pdf);
                OpenFile.open(pdfFile.path);
              },
              icon: const Icon(CupertinoIcons.doc_text),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.person_add),
              onPressed: () {
                context.read<HeaderPanelBloc>().add(SelectEmployee());
              },
            ),
          ],
        ),
        body: Column(
          children: [
            PopScope(
              canPop: !context.watch<HeaderPanelBloc>().state.isOpen,
              onPopInvokedWithResult: (didPop, _) {
                if (!didPop) {
                  context.read<HeaderPanelBloc>().add(CloseHeaderPanel());
                }
              },
              child: const HeaderPanel(),
            ),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: CalendarGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
