import 'package:task_assignment/core/utils/imports.dart';

class CreateTask implements UseCase<TaskEntity, TaskEntity> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(TaskEntity task) async {
    return await repository.createTask(task);
  }
}
