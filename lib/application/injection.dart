import 'package:get_it/get_it.dart';
import 'package:reminder/data/database/floor.dart';
import 'package:reminder/data/repository/tasks/floor.dart';
import 'package:reminder/data/repository/tasks/mosk.dart';
import 'package:reminder/domain/service/notification.dart';
import 'package:reminder/domain/repository/tasks.dart';
import 'package:reminder/domain/service/task_id_generator.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
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
