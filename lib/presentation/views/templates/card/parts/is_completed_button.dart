import 'package:flutter/material.dart';

class IsCompletedButton extends StatelessWidget {
  const IsCompletedButton(bool value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: false,
      onChanged: (_) {},
    );
  }
}
