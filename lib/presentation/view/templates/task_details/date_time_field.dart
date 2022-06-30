import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task.dart';

class DateTimeField<T extends TaskViewModel> extends StatelessWidget {
  const DateTimeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<T>();

    final date = viewModel.date;
    final time = viewModel.time;

    final dateText = DateFormat.yMd().format(date.toLocal());
    final timeText = time.format(context);

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
                  onPressed: () => pickDate(context),
                  icon: const Icon(Icons.calendar_month),
                ),
                Text("Время: $timeText"),
                IconButton(
                  onPressed: () => pickTime(context),
                  icon: const Icon(Icons.watch_later),
                ),
              ],
            ),
          ],
        );
    }

    throw Exception();
  }

  Future<void> pickTime(BuildContext context) async {
    final viewModel = context.read<T>();

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (time != null) viewModel.time = time;
  }

  Future<void> pickDate(BuildContext context) async {
    final viewModel = context.read<T>();

    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) viewModel.date = date;
  }
}