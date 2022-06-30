import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  const CardContent(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
