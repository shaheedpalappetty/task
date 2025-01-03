import 'package:task_assignment/core/utils/imports.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 400);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tasks",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildTaskList(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomTextField(
        controller: _searchController,
        textStyle: const TextStyle(color: AppColors.white),
        hintText: AppStrings.searchHintText,
        fillColor: AppColors.searchBarColor,
        hintStyle: const TextStyle(color: AppColors.grey),
        borderRadius: 12,
        prefixIcon: const Icon(Icons.search, color: AppColors.fadeGrey),
        onChanged: (value) {
          _debouncer.run(() {
            context.read<TaskBloc>().add(SearchQueryChanged(value));
          });
        },
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: AppColors.fadeGrey),
                onPressed: () {
                  _searchController.clear();
                  context.read<TaskBloc>().add(SearchQueryChanged(''));
                },
              )
            : null,
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is CreateTaskError) {
            showCustomSnackbar(
                context: context,
                message: state.message,
                type: SnackBarType.error);
          } else if (state is CreateTaskSuccess) {
            if (state.message != null) {
              showCustomSnackbar(
                  context: context,
                  message: state.message!,
                  type: SnackBarType.success);
            }
          }
        },
        builder: (context, state) {
          if (state is CreateTaskLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          if (state is CreateTaskError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.errorColor,
                  ),
                ),
              ],
            );
          }
          if (state is CreateTaskSuccess) {
            return state.listofTask.isEmpty
                ? _buildEmptyState(_searchController.text.isNotEmpty)
                : _buildTaskListView(state.listofTask);
          }

          return _buildEmptyState(false);
        },
      ),
    );
  }

  Widget _buildEmptyState(bool isSearching) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearching ? Icons.search_off : Icons.task_outlined,
            size: 48,
            color: AppColors.fadeGrey,
          ),
          const SizedBox(height: 16),
          Text(
            isSearching
                ? AppStrings.noMatchingFound
                : AppStrings.noTasksAvailable,
            style: const TextStyle(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListView(List<TaskEntity> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskCard(
        task: tasks[index],
        index: index,
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingButton(
      label: AppStrings.addTask,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TaskCreationScreen(),
        ),
      ),
    );
  }
}
