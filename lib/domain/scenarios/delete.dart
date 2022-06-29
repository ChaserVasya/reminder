import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_models/tasks.dart';

Future<void> deleteTaskScenario(BuildContext context, int id) async {
  final viewModel = context.read<TasksViewModel>();

  final delete = await showDialog<bool>(
    context: context,
    builder: (context) => DeleteDialog(context),
  );

  if (delete ?? false) await viewModel.delete(id);
}

class DeleteDialog extends AlertDialog {
  DeleteDialog(BuildContext context, {Key? key})
      : super(
          key: key,
          title: const Text("Удалить задачу?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Отменить'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Продолжить'),
            ),
          ],
        );
}
