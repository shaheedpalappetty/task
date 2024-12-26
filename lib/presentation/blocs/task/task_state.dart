// part of 'task_bloc.dart';

// abstract class TaskState {}

// final class TaskInitial extends TaskState {}

// final class CreateTaskLoading extends TaskState {}

// final class CreateTaskError extends TaskState {}

// final class CreateTaskSuccess extends TaskState {
//   final List<TaskModel> listofTask;

//   CreateTaskSuccess({required this.listofTask});
// }
// lib/blocs/task_state.dart
part of 'task_bloc.dart';

abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class CreateTaskLoading extends TaskState {}

final class CreateTaskError extends TaskState {
  final String message;

  CreateTaskError({this.message = 'Something went wrong!'});
}

final class CreateTaskSuccess extends TaskState {
  final List<TaskModel> listofTask;

  CreateTaskSuccess({required this.listofTask});
}

final class LoadTasksLoading extends TaskState {}

final class LoadTasksError extends TaskState {
  final String message;

  LoadTasksError({this.message = 'Error loading tasks'});
}

final class LoadTasksSuccess extends TaskState {
  final List<TaskModel> tasks;

  LoadTasksSuccess({required this.tasks});
}

final class TaskEmpty extends TaskState {}
