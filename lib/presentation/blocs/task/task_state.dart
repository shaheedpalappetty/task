part of 'task_bloc.dart';

abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class CreateTaskLoading extends TaskState {}

final class CreateTaskError extends TaskState {
  final String message;

  CreateTaskError({this.message = 'Something went wrong!'});
}

final class CreateTaskSuccess extends TaskState {
  final List<TaskEntity> listofTask;

  CreateTaskSuccess({required this.listofTask});
}

final class LoadTasksLoading extends TaskState {}

final class LoadTasksError extends TaskState {
  final String message;

  LoadTasksError({this.message = 'Error loading tasks'});
}
