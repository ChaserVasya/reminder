import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_model/task.dart';

class ContentField<T extends TaskViewModel> extends StatelessWidget {
  const ContentField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<T>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Задача"),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: viewModel.contentIsEmpty ? Colors.red[500]! : Colors.blue[500]!,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (str) {
              final isEmpty = (str == null) || (str == "");
              if (isEmpty) {
                viewModel.contentIsEmpty = true;
                return "Введите текст!";
              } else
                viewModel.contentIsEmpty = false;
              return null;
            },
            controller: viewModel.controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}
