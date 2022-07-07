import 'package:reminder/presentation/view/page/init.dart';
import 'package:reminder/presentation/view/page/task/new.dart';
import 'package:reminder/presentation/view/page/task/edit.dart';
import 'package:reminder/presentation/view/page/tasks.dart';

final routes = {
  "/init": (_) => const InitPage(),
  "/tasks": (_) => const TasksPage(),
  "/new_task": (_) => const NewTaskPage(),
  "/task_edit": (_) => const TaskEditPage(),
};
