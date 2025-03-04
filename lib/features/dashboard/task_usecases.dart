import 'package:venteny_test/core/database/task_dao.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';

class TaskUsecases {
  Future<int> createTaskUsecase(TaskModel task) async {
    return await TaskDao.insertTask(task);
  }

  Future<List<TaskModel>> readTaskUsecase() async {
    return await TaskDao.getTasks();
  }

  Future<int> updateTaskUseCase(TaskModel task) async {
    return await TaskDao.updateTask(task);
  }

  Future<int> deleteTaskUseCase(int id) async {
    return await TaskDao.deleteTask(id);
  }
}
