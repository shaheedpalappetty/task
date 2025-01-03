import 'package:task_assignment/core/utils/imports.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl());
  locator.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(locator<TaskLocalDataSource>()));
  locator.registerLazySingleton<GetTasks>(
      () => GetTasks(locator<TaskRepository>()));
  locator.registerLazySingleton<CreateTask>(
      () => CreateTask(locator<TaskRepository>()));
  locator.registerLazySingleton<DeleteTask>(
      () => DeleteTask(locator<TaskRepository>()));
  locator.registerLazySingleton<EditTask>(
      () => EditTask(locator<TaskRepository>()));
  locator.registerLazySingleton<SearchTask>(
      () => SearchTask(locator<TaskRepository>()));
}
