import 'package:attend/database/database.dart';
import 'package:flutter/material.dart';

class SaveEmployee extends StatefulWidget {
  final Employee? employee;

  const SaveEmployee({super.key, this.employee});

  @override
  State<SaveEmployee> createState() => _SaveEmployeeState();
}

class _SaveEmployeeState extends State<SaveEmployee> {
  final formKey = GlobalKey<FormState>();
  late final firstNameController = TextEditingController(
    text: widget.employee?.firstName,
  );
  late final lastNameController = TextEditingController(
    text: widget.employee?.lastName,
  );
  late final collectedController = TextEditingController(
    text: widget.employee?.collected.toString(),
  );
  late Team team = widget.employee?.team ?? .exp;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "prénom", filled: true),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: "nom", filled: true),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: .end,
              children: [
                Expanded(
                  child: DropdownButtonFormField<Team>(
                    initialValue: team,
                    decoration: const InputDecoration(
                      labelText: "équipe",
                      filled: true,
                    ),
                    items: [
                      for (final t in Team.values)
                        DropdownMenuItem(value: t, child: Text(t.name)),
                    ],
                    onChanged: (t) {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: collectedController,
                    keyboardType: .number,
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
                      onPressed: () {},
                      style: FilledButton.styleFrom(minimumSize: Size.infinite),
                      icon: const Icon(Icons.save),
                      label: const Text("Sauvegarder"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () {},

                      style: FilledButton.styleFrom(minimumSize: Size.infinite),
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
