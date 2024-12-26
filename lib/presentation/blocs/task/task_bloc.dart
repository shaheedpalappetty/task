// lib/blocs/task_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:task_assignment/data/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<TaskModel> _tasks = [];

  TaskBloc() : super(TaskInitial()) {
    on<CreateTaskEvent>(_createTaskEvent);
    on<LoadTasksEvent>(_loadTasksEvent);
  }

  FutureOr<void> _createTaskEvent(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      emit(CreateTaskLoading());

      _tasks.add(event.task);
      emit(CreateTaskSuccess(listofTask: List.from(_tasks)));
    } catch (e) {
      emit(CreateTaskError());
    }
  }

  FutureOr<void> _loadTasksEvent(
      LoadTasksEvent event, Emitter<TaskState> emit) {
    emit(CreateTaskSuccess(listofTask: List.from(_tasks)));
  }
}
