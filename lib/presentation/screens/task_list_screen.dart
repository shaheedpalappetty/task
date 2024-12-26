import 'package:flutter/material.dart';
import 'package:task_assignment/presentation/screens/task_creation_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // final task = state.tasks[index];
          return const ListTile(
            title: Text("Task"),
            subtitle: Text("Descriprion"),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TaskCreationScreen(),
                )),
            child: const Text("Add Task")),
      ),
    );
  }
}
