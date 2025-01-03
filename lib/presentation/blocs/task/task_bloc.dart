import 'package:task_assignment/core/utils/imports.dart';
import 'package:task_assignment/domain/usecases/delete_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.deleteTask,
    required this.getTasks,
    required this.createTask,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(LoadTasksLoading());

    final result = await getTasks(const NoParams());

    if (!emit.isDone) {
      result.fold(
        (failure) => emit(LoadTasksError(message: failure.message)),
        (tasks) => emit(CreateTaskSuccess(listofTask: tasks)),
      );
    }
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    final result = await createTask(event.task);

    await result.fold(
      (failure) async => emit(CreateTaskError(message: failure.message)),
      (task) async {
        final tasksResult = await getTasks(const NoParams());
        tasksResult.fold(
          (failure) => emit(CreateTaskError(message: failure.message)),
          (tasks) => emit(CreateTaskSuccess(listofTask: tasks)),
        );
      },
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    final result = await deleteTask(event.taskId);

    await result.fold(
      (failure) async => emit(CreateTaskError(message: failure.message)),
      (_) async {
        final tasksResult = await getTasks(const NoParams());
        tasksResult.fold(
          (failure) => emit(CreateTaskError(message: failure.message)),
          (tasks) => emit(CreateTaskSuccess(listofTask: tasks)),
        );
      },
    );
  }
}
