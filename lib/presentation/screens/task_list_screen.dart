import 'package:task_assignment/core/utils/imports.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is CreateTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CreateTaskSuccess) {
            return ListView.builder(
              itemCount: state.listofTask.length,
              itemBuilder: (context, index) {
                final task = state.listofTask[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.description),
                  trailing: Text(task.assignedEmployee),
                );
              },
            );
          }
          if (state is CreateTaskError) {
            return const Center(
              child: Text("Error occurred while loading tasks"),
            );
          }
          return const Center(child: Text("No tasks available"));
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TaskCreationScreen(),
            ),
          ),
          child: const Text("Add Task"),
        ),
      ),
    );
  }
}
