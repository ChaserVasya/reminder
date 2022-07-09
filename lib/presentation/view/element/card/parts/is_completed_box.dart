import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';

class IsCompletedBox extends StatelessWidget {
  const IsCompletedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskEditViewModel>();

    return Checkbox(
      value: viewModel.isCompleted,
      onChanged: (value) async {
        viewModel.isCompleted = value!;
        await viewModel.editTask();
      },
    );
  }
}
