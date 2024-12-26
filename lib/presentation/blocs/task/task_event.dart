
part of 'task_bloc.dart';

abstract class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskModel task;

  CreateTaskEvent({required this.task});
}

class LoadTasksEvent extends TaskEvent {}