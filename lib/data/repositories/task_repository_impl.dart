import 'package:task_assignment/core/utils/imports.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel(
        name: task.name,
        description: task.description,
        assignedEmployee: task.assignedEmployee,
      );
      final result = await localDataSource.createTask(taskModel);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final result = await localDataSource.getTasks();
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        assignedEmployee: task.assignedEmployee,
      );
      final bool isEdited = await localDataSource.editTask(taskModel);
      if (isEdited) {
        return const Right(null);
      } else {
        return const Left(DatabaseFailure("Unable to Edit"));
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
