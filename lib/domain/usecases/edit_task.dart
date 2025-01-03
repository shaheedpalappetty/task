import 'package:task_assignment/core/utils/imports.dart';

class EditTask implements UseCase<void, TaskEntity> {
  final TaskRepository repository;

  EditTask(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskEntity task) async {
    return await repository.editTask(task);
  }
}
