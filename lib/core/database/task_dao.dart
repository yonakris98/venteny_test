import 'package:venteny_test/core/database/task_database.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';

class TaskDao {
  static Future<int> insertTask(TaskModel task) async {
    final db = await TaskDatabase.instance.database;
    return await db.insert('task', task.toMap());
  }

  static Future<List<TaskModel>> getTasks() async {
    final db = await TaskDatabase.instance.database;
    final result = await db.query('task');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  static Future<int> updateTask(TaskModel task) async {
    final db = await TaskDatabase.instance.database;
    return await db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteTask(int id) async {
    final db = await TaskDatabase.instance.database;
    return await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
