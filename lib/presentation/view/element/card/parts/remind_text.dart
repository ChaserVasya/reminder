import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';

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
