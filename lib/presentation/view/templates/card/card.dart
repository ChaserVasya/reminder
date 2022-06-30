import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

import 'parts/content.dart';
import 'parts/is_completed_box.dart';
import 'parts/menu.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ChangeNotifierProvider<TaskEditViewModel>(
          create: (_) => TaskEditViewModel.from(widget.task),
          builder: (context, __) {
            final viewModel = context.watch<TaskEditViewModel>();

            //TODO remove this trick. Notifier is not recreated on new build
            viewModel.refreshWith(widget.task);

            final mainContent = Row(
              children: const [
                IsCompletedBox(),
                CardContent(),
                Spacer(),
                ActionMenu(),
              ],
            );

            final tasksViewModel = context.watch<TasksViewModel>();
            final task = tasksViewModel.tasks.singleWhere((e) => e.id == widget.task.id);
            if (task.reminder != null) {
              final dateText = DateFormat.yMd().add_jm().format(task.reminder!.toLocal());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainContent,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Напоминание: $dateText",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              );
            } else {
              return mainContent;
            }
          }),
    );
  }
}
