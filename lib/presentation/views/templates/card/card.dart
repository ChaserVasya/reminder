import 'package:flutter/material.dart';
import 'package:reminder/domain/entities/task.dart';

import 'parts/content.dart';
import 'parts/is_completed_button.dart';
import 'parts/menu.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          IsCompletedButton(task.isCompleted),
          CardContent(task.content),
          const ActionMenu(),
        ],
      ),
    );
  }
}
