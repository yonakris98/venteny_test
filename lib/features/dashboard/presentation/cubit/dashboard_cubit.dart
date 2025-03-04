import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
import 'package:venteny_test/features/dashboard/domain/usecases/get_list_resource_usecase.dart';
import 'package:venteny_test/features/dashboard/task_usecases.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final TaskUsecases taskUsecases;
  final GetListResourceUsecase getListResourceUsecase;
  TaskStatus? selectedStatus;
  String searchQuery = "";
  List<TaskModel> allTasks = [];
  List<TaskModel> tasks = [];
  int taskCounter = 1;

  final List<TaskStatus> statusCycle = [
    TaskStatus.pending,
    TaskStatus.inProgress,
    TaskStatus.completed
  ];

  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  DashboardCubit({
    required this.taskUsecases,
    required this.getListResourceUsecase,
  }) : super(DashboardInitial()) {
    _monitorConnectivity();
  }

  void _monitorConnectivity() {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        _loadFromLocalDb();
      } else {
        _fetchFromRemote();
      }
    });
  }

  Future<void> _fetchFromRemote() async {
    emit(DashboardLoading());
    try {
      allTasks = await getListResourceUsecase.call();
      filterTasks();
    } catch (e) {
      emit(DashboardError("Failed to fetch tasks from server"));
    }
  }

  Future<void> _loadFromLocalDb() async {
    emit(DashboardLoading());
    try {
      allTasks = await taskUsecases.readTaskUsecase();
      filterTasks();
    } catch (e) {
      emit(DashboardError("Failed to load local tasks"));
    }
  }

  void addTask() async {
    TaskStatus nextStatus = statusCycle[(allTasks.length) % statusCycle.length];

    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: "Task $taskCounter",
      description: "Description here",
      dueDate: DateTime.now().toString(),
      status: nextStatus,
    );

    taskCounter++;

    try {
      await taskUsecases.createTaskUsecase(newTask);
      allTasks.add(newTask);
      filterTasks();
    } catch (e) {
      emit(DashboardError("Failed to add task"));
    }
  }

  void updateTask(TaskModel task) async {
    try {
      await taskUsecases.updateTaskUseCase(task);
      allTasks = allTasks.map((t) => t.id == task.id ? task : t).toList();
      filterTasks();
    } catch (e) {
      emit(DashboardError("Failed to update task"));
    }
  }

  void deleteTask(int id) async {
    try {
      await taskUsecases.deleteTaskUseCase(id);
      allTasks.removeWhere((task) => task.id == id);
      filterTasks();
    } catch (e) {
      emit(DashboardError("Failed to delete task"));
    }
  }

  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    filterTasks();
  }

  void setSelectedStatus(TaskStatus status) {
    selectedStatus = status;
    filterTasks();
  }

  void resetFilter() {
    selectedStatus = null;
    searchQuery = "";
    filterTasks();
  }

  void filterTasks() {
    List<TaskModel> filteredTasks = List.from(allTasks);

    if (selectedStatus != null) {
      filteredTasks = filteredTasks.where((task) => task.status == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks.where((task) => task.title.toLowerCase().contains(searchQuery)).toList();
    }

    tasks = filteredTasks;
    emit(DashboardLoaded(List.from(tasks)));
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
