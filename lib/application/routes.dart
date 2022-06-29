import 'package:reminder/presentation/views/init.dart';
import 'package:reminder/presentation/views/pages/new_task.dart';
import 'package:reminder/presentation/views/pages/task_edit.dart';
import 'package:reminder/presentation/views/pages/tasks.dart';

final routes = {
  "/init": (_) => const InitPage(),
  "/tasks": (_) => const TasksPage(),
  "/new_task": (_) => const NewTaskPage(),
  "/task_edit": (_) => const TaskEditPage(),
};
