import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/presentation/view_models/tasks.dart';

import 'error/error_handler.dart';
import 'error/show_exception_dialog.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksViewModel>(create: (_) => TasksViewModel()),
      ],
      child: MaterialApp(
        title: 'Reminder',
        routes: routes,
        initialRoute: "/init",
        navigatorKey: navigatorKey,
        builder: (_, widget) {
          ErrorWidget.builder = ErrorHandler.errorWidgetBuilder;
          return widget!;
        },
      ),
    );
  }
}
