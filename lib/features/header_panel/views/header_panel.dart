import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:attend/features/header_panel/views/datetime_list.dart';
import 'package:attend/features/header_panel/views/edit_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderPanel extends StatelessWidget {
  const HeaderPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 180),
      child: BlocBuilder<HeaderPanelBloc, HeaderPanelState>(
        builder: (context, state) {
          return switch (state) {
            HeaderPanelDateTime state => SizedBox(
              width: double.infinity,
              height: state.isOpen ? 50 : 0,
              child: DateTimeList(month: state.month),
            ),
            HeaderPanelEmployee state => SizedBox(
              width: double.infinity,
              height: state.isOpen ? null : 0,
              child: EditEmployee(employee: state.employee),
            ),
          };
        },
      ),
    );
  }
}
