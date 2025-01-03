part of 'task_bloc.dart';

abstract class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskEntity task;

  CreateTaskEvent({required this.task});
}

class LoadTasksEvent extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;
  DeleteTaskEvent({required this.taskId});
}
