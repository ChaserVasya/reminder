import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/application/injection.dart';
import 'package:reminder/domain/service/notification.dart';
import 'package:reminder/presentation/view/plug.dart';

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

    await GetIt.I.get<NotificationService>().init();

    setState(() => inited = true);
  }

  Future<void> removeSplash() async {
    FlutterNativeSplash.remove();
    await Future(() => Navigator.pushReplacementNamed(context, "/tasks"));
  }

  @override
  Widget build(BuildContext context) {
    if (inited) removeSplash();
    return const Plug();
  }
}
