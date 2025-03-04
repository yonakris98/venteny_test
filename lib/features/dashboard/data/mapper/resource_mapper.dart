import 'package:venteny_test/features/dashboard/data/model/list_resource_model.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';

class ResourceToTaskMapper {
  static List<TaskModel> mapToTaskList(ListResourceModel resourceModel) {
    final List<TaskStatus> statusCycle = [
      TaskStatus.pending,
      TaskStatus.inProgress,
      TaskStatus.completed
    ];

    return resourceModel.data.asMap().entries.map((entry) {
      int index = entry.key;
      ResourceModel resource = entry.value;

      return TaskModel(
        id: resource.id,
        title: resource.name,
        description: resource.color,
        dueDate: resource.year.toString(),
        status: statusCycle[index % statusCycle.length],
      );
    }).toList();
  }
}
