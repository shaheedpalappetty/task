import 'package:task_assignment/core/utils/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = TaskLocalDataSourceImpl();
  final repository = TaskRepositoryImpl(localDataSource);
  final getTasks = GetTasks(repository);
  final createTask = CreateTask(repository);

  runApp(MyApp(
    getTasks: getTasks,
    createTask: createTask,
  ));
}

class MyApp extends StatelessWidget {
  final GetTasks getTasks;
  final CreateTask createTask;

  const MyApp({
    super.key,
    required this.getTasks,
    required this.createTask,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        getTasks: getTasks,
        createTask: createTask,
      )..add(LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TaskListScreen(),
      ),
    );
  }
}
