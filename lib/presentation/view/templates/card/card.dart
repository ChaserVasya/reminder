import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';

import 'parts/content.dart';
import 'parts/is_completed_box.dart';
import 'parts/menu.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ChangeNotifierProvider<TaskEditViewModel>(
          create: (_) => TaskEditViewModel.from(task),
          builder: (context, __) {
            //TODO remove this trick. Notifier is not recreated on new build
            context.read<TaskEditViewModel>().refreshWith(task);
            return Row(
              children: const [
                IsCompletedBox(),
                CardContent(),
                Spacer(),
                ActionMenu(),
              ],
            );
          }),
    );
  }
}
