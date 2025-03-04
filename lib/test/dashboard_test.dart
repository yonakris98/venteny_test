import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:venteny_test/features/dashboard/data/model/task_model.dart';
import 'package:venteny_test/features/dashboard/domain/usecases/get_list_resource_usecase.dart';
import 'package:venteny_test/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:venteny_test/features/dashboard/task_usecases.dart';

class MockTaskUsecases extends Mock implements TaskUsecases {}

class MockGetListResourceUsecase extends Mock
    implements GetListResourceUsecase {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late DashboardCubit dashboardCubit;
  late MockTaskUsecases mockTaskUsecases;
  late MockGetListResourceUsecase mockGetListResourceUsecase;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockTaskUsecases = MockTaskUsecases();
    mockGetListResourceUsecase = MockGetListResourceUsecase();
    dashboardCubit = DashboardCubit(
      taskUsecases: mockTaskUsecases,
      getListResourceUsecase: mockGetListResourceUsecase,
    );
  });

  tearDown(() => dashboardCubit.close());

  final task1 = TaskModel(
    id: 1,
    title: 'Task 1',
    description: 'Description 1',
    dueDate: '2025-12-31',
    status: TaskStatus.pending,
  );

  final task2 = TaskModel(
    id: 2,
    title: 'Task 2',
    description: 'Description 2',
    dueDate: '2025-12-31',
    status: TaskStatus.completed,
  );

  group('Task Status Manipulation', () {
    blocTest<DashboardCubit, DashboardState>(
      'emits [DashboardLoaded] when setSelectedStatus is called',
      build: () {
        dashboardCubit.allTasks = [task1, task2];
        return dashboardCubit;
      },
      act: (cubit) => cubit.setSelectedStatus(TaskStatus.pending),
      expect: () => [
        DashboardLoaded([task1]),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [DashboardLoaded] with all tasks after resetFilter',
      build: () {
        dashboardCubit.allTasks = [task1, task2];
        dashboardCubit.setSelectedStatus(TaskStatus.completed);
        return dashboardCubit;
      },
      act: (cubit) => cubit.resetFilter(),
      expect: () => [
        DashboardLoaded([task1, task2]),
      ],
    );
  });
}
