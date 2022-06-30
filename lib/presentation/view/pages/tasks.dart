import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/domain/scenario/delete.dart';
import 'package:reminder/presentation/view_model/tasks.dart';
import 'package:reminder/presentation/view/plug.dart';
import 'package:reminder/presentation/view/templates/card/card.dart';

import 'templates/page_content_form.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/new_task"),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Задачи"),
      ),
      body: PageContentForm(
        child: FutureBuilder(
          future: context.read<TasksViewModel>().sync(),
          builder: (_, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Plug();
              case ConnectionState.done:
                return const TaskList();
            }
          },
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  //TODO Selector doesnt see changes in list after sync
  @override
  Widget build(BuildContext context) {
    // return Selector<TasksViewModel, List<Task>>(
    //   selector: (_, viewModel) => viewModel.tasks,
    //   builder: (_, tasks, __) => ListView.builder(
    //     itemCount: tasks.length,
    //     itemBuilder: (_, i) => TaskCard(tasks[i]),
    //   ),
    // );
    final tasks = context.watch<TasksViewModel>().tasks;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, i) => TaskCard(tasks[i]),
    );
  }
}
