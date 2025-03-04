import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venteny_test/core/theme/theme_cubit.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
import 'package:venteny_test/features/dashboard/presentation/cubit/dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: const Text(
                "Menu",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: Colors.blue),
              title: const Text("Add Item"),
              onTap: () => context.read<DashboardCubit>().addTask(),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left : 20.0),
                  child: Text('Dark Mode',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) =>
                        context.read<DashboardCubit>().setSearchQuery(value),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list, size: 28),
                  onPressed: () => _showFilterModal(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DashboardLoaded) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Text(task.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.description ?? "",
                                    style: const TextStyle(color: Colors.grey)),
                                Text("Due: ${task.dueDate.toString()}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.blue)),
                                Text("Status: ${task.status}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.green)),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => context
                                  .read<DashboardCubit>()
                                  .deleteTask(task.id!),
                            ),
                            onTap: () =>
                                context.read<DashboardCubit>().updateTask(task),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No tasks available"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.grey[100],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Filter by Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildFilterButton(
                context, "Pending", TaskStatus.pending, Colors.blue),
            _buildFilterButton(
                context, "In Progress", TaskStatus.inProgress, Colors.blue),
            _buildFilterButton(
                context, "Completed", TaskStatus.completed, Colors.blue),
            _buildFilterButton(context, "Reset Filter", null, Colors.red),
          ],
        ),
      );
    },
  );
}

Widget _buildFilterButton(
    BuildContext context, String label, TaskStatus? status, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 48),
      ),
      onPressed: () {
        if (status != null) {
          context.read<DashboardCubit>().setSelectedStatus(status);
        } else {
          context.read<DashboardCubit>().resetFilter();
        }
        Navigator.pop(context);
      },
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    ),
  );
}
