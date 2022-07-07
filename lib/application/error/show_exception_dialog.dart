import 'package:flutter/material.dart';
import 'package:reminder/application/navigator.dart';
import 'package:reminder/presentation/view/dialog/error_dialog.dart';

import 'alert/content.dart';

void showExceptionDialog(AlertDialogContent content) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => ExceptionDialog(context, content),
      ));
}
