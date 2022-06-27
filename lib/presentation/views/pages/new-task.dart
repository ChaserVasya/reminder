import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TaskField(),
      ],
    );
  }
}

class TaskField extends StatelessWidget {
  const TaskField({Key? key}) : super(key: key);

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

class DateTimeField extends StatelessWidget {
  const DateTimeField({Key? key}) : super(key: key);

  var DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Text("Дата: ${DateFormat.yMd().format(dateTime.toLocal())}"),
         Text("Время: ${DateFormat.Hm().format(dateTime.toLocal())}"),
     ],
    );
  }
}

