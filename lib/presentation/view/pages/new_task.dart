import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view/pages/templates/page_content_form.dart';
import 'package:reminder/presentation/view/templates/task_details/content_field.dart';
import 'package:reminder/presentation/view/templates/task_details/date_time_field.dart';
import 'package:reminder/presentation/view_model/new_task.dart';
import 'package:reminder/presentation/view/plug.dart';
import 'package:reminder/presentation/view_model/task.dart';
import 'package:reminder/presentation/view_model/tasks.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewTaskViewModel(),
      builder: (context, _) {
        switch (context.watch<NewTaskViewModel>().status) {
          case Status.sync:
            return const Plug();
          case Status.synced:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Новая задача"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      final tasksViewModel = context.read<TasksViewModel>();
                      await context.read<NewTaskViewModel>().setTask();
                      await tasksViewModel.sync();
                      navigator.pop();
                    },
                    child: Text(
                      "Создать",
                      style: TextStyle(color: Theme.of(context).canvasColor),
                    ),
                  ),
                ],
              ),
              body: PageContentForm(
                child: Column(
                  children: const [
                    ContentField<NewTaskViewModel>(),
                    DateTimeField<NewTaskViewModel>(),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

// class ContentField extends StatelessWidget {
//   const ContentField({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.blue[500]!,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: const TextField(
//         keyboardType: TextInputType.multiline,
//         maxLines: null,
//       ),
//     );
//   }
// }

// class DateTimeField extends StatefulWidget {
//   const DateTimeField({Key? key}) : super(key: key);

//   @override
//   State<DateTimeField> createState() => _DateTimeFieldState();
// }

// class _DateTimeFieldState extends State<DateTimeField> {
//   @override
//   Widget build(BuildContext context) {
//     final date = context.watch<NewTaskViewModel>().date;
//     final time = context.watch<NewTaskViewModel>().time;

//     final dateText = (date != null) ? DateFormat.yMd().format(date.toLocal()) : "";
//     final timeText = time?.format(context) ?? "";

//     return Row(
//       children: [
//         Text("Дата: $dateText"),
//         IconButton(
//           onPressed: pickDate,
//           icon: const Icon(Icons.calendar_month),
//         ),
//         Text("Время: $timeText"),
//         IconButton(
//           onPressed: pickTime,
//           icon: const Icon(Icons.watch_later),
//         ),
//       ],
//     );
//   }

//   Future<void> pickTime() async {
//     final viewModel = context.read<NewTaskViewModel>();

//     final time = await showTimePicker(
//       context: context,
//       initialTime: const TimeOfDay(hour: 0, minute: 0),
//     );
//     viewModel.time = time;
//   }

//   Future<void> pickDate() async {
//     final viewModel = context.read<NewTaskViewModel>();

//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     viewModel.date = date;
//   }

//   @override
//   void dispose() {
//     context.read<NewTaskViewModel>().controller.dispose();
//     super.dispose();
//   }
// }
