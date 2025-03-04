import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
import 'package:venteny_test/features/dashboard/domain/repositories/dashboard_repositories.dart';

class GetListResourceUsecase {
  final DashboardRepositories repository;

  GetListResourceUsecase(this.repository);

  Future<List<TaskModel>> call() async {
    return await repository.getListResource();
  }
}
