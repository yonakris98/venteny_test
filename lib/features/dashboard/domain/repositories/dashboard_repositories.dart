import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
abstract class DashboardRepositories {
  Future<List<TaskModel>> getListResource();
}