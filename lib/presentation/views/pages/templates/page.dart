import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({required this.child, this.title, Key? key})
      : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/new-task"),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: title != null ? Text(title!) : null),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
