import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view/element/task_details/content_field.dart';
import 'package:reminder/presentation/view/element/task_details/date_time_field.dart';
import 'package:reminder/presentation/view/page/templates/page_content_form.dart';
import 'package:reminder/presentation/view_model/task/new.dart';
import 'package:reminder/presentation/view/element/plug/page.dart';
import 'package:reminder/presentation/view_model/task.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewTaskViewModel(),
      builder: (context, _) {
        final createViewModel = context.watch<NewTaskViewModel>();
        switch (createViewModel.status) {
          case Status.sync:
            return const PagePlug();
          case Status.synced:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Новая задача"),
                actions: [
                  TextButton(
                    onPressed: (createViewModel.contentIsEmpty)
                        ? null
                        : () async {
                            final tasksViewModel = context.read<TasksViewModel>();
                            await createViewModel.setTask();
                            await tasksViewModel.sync();
                            navigator.pop();
                          },
                    child: Text(
                      "Создать",
                      style: TextStyle(
                          color: (createViewModel.contentIsEmpty)
                              ? Colors.white54
                              : Theme.of(context).canvasColor),
                    ),
                  ),
                ],
              ),
              body: PageContentForm(
                child: Column(
                  children: const [
                    ContentField<NewTaskViewModel>(),
                    DateTimeField<NewTaskViewModel>(),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
