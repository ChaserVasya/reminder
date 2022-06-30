import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';
import 'package:reminder/presentation/view_model/tasks.dart';
import 'package:reminder/presentation/view/plug.dart';

import 'templates/page_content_form.dart';

class TaskEditPage extends StatelessWidget {
  const TaskEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return ChangeNotifierProvider(
      create: (_) => TaskEditViewModel(id),
      builder: (context, _) => FutureBuilder(
        future: context.read<TaskEditViewModel>().fetchTask(),
        builder: (context, _) {
          switch (context.watch<TaskEditViewModel>().status) {
            case Status.sync:
              return const Plug();
            case Status.synced:
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text("Редактирование задачи"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // final tasksViewModel = context.read<TasksViewModel>();
                        await context.read<TaskEditViewModel>().editTask();
                        navigator.pop();
                        // await tasksViewModel.sync();
                      },
                      child: Text(
                        "Сохранить",
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      ),
                    ),
                  ],
                ),
                body: PageContentForm(
                  child: Column(
                    children: const [
                      ContentField(),
                      IsCompletedBox(),
                      DateTimeField(),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class IsCompletedBox extends StatelessWidget {
  const IsCompletedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();

    return Row(
      children: [
        Checkbox(
          value: viewModel.isCompleted,
          onChanged: (value) => viewModel.isCompleted = value!,
        ),
        const Text("Выполнено"),
      ],
    );
  }
}

class ContentField extends StatelessWidget {
  const ContentField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Задача"),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue[500]!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: context.read<TaskEditViewModel>().controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimeField extends StatefulWidget {
  const DateTimeField({Key? key}) : super(key: key);

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

//TODO Refactor. Think about reminder adding logic.
class _DateTimeFieldState extends State<DateTimeField> {
  @override
  Widget build(BuildContext context) {
    final date = context.watch<TaskEditViewModel>().date;
    final time = context.watch<TaskEditViewModel>().time;

    final dateText = DateFormat.yMd().format(date.toLocal());
    final timeText = time.format(context);

    final viewModel = context.watch<TaskEditViewModel>();

    final needToRemindBox = Row(
      children: [
        Checkbox(
          value: viewModel.needToRemind,
          onChanged: (value) => viewModel.needToRemind = value!,
        ),
        const Text("Напоминание"),
      ],
    );

    switch (viewModel.needToRemind) {
      case false:
        return needToRemindBox;
      case true:
        return Column(
          children: [
            needToRemindBox,
            Row(
              children: [
                Text("Дата: $dateText"),
                IconButton(
                  onPressed: pickDate,
                  icon: const Icon(Icons.calendar_month),
                ),
                Text("Время: $timeText"),
                IconButton(
                  onPressed: pickTime,
                  icon: const Icon(Icons.watch_later),
                ),
              ],
            ),
          ],
        );
    }

    throw Exception();
  }

  Future<void> pickTime() async {
    final viewModel = context.read<TaskEditViewModel>();

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (time != null) viewModel.time = time;
  }

  Future<void> pickDate() async {
    final viewModel = context.read<TaskEditViewModel>();

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) viewModel.date = date;
  }
}
