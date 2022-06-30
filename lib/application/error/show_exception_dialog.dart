import 'package:flutter/material.dart';
import 'package:reminder/presentation/view/dialog/error_dialog.dart';

import 'alert/content.dart';

final navigatorKey = GlobalKey<NavigatorState>();

NavigatorState get navigator => navigatorKey.currentState!;

void showExceptionDialog(AlertDialogContent content) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => ExceptionDialog(context, content),
      ));
}
