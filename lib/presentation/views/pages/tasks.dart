import 'package:flutter/material.dart';
import 'package:reminder/presentation/views/pages/templates/page.dart';
import 'package:reminder/presentation/views/templates/card/card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      child: TaskList(),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(),
      itemCount: itemCount,
      itemBuilder: (_, __) => TaskCard(task),
    );
  }
}
