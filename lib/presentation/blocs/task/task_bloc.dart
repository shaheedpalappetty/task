import 'package:task_assignment/core/utils/imports.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final DeleteTask deleteTask;
  final EditTask editTask;
  final SearchTask searchTask;

  TaskBloc({
    required this.deleteTask,
    required this.getTasks,
    required this.createTask,
    required this.editTask,
    required this.searchTask,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<EditTaskEvent>(_onEditTask);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    try {
      final result = await getTasks(const NoParams());

      await result.fold(
        (failure) async => emit(CreateTaskError(message: failure.message)),
        (tasks) async => emit(CreateTaskSuccess(
          listofTask: tasks,
        )),
      );
    } catch (error) {
      emit(CreateTaskError(message: error.toString()));
    }
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    try {
      final result = await createTask(event.task);

      await result.fold(
        (failure) async => emit(CreateTaskError(message: failure.message)),
        (task) async {
          final tasksResult = await getTasks(const NoParams());
          tasksResult.fold(
            (failure) => emit(CreateTaskError(message: failure.message)),
            (tasks) => emit(CreateTaskSuccess(
                listofTask: tasks, message: "Task Created Successfully")),
          );
        },
      );
    } catch (error) {
      emit(CreateTaskError(message: error.toString()));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    try {
      final result = await deleteTask(event.taskId);

      await result.fold(
        (failure) async => emit(CreateTaskError(message: failure.message)),
        (_) async {
          final tasksResult = await getTasks(const NoParams());
          tasksResult.fold(
            (failure) => emit(CreateTaskError(message: failure.message)),
            (tasks) => emit(CreateTaskSuccess(
                listofTask: tasks, message: "Task Deleted Successfully")),
          );
        },
      );
    } catch (error) {
      emit(CreateTaskError(message: error.toString()));
    }
  }

  Future<void> _onEditTask(
    EditTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    try {
      final result = await editTask(event.task);

      await result.fold(
        (failure) async => emit(CreateTaskError(message: failure.message)),
        (_) async {
          final tasksResult = await getTasks(const NoParams());
          tasksResult.fold(
            (failure) => emit(CreateTaskError(message: failure.message)),
            (tasks) => emit(CreateTaskSuccess(
                listofTask: tasks, message: "Task Edited Successfully")),
          );
        },
      );
    } catch (error) {
      emit(CreateTaskError(message: error.toString()));
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreateTaskLoading());

    try {
      final result = await searchTask(event.query);
      await result.fold(
        (failure) async => emit(CreateTaskError(message: failure.message)),
        (tasks) async => emit(CreateTaskSuccess(listofTask: tasks)),
      );
    } catch (error) {
      emit(CreateTaskError(message: error.toString()));
    }
  }
}
