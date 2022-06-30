import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class IsCompletedBox extends StatelessWidget {
  const IsCompletedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();
    final tasksViewModel = context.watch<TasksViewModel>();
    final id = viewModel.id;
    final task = tasksViewModel.tasks.singleWhere((e) => e.id == id);

    return Checkbox(
      value: task.isCompleted,
      onChanged: (value) async {
        viewModel.isCompleted = value!;
        await viewModel.editTask();
        await tasksViewModel.sync();
      },
    );
  }
}
