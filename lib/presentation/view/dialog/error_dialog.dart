import 'package:flutter/material.dart';
import 'package:reminder/application/error/alert/content.dart';

class ExceptionDialog extends AlertDialog {
  ExceptionDialog(
    BuildContext context,
    AlertDialogContent alert, {
    Key? key,
  }) : super(
          scrollable: true,
          key: key,
          title: Text(
            alert.titleForUser,
            textAlign: TextAlign.center,
          ),
          actions: (alert.actionsBuilder != null) ? alert.actionsBuilder!(context) : null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                alert.textForUser,
                textAlign: TextAlign.center,
              ),
              if (alert.details != null)
                ExpansionTile(
                  title: const Text('Показать детали'),
                  children: [Text(alert.details!, textAlign: TextAlign.justify)],
                ),
            ],
          ),
        );
}
