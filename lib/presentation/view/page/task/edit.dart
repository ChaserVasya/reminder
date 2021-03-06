import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/navigator.dart';
import 'package:reminder/presentation/view/element/task_details/content_field.dart';
import 'package:reminder/presentation/view/element/task_details/date_time_field.dart';
import 'package:reminder/presentation/view/element/task_details/is_completed_box.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';
import 'package:reminder/presentation/view/element/plug/page.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

import '../templates/page_content_form.dart';

class TaskEditPage extends StatelessWidget {
  const TaskEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return ChangeNotifierProvider(
      create: (_) => TaskEditViewModel(id),
      builder: (context, _) => FutureBuilder(
        future: context.read<TaskEditViewModel>().fetching,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) return const PagePlug();

          return Scaffold(
            appBar: AppBar(
              title: const Text("Редактирование"),
              actions: [
                Builder(
                  builder: (context) {
                    final editViewModel = context.watch<TaskEditViewModel>();
                    return TextButton(
                      onPressed: (editViewModel.contentIsEmpty)
                          ? null
                          : () async {
                              final tasksViewModel = context.read<TasksViewModel>();
                              await editViewModel.editTask();
                              await tasksViewModel.sync();
                              navigator.pop();
                            },
                      child: Text(
                        "Сохранить",
                        style: TextStyle(
                            color: (editViewModel.contentIsEmpty)
                                ? Colors.white54
                                : Theme.of(context).canvasColor),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: PageContentForm(
              child: Column(
                children: const [
                  ContentField<TaskEditViewModel>(),
                  IsCompletedBox<TaskEditViewModel>(),
                  DateTimeField<TaskEditViewModel>(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
