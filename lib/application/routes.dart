import 'package:reminder/presentation/view/init.dart';
import 'package:reminder/presentation/view/pages/new_task.dart';
import 'package:reminder/presentation/view/pages/task_edit.dart';
import 'package:reminder/presentation/view/pages/tasks.dart';

final routes = {
  "/init": (_) => const InitPage(),
  "/tasks": (_) => const TasksPage(),
  "/new_task": (_) => const NewTaskPage(),
  "/task_edit": (_) => const TaskEditPage(),
};
