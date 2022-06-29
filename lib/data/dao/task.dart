import 'package:floor/floor.dart';
import 'package:reminder/data/entity/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<PlainTask>> findAll();

  @Query('SELECT * FROM Task WHERE id = :id')
  Future<PlainTask?> findById(int id);

  @insert
  Future<void> insertTask(PlainTask task);

  @delete
  Future<void> deleteTask(PlainTask task);

  @update
  Future<void> updateTask(PlainTask task);
}
