import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/navigator.dart';
import 'package:reminder/domain/scenario/delete.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();
    final tasksViewModel = context.watch<TasksViewModel>();

    return PopupMenuButton(
      itemBuilder: (context) => [
        ActionMenuItem(
          iconData: Icons.edit,
          text: "Редактировать",
          onPressed: () {
            final callback = (_) => navigator.pushNamed("/task_edit", arguments: viewModel.id);
            WidgetsBinding.instance.addPostFrameCallback(callback);
          },
        ),
        ActionMenuItem(
          iconData: Icons.delete,
          text: "Удалить",
          onPressed: () async {
            await deleteTaskScenario(tasksViewModel, viewModel.id);
          },
        ),
      ],
    );
  }
}

class ActionMenuItem extends PopupMenuItem {
  ActionMenuItem({
    Key? key,
    required IconData iconData,
    required String text,
    required void Function() onPressed,
  }) : super(
          key: key,
          onTap: onPressed,
          child: Row(children: [
            Icon(iconData),
            Text(text),
          ]),
        );
}
