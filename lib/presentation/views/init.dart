import 'package:flutter/material.dart';
import 'package:reminder/application/injection.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  bool inited = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    await inject();

    setState(() => inited = true);
  }

  @override
  Widget build(BuildContext context) {
    if (inited)
      Future.microtask(
          () => Navigator.pushReplacementNamed(context, "/arrival"));
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
