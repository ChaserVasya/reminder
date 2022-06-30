import 'package:flutter/material.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

Future<void> deleteTaskScenario(TasksViewModel tasksViewModel, int id) async {
  await Future.value(); //TODO Without it dialog can`t be shown. Why?

  final delete = await showDialog<bool>(
    context: navigator.context,
    builder: (_) => DeleteDialog(),
  );

  if (delete ?? false) await tasksViewModel.delete(id);
}

class DeleteDialog extends AlertDialog {
  DeleteDialog({Key? key})
      : super(
          key: key,
          title: const Text("Удалить задачу?"),
          actions: [
            TextButton(
              onPressed: () => navigator.pop(false),
              child: const Text('Отменить'),
            ),
            TextButton(
              onPressed: () => navigator.pop(true),
              child: const Text('Продолжить'),
            ),
          ],
        );
}
