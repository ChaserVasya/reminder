import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/domain/entity/task.dart';

import 'parts/content.dart';
import 'parts/is_completed_box.dart';
import 'parts/menu.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    Widget widget = Row(
      children: [
        IsCompletedBox(task.id),
        CardContent(task.content),
        const Spacer(),
        ActionMenu(task.id),
      ],
    );

    if (task.reminder != null) {
      final dateText = DateFormat.yMd().add_Hm().format(task.reminder!.toLocal());
      widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Напоминание: $dateText",
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      );
    }

    return Card(child: widget);
  }
}
