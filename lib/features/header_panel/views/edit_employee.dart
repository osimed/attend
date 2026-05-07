import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/features/header_panel/blocs/header_panel_bloc.dart';
import 'package:attend/features/header_panel/blocs/header_panel_event.dart';
import 'package:attend/features/header_panel/blocs/header_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditEmployee extends StatefulWidget {
  final Employee? employee;

  const EditEmployee({super.key, this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final formKey = GlobalKey<FormState>();
  late final firstNameController = TextEditingController(
    text: widget.employee?.firstName,
  );
  late final lastNameController = TextEditingController(
    text: widget.employee?.lastName,
  );
  late final sapController = TextEditingController(
    text: widget.employee?.sap.toString(),
  );
  late final jobController = TextEditingController(text: widget.employee?.job);
  late final suggestionsController = SuggestionsController<String>();
  late final collectedController = TextEditingController(
    text: widget.employee?.collected.formatTime(),
  );
  late Team team = widget.employee?.team ?? .exp;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeaderPanelBloc, HeaderPanelState>(
      listener: (context, state) {
        if (state is EditingEmployee) {
          sapController.text = state.employee?.sap.toString() ?? '';
          firstNameController.text = state.employee?.firstName ?? '';
          lastNameController.text = state.employee?.lastName ?? '';
          jobController.text = state.employee?.job ?? '';
          collectedController.text =
              state.employee?.collected.formatTime() ?? '';
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, boxC) {
              if (boxC.maxWidth > 700) {
                return Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Flexible(child: buildIdTextField()),
                          const SizedBox(width: 5),
                          Flexible(child: buildFirstNameField()),
                          const SizedBox(width: 5),
                          Flexible(child: buildLastNameField()),
                          const SizedBox(width: 5),
                          Expanded(child: buildSaveEmployeeButton(context)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Flexible(child: buildTeamSelector()),
                          const SizedBox(width: 5),
                          Flexible(child: buildJobTextField()),
                          const SizedBox(width: 5),
                          Flexible(child: buildCollectedTimeField()),
                          const SizedBox(width: 5),
                          Expanded(child: buildDeleteEmployeeButton(context)),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisSize: .min,
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    mainAxisSize: .max,
                    children: [
                      Expanded(child: buildFirstNameField()),
                      const SizedBox(width: 5),
                      Expanded(child: buildLastNameField()),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: .start,
                    mainAxisSize: .max,
                    children: [
                      Expanded(child: buildIdTextField()),
                      const SizedBox(width: 5),
                      Expanded(child: buildJobTextField()),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: .start,
                    mainAxisSize: .max,
                    children: [
                      Expanded(child: buildTeamSelector()),
                      const SizedBox(width: 5),
                      Expanded(child: buildCollectedTimeField()),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        Expanded(child: buildSaveEmployeeButton(context)),
                        const SizedBox(width: 5),
                        Expanded(child: buildDeleteEmployeeButton(context)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  FilledButton buildDeleteEmployeeButton(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: widget.employee == null
          ? null
          : () {
              context.read<HeaderPanelBloc>().add(
                DeleteEmployee(widget.employee!),
              );
            },
      style: FilledButton.styleFrom(
        minimumSize: Size.infinite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.delete),
      label: const Text("Supprimer"),
    );
  }

  FilledButton buildSaveEmployeeButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<HeaderPanelBloc>().add(
            SaveEmployee(
              Employee(
                id: widget.employee?.id ?? -1,
                sap: int.parse(sapController.text),
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                job: jobController.text,
                team: team,
                collected: collectedController.text.parseTime() ?? .zero,
                sortOrder: DateTime.now().millisecondsSinceEpoch,
                createdAt: DateTime.now(),
              ),
            ),
          );
        }
      },
      style: FilledButton.styleFrom(
        minimumSize: Size.infinite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.save),
      label: const Text("Sauvegarder"),
    );
  }

  TextFormField buildCollectedTimeField() {
    return TextFormField(
      controller: collectedController,
      keyboardType: .number,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
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
        labelText: "heures collectées",
        filled: true,
      ),
    );
  }

  Widget buildTeamSelector() {
    return BlocSelector<HeaderPanelBloc, HeaderPanelState, Team>(
      selector: (state) {
        return state is EditingEmployee ? state.employee?.team ?? .exp : .exp;
      },
      builder: (context, stateTeam) {
        return DropdownButtonFormField<Team>(
          initialValue: stateTeam,
          decoration: const InputDecoration(labelText: "équipe", filled: true),
          items: [
            for (final t in Team.values)
              DropdownMenuItem(value: t, child: Text(t.fullname)),
          ],
          onChanged: (t) {
            team = t ?? team;
            suggestionsController.refresh();
          },
        );
      },
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      controller: lastNameController,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Ce champ est obligatoire';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: "nom", filled: true),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      controller: firstNameController,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Ce champ est obligatoire';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: "prénom", filled: true),
    );
  }

  TextFormField buildIdTextField() {
    return TextFormField(
      controller: sapController,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Ce champ est obligatoire';
        }
        if (int.tryParse(value!) == null) {
          return 'Un numéro est reqius';
        }
        return null;
      },
      decoration: const InputDecoration(labelText: "sap", filled: true),
    );
  }

  TypeAheadField buildJobTextField() {
    return TypeAheadField<String>(
      controller: jobController,
      suggestionsController: suggestionsController,
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          decoration: const InputDecoration(labelText: 'poste', filled: true),
        );
      },
      hideOnEmpty: true,
      suggestionsCallback: (s) {
        if (s.isNotEmpty) return [];
        return _jobSuggestions(team);
      },
      constraints: BoxConstraints.tightFor(
        width: MediaQuery.of(context).size.width - 20,
      ),
      constrainWidth: false,
      onSelected: (value) {
        jobController.text = value;
      },
      listBuilder: (context, children) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8, runSpacing: -2, children: children),
      ),
      itemBuilder: (context, job) {
        return Chip(label: Text(job));
      },
    );
  }

  List<String> _jobSuggestions(Team team) {
    return switch (team) {
      .exp => [
        'Chef Expédition',
        'Assistant Chef Expédition',
        'Chauffeur',
        'Assistant Chauffeur',
        'Technicien Mécanique',
        'Technicien',
        'Contrôleur',
      ],
      .rss => [
        'Chef Rassemblement',
        'Assistant Chef Rassemblement',
        'Chef Réception',
        'Assistant Chef Réception',
        'Contrôleur',
        'Sélecteur',
        'Porteur',
        'Cariste',
        'Manutentionnaire',
        'IT opérateur',
        'Agent de nettoyage',
        'Agent de sécurité',
        'Technicien',
      ],
    };
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    sapController.dispose();
    jobController.dispose();
    suggestionsController.dispose();
    collectedController.dispose();
    super.dispose();
  }
}
