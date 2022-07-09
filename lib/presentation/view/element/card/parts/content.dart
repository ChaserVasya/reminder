import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task/edit.dart';

class CardContent extends StatelessWidget {
  const CardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("build");
    final viewModel = context.watch<TaskEditViewModel>();
    return Text(viewModel.controller.text);
  }
}
