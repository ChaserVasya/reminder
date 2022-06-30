import 'package:flutter/material.dart';
import 'package:reminder/presentation/view/pages/templates/page_content_form.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({required this.child, this.title, Key? key}) : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/new_task"),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: title != null ? Text(title!) : null),
      body: PageContentForm(
        child: child,
      ),
    );
  }
}
