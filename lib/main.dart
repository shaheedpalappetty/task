import 'package:task_assignment/core/utils/imports.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        getTasks: locator<GetTasks>(),
        createTask: locator<CreateTask>(),
        deleteTask: locator<DeleteTask>(),
        editTask: locator<EditTask>(),
        searchTask: locator<SearchTask>(),
      )..add(LoadTasksEvent()),
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
