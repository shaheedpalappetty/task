import 'package:task_assignment/core/utils/imports.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, void>> editTask(TaskEntity task);
  Future<Either<Failure, List<TaskEntity>>> searchTasks(String query);
}
