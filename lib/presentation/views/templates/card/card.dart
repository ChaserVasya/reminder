import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/domain/entities/task.dart';
import 'package:reminder/presentation/view_models/task_edit.dart';
import 'package:reminder/presentation/view_models/tasks.dart';

import 'parts/content.dart';
import 'parts/is_completed_button.dart';
import 'parts/menu.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    print("card id: ${task.id}");
    if (task.id == 1) print("text: ${task.content}");

    return Card(
      child: ChangeNotifierProvider<TaskEditViewModel>(
          create: (_) => TaskEditViewModel.from(task),
          builder: (context, __) {
            //TODO remove this trick. Notifier is not recreated on new build
            context.read<TaskEditViewModel>().refreshWith(task);
            return Row(
              children: const [
                IsCompletedButton(),
                CardContent(),
                Spacer(),
                ActionMenu(),
              ],
            );
          }),
    );
  }
}
