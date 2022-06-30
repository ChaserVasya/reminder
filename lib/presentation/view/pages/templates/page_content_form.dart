import 'package:flutter/cupertino.dart';

class PageContentForm extends StatelessWidget {
  const PageContentForm({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
