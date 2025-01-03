import 'package:task_assignment/core/utils/custom_snacbar.dart';
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
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is CreateTaskError) {
            CustomSnackBar.show(context: context, message: state.message);
          }
          //  else if (state is CreateTaskSuccess) {
          //   CustomSnackBar.show(context: context, message: state.message);
          // }
        },
        builder: (context, state) {
          if (state is CreateTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CreateTaskSuccess) {
            if (state.listofTask.isEmpty) {
              return const Center(child: Text("No tasks available"));
            }
            return ListView.builder(
              itemCount: state.listofTask.length,
              itemBuilder: (context, index) {
                final task = state.listofTask[index];
                Logger.log("Length ${state.listofTask.length}");
                Logger.log("Task ${task.id}");
                return Dismissible(
                  key: Key(task.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<TaskBloc>().add(
                          DeleteTaskEvent(taskId: task.id!),
                        );
                    CustomSnackBar.show(
                        context: context,
                        message: '${task.name} deleted sucessfully',
                        type: SnackBarType.error);
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                              "Are you sure you want to delete this task?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                "DELETE",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Center(
                          child: Text((index + 1).toString()),
                        ),
                      ),
                      title: Text(task.name.toUpperCase()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.description),
                          Text("Assigned to ${task.assignedEmployee}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TaskCreationScreen(
                              isEdit: true,
                              task: task,
                            ),
                          ),
                        ),
                      )),
                );
              },
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
