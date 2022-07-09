import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view/element/plug/element.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';

import 'parts/content.dart';
import 'parts/is_completed_box.dart';
import 'parts/menu.dart';
import 'parts/remind_text.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late final viewModel = TaskEditViewModel(widget.id);

  @override
  Widget build(BuildContext context) {
    viewModel.fetching = viewModel.fetchTask(widget.id);
    return ChangeNotifierProvider<TaskEditViewModel>(
      create: (_) => viewModel,
      builder: (context, __) {
        return FutureBuilder(
          future: context.watch<TaskEditViewModel>().fetching,
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
