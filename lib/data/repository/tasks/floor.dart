import 'package:get_it/get_it.dart';
import 'package:reminder/data/database/floor.dart';
import 'package:reminder/data/mapper/task.dart';
import 'package:reminder/domain/entities/task.dart';
import 'package:reminder/domain/repositories/tasks.dart';

import 'package:floor/floor.dart';

@dao
class FloorTasksRepo implements TasksRepo {
  final _db = GetIt.I.get<AppDatabase>();

  @override
  Future<void> delete(Task task) async {
    await _db.taskDao.deleteTask(TaskMapper.toPlainTask(task));
  }

  @override
  Future<Task> get(int id) async {
    final plain = await _db.taskDao.findById(id);
    return TaskMapper.toTask(plain!);
  }

  @override
  Future<List<Task>> getAll() async {
    return (await _db.taskDao.findAll()).map((e) => TaskMapper.toTask(e)).toList();
  }

  @override
  Future<void> insert(Task task) async {
    await _db.taskDao.insertTask(TaskMapper.toPlainTask(task));
  }

  @override
  Future<void> update(Task task) async {
    await _db.taskDao.updateTask(TaskMapper.toPlainTask(task));
  }
}
