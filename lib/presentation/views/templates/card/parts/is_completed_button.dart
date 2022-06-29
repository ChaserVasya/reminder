import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_models/task_edit.dart';

class IsCompletedButton extends StatelessWidget {
  const IsCompletedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: context.watch<TaskEditViewModel>().isCompleted,
      onChanged: (value) => context.read<TaskEditViewModel>().isCompleted = value!,
    );
  }
}
