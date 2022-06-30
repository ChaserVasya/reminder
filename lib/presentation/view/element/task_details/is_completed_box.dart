import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task.dart';

class IsCompletedBox<T extends TaskViewModel> extends StatelessWidget {
  const IsCompletedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<T>();

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
