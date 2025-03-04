import 'package:venteny_test/core/endpoints/dashboard_endpoint.dart';
import 'package:venteny_test/core/network/api_interceptor.dart';
import 'package:venteny_test/features/dashboard/data/mapper/resource_mapper.dart';
import 'package:venteny_test/features/dashboard/data/model/list_resource_model.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';

abstract class DashboardDatasource {
  Future<List<TaskModel>> getListResource();
}

class DashboardDatasourceImpl implements DashboardDatasource {
  final ApiService apiService;

  DashboardDatasourceImpl(this.apiService);

  @override
  Future<List<TaskModel>> getListResource() async {
    final response =
        await apiService.getRequest(DashboardEndpoint.listResource);

    if (response.statusCode == 200 && response.data != null) {
      ListResourceModel resourceModel =
          ListResourceModel.fromJson(response.data);
      return ResourceToTaskMapper.mapToTaskList(resourceModel);
    } else {
      throw Exception('get ListResource Failed');
    }
  }
}
