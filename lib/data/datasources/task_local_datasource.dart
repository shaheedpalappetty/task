import 'package:task_assignment/core/utils/imports.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> searchTasks(String query);
  Future<TaskModel> createTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<bool> editTask(TaskModel task);
}
