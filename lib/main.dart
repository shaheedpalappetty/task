
import 'package:task_assignment/core/utils/imports.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = TaskLocalDataSourceImpl();
  final repository = TaskRepositoryImpl(localDataSource);
  final getTasks = GetTasks(repository);
  final createTask = CreateTask(repository);
  final deleteTask = DeleteTask(repository);
  final editTask = EditTask(repository);
  final searchTask = SearchTask(repository);

  runApp(MyApp(
    getTasks: getTasks,
    createTask: createTask,
    deleteTask: deleteTask,
    editTask: editTask,
    searchTask: searchTask,
  ));
}

class MyApp extends StatelessWidget {
  final GetTasks getTasks;
  final CreateTask createTask;
  final DeleteTask deleteTask;
  final EditTask editTask;
  final SearchTask searchTask;

  const MyApp(
      {super.key,
      required this.getTasks,
      required this.createTask,
      required this.deleteTask,
      required this.editTask,
      required this.searchTask});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
          getTasks: getTasks,
          createTask: createTask,
          deleteTask: deleteTask,
          editTask: editTask,
          searchTask: searchTask)
        ..add(LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.backgroundColor,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        home: const TaskListScreen(),
      ),
    );
  }
}
