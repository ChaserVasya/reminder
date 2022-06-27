import 'package:flight_schedule/presentation/error_dialog.dart';
import 'package:flutter/material.dart';

import 'alert/content.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void showExceptionDialog(AlertDialogContent content) {
  WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => ExceptionDialog(context, content),
      ));
}
