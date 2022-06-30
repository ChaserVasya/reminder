import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view/pages/templates/page_content_form.dart';
import 'package:reminder/presentation/view_model/new_task.dart';
import 'package:reminder/presentation/view/plug.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewTaskViewModel(),
      builder: (context, _) {
        switch (context.watch<NewTaskViewModel>().status) {
          case Status.none:
            return PageContentForm(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Новая задача"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await context.read<NewTaskViewModel>().setTask();
                        navigator.pop();
                      },
                      child: const Text("Создать"),
                    )
                  ],
                ),
                body: Column(
                  children: const [
                    ContentField(),
                    DateTimeField(),
                  ],
                ),
              ),
            );
          case Status.setting:
            return const CircularProgressIndicator();
          case Status.setted:
            return const Plug();
        }
      },
    );
  }
}

class ContentField extends StatelessWidget {
  const ContentField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue[500]!,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}

class DateTimeField extends StatefulWidget {
  const DateTimeField({Key? key}) : super(key: key);

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  @override
  Widget build(BuildContext context) {
    final date = context.watch<NewTaskViewModel>().date;
    final time = context.watch<NewTaskViewModel>().time;

    final dateText = (date != null) ? DateFormat.yMd().format(date.toLocal()) : "";
    final timeText = time?.format(context) ?? "";

    return Row(
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
    );
  }

  Future<void> pickTime() async {
    final viewModel = context.read<NewTaskViewModel>();

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    viewModel.time = time;
  }

  Future<void> pickDate() async {
    final viewModel = context.read<NewTaskViewModel>();

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    viewModel.date = date;
  }

  @override
  void dispose() {
    context.read<NewTaskViewModel>().controller.dispose();
    super.dispose();
  }
}
