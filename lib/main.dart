import 'package:task_assignment/core/utils/imports.dart';
import 'package:task_assignment/domain/usecases/delete_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = TaskLocalDataSourceImpl();
  final repository = TaskRepositoryImpl(localDataSource);
  final getTasks = GetTasks(repository);
  final createTask = CreateTask(repository);
  final deleteTask = DeleteTask(repository);

  runApp(MyApp(
    getTasks: getTasks,
    createTask: createTask,
    deleteTask: deleteTask,
  ));
}

class MyApp extends StatelessWidget {
  final GetTasks getTasks;
  final CreateTask createTask;
  final DeleteTask deleteTask;

  const MyApp({
    super.key,
    required this.getTasks,
    required this.createTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        getTasks: getTasks,
        createTask: createTask,
        deleteTask: deleteTask,
      )..add(LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskListScreen(),
      ),
    );
  }
}
