import 'package:flutter/material.dart';

class MedicationTile extends StatelessWidget {
  final String name;
  final String dose;
  final String time;
  final bool taken;
  final Function(bool?) onCheckboxChanged;
  final Function() onEdit;

  const MedicationTile({
    super.key,
    required this.name,
    required this.dose,
    required this.time,
    required this.taken,
    required this.onCheckboxChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text("$dose - $time"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(value: taken, onChanged: onCheckboxChanged),
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
        ],
      ),
    );
  }
}
