import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEmployee extends StatefulWidget {
  final Employee? employee;

  const EditEmployee({super.key, this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final formKey = GlobalKey<FormState>();
  late int? currentEmployeeId = widget.employee?.id;
  late final firstNameController = TextEditingController(
    text: widget.employee?.firstName,
  );
  late final lastNameController = TextEditingController(
    text: widget.employee?.lastName,
  );
  late final collectedController = TextEditingController(
    text: widget.employee?.collected.formatTime(),
  );
  late Team team = widget.employee?.team ?? .exp;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeaderPanelBloc, HeaderPanelState>(
      listener: (context, state) {
        if (state is EditingEmployee) {
          currentEmployeeId = state.employee?.id;
          firstNameController.text = state.employee?.firstName ?? '';
          lastNameController.text = state.employee?.lastName ?? '';
          team = state.employee?.team ?? .exp;
          collectedController.text =
              state.employee?.collected.formatTime() ?? '';
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: .min,
            children: [
              TextFormField(
                controller: firstNameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "prénom",
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "nom",
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: .start,
                mainAxisSize: .max,
                children: [
                  Expanded(
                    child:
                        BlocSelector<HeaderPanelBloc, HeaderPanelState, Team>(
                          selector: (state) {
                            return state is EditingEmployee
                                ? state.employee?.team ?? .exp
                                : .exp;
                          },
                          builder: (context, stateTeam) {
                            return DropdownButtonFormField<Team>(
                              initialValue: stateTeam,
                              decoration: const InputDecoration(
                                labelText: "équipe",
                                filled: true,
                              ),
                              items: [
                                for (final t in Team.values)
                                  DropdownMenuItem(
                                    value: t,
                                    child: Text(t.name),
                                  ),
                              ],
                              onChanged: (t) => team = t ?? team,
                            );
                          },
                        ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: collectedController,
                      keyboardType: .number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Ce champ est obligatoire';
                        }
                        if (value!.parseTime() == null) {
                          return 'format requis heure,minutes';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "épargne",
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<HeaderPanelBloc>().add(
                              ConfirmSaveEmployee(
                                Employee(
                                  id: currentEmployeeId ?? -1,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  team: team,
                                  collected:
                                      collectedController.text.parseTime() ??
                                      .zero,
                                ),
                              ),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: Size.infinite,
                        ),
                        icon: const Icon(Icons.save),
                        label: const Text("Sauvegarder"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: widget.employee == null
                            ? null
                            : () {
                                context.read<HeaderPanelBloc>().add(
                                  ConfirmDeleteEmployee(widget.employee!),
                                );
                              },
                        style: FilledButton.styleFrom(
                          minimumSize: Size.infinite,
                        ),
                        icon: const Icon(Icons.delete),
                        label: const Text("Supprimer"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    collectedController.dispose();
    super.dispose();
  }
}
