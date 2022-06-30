import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/application/error/show_exception_dialog.dart';
import 'package:reminder/presentation/view/templates/task_details/content_field.dart';
import 'package:reminder/presentation/view/templates/task_details/date_time_field.dart';
import 'package:reminder/presentation/view/templates/task_details/is_completed_box.dart';
import 'package:reminder/presentation/view_model/task_edit.dart';
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
                      ContentField<TaskEditViewModel>(),
                      IsCompletedBox<TaskEditViewModel>(),
                      DateTimeField<TaskEditViewModel>(),
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

// class IsCompletedBox extends StatelessWidget {
//   const IsCompletedBox({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<TaskEditViewModel>();

//     return Row(
//       children: [
//         Checkbox(
//           value: viewModel.isCompleted,
//           onChanged: (value) => viewModel.isCompleted = value!,
//         ),
//         const Text("Выполнено"),
//       ],
//     );
//   }
// }

// class ContentField extends StatelessWidget {
//   const ContentField({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Задача"),
//         DecoratedBox(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blue[500]!,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: TextField(
//             controller: context.read<TaskEditViewModel>().controller,
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             autofocus: true,
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.all(8),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DateTimeField extends StatelessWidget {
//   const DateTimeField({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<TaskEditViewModel>();

//     final date = viewModel.date;
//     final time = viewModel.time;

//     final dateText = DateFormat.yMd().format(date.toLocal());
//     final timeText = time.format(context);

//     final needToRemindBox = Row(
//       children: [
//         Checkbox(
//           value: viewModel.needToRemind,
//           onChanged: (value) => viewModel.needToRemind = value!,
//         ),
//         const Text("Напоминание"),
//       ],
//     );

//     switch (viewModel.needToRemind) {
//       case false:
//         return needToRemindBox;
//       case true:
//         return Column(
//           children: [
//             needToRemindBox,
//             Row(
//               children: [
//                 Text("Дата: $dateText"),
//                 IconButton(
//                   onPressed: () => pickDate(context),
//                   icon: const Icon(Icons.calendar_month),
//                 ),
//                 Text("Время: $timeText"),
//                 IconButton(
//                   onPressed: () => pickTime(context),
//                   icon: const Icon(Icons.watch_later),
//                 ),
//               ],
//             ),
//           ],
//         );
//     }

//     throw Exception();
//   }

//   Future<void> pickTime(BuildContext context) async {
//     final viewModel = context.read<TaskEditViewModel>();

//     final time = await showTimePicker(
//       context: context,
//       initialTime: const TimeOfDay(hour: 0, minute: 0),
//     );

//     if (time != null) viewModel.time = time;
//   }

//   Future<void> pickDate(BuildContext context) async {
//     final viewModel = context.read<TaskEditViewModel>();

//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (date != null) viewModel.date = date;
//   }
// }
