import 'package:task_assignment/core/utils/imports.dart';

class SearchTask implements UseCase<List<TaskEntity>, String> {
  final TaskRepository repository;

  SearchTask(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(String query) {
    return repository.searchTasks(query);
  }
}