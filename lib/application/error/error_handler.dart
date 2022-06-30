import 'package:flutter/material.dart';

import 'show_exception_dialog.dart';
import 'switch/main.dart';

class ErrorHandler {
  static void onFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);
  }

  static Future<void> onZoneError(Object e, [StackTrace? s]) async {
    print("=======ERROR=======");
    print(e);
    print("=======/ERROR=======");
    // final alert = switchExceptionAlert(e);
    // showExceptionDialog(alert);
  }

  static Widget errorWidgetBuilder(FlutterErrorDetails details) {
    return const Center(
      child: Text("Oops! Render error. Something went wrong"),
    );
  }
}
