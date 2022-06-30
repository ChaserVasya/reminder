import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/domain/scenario/delete.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final tasksViewModel = context.read<TasksViewModel>();

    return PopupMenuButton(
      itemBuilder: (context) => [
        ActionMenuItem(
          iconData: Icons.edit,
          text: "Редактировать",
          onPressed: () {
            //TODO Page cannot be pushed without [addPostFrameCallback]. Why?
            final callback = (_) =>
                navigator.pushNamed("/task_edit", arguments: id).then((_) => tasksViewModel.sync());
            WidgetsBinding.instance.addPostFrameCallback(callback);
          },
        ),
        ActionMenuItem(
          iconData: Icons.delete,
          text: "Удалить",
          onPressed: () async {
            await deleteTaskScenario(tasksViewModel, id);
            await tasksViewModel.sync();
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
