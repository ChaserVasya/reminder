import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/navigator.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/domain/scenario/delete.dart';
import 'package:reminder/presentation/view/element/plug/element.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class TaskCardListened extends StatelessWidget {
  const TaskCardListened(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskEditViewModel>(
      create: (_) => TaskEditViewModel(id),
      builder: (context, __) {
        return FutureBuilder(
          future: context.read<TaskEditViewModel>().fetching,
          builder: (context, snap) {
            final viewModel = context.watch<TaskEditViewModel>();

            if (snap.connectionState != ConnectionState.done) return const ElementPlug();

            Widget widget = Row(
              children: const [
                IsCompletedBox(),
                CardContent(),
                Spacer(),
                ActionMenu(),
              ],
            );

            if (viewModel.needToRemind) {
              widget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget,
                  const RemindText(),
                ],
              );
            }

            return Card(child: widget);
          },
        );
      },
    );
  }
}

class IsCompletedBox extends StatelessWidget {
  const IsCompletedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();

    return Checkbox(
      value: viewModel.isCompleted,
      onChanged: (value) async {
        viewModel.isCompleted = value!;
        viewModel.editTask();
      },
    );
  }
}

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

class CardContent extends StatelessWidget {
  const CardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<TaskEditViewModel>().controller.text);
  }
}

class RemindText extends StatelessWidget {
  const RemindText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();

    final dateTime = DateTimeFactory.from(viewModel.date, viewModel.time);
    final dateTimeText = DateFormat.yMd().add_Hm().format(dateTime.toLocal());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Напоминание: $dateTimeText",
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
