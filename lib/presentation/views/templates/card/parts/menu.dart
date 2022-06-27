import 'package:flutter/material.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        _actionMenuItem(Icons.edit, "Редактировать"),
        _actionMenuItem(Icons.delete, "Удалить"),
      ],
    );
  }

  PopupMenuEntry _actionMenuItem(IconData iconData, String text) {
    return PopupMenuItem(
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(iconData),
        label: Text(text),
      ),
    );
  }
}
