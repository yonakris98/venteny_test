
import 'package:venteny_test/features/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
import 'package:venteny_test/features/dashboard/domain/repositories/dashboard_repositories.dart';

class DashboardRepositoriesImpl implements DashboardRepositories {
  final DashboardDatasource dashboardDatasource;

  DashboardRepositoriesImpl(this.dashboardDatasource);

  @override
  Future<List<TaskModel>> getListResource() async {
    return await dashboardDatasource.getListResource();
  }
}
