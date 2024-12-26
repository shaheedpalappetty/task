import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/presentation/blocs/task/task_bloc.dart';
import 'package:task_assignment/presentation/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = TaskBloc();
        bloc.add(LoadTasksEvent());
        return bloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TaskListScreen(),
      ),
    );
  }
}
