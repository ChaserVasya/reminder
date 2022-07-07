import 'package:get_it/get_it.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/domain/repository/tasks.dart';
import 'package:reminder/domain/service/task_id_generator.dart';
import 'package:reminder/presentation/view_model/task.dart';

class NewTaskViewModel extends TaskViewModel {
  final _repo = GetIt.I.get<TasksRepo>();

  Status status = Status.synced;

  Future<void> setTask() async {
    status = Status.sync;
    notifyListeners();

    final id = await GetIt.I.get<TaskIdGenerator>().generate();
    final content = controller.text;

    var reminder =
        (needToRemind) ? DateTimeUtils.toNearestNotifiable(DateTimeFactory.from(date, time)) : null;

    final task = Task(id, content, reminder);

    await _repo.insert(task);

    status = Status.synced;
    notifyListeners();
  }
}
