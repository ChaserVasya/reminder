import 'package:get_it/get_it.dart';
import 'package:reminder/data/database/floor.dart';
import 'package:reminder/data/repository/tasks/floor.dart';
import 'package:reminder/domain/service/notification.dart';
import 'package:reminder/domain/repository/tasks.dart';
import 'package:reminder/domain/service/task_id_generator.dart';

Future<void> inject() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<NotificationService>(
    NotificationService(),
  );

  getIt.registerSingleton<AppDatabase>(
    await $FloorAppDatabase.databaseBuilder('app_database.db').build(),
  );

  getIt.registerSingleton<TasksRepo>(
    FloorTasksRepo(),
  );

  getIt.registerSingleton<TaskIdGenerator>(
    TaskIdGenerator(),
  );
}
