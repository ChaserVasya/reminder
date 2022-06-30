import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class IsCompletedBox extends StatelessWidget {
  const IsCompletedBox(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TasksViewModel>();

    final task = viewModel.tasks.singleWhere((e) => e.id == id);

    return Checkbox(
      value: task.isCompleted,
      onChanged: (value) async {
        final changedTask = Task.named(
          id: task.id,
          content: task.content,
          isCompleted: value!,
          reminder: task.reminder,
        );

        await viewModel.set(changedTask);
      },
    );
  }
}
