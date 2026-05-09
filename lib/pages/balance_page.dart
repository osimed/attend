import 'package:attend/core/extensions.dart';
import 'package:attend/core/locator.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_bloc.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_event.dart';
import 'package:attend/features/calendar_grid/blocs/calendar_grid_state.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final editingEmployee = ValueNotifier<int?>(null);
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarGridBloc, CalendarGridState>(
      buildWhen: (_, newState) => newState is MonthlyCalendarLoaded,
      builder: (context, _) {
        final state = context.read<CalendarGridBloc>().state;
        final nextMonth = DateTime(state.month.year, state.month.month + 1);
        final attSrv = locator.get<AttendService>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${state.month.formatMonth()}  →  ${nextMonth.formatMonth()}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          body: ListView.builder(
            itemCount: state.calendar.length,
            itemExtent: 80,
            itemBuilder: (context, index) {
              final employee = state.calendar[index].employee;

              return ListTile(
                contentPadding: const .only(left: 8),
                leading: Text(employee.sap.toString()),
                title: Text(
                  employee.lastName,
                  style: const TextStyle(fontWeight: .w700),
                ),
                subtitle: Text(employee.firstName),
                trailing: Row(
                  mainAxisSize: .min,
                  mainAxisAlignment: .end,
                  children: [
                    FutureBuilder(
                      future: attSrv.calcOpeningBalance(employee, nextMonth),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != .done) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Text('error');
                        }
                        final result = snapshot.data!;
                        return ValueListenableBuilder(
                          valueListenable: editingEmployee,
                          builder: (context, value, child) {
                            if (value == index) {
                              return SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: result.balance.formatTime(),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: result.isOverridden
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.tertiaryContainer
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              child: Text(
                                result.balance.formatTime(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: .w800,
                                  color: result.isOverridden
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onTertiaryContainer
                                      : null,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: editingEmployee,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: () async {
                            if (editingEmployee.value == index) {
                              final v = _textController.text.parseTime();
                              if (v != null) {
                                await attSrv.closeMonth(
                                  state.calendar[index],
                                  state.month,
                                  overrideValue: v,
                                );
                                locator.get<CalendarGridBloc>().add(
                                  LoadMonthlyCalendar(
                                    month: state.month,
                                    team: state.team,
                                  ),
                                );
                              }
                              editingEmployee.value = null;
                            } else {
                              editingEmployee.value = index;
                            }
                            _textController.clear();
                          },
                          icon: value == index
                              ? const Icon(Icons.done)
                              : const Icon(Icons.edit),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
