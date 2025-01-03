import 'package:task_assignment/core/utils/imports.dart';

class DeleteTask extends UseCase<void, int> {
  final TaskRepository repository;

  DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(int taskId) async {
    return await repository.deleteTask(taskId);
  }
}
