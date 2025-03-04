enum TaskStatus { pending, inProgress, completed }

class TaskModel {
  int? id;
  String title;
  String? description;
  String dueDate;
  TaskStatus status;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'status': status.index,
    };
  }

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['due_date'],
      status: TaskStatus.values[map['status']],
    );
  }
}
