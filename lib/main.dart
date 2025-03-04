import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venteny_test/core/database/task_database.dart';
import 'package:venteny_test/core/network/api_interceptor.dart';
import 'package:venteny_test/core/theme/theme_cubit.dart';
import 'package:venteny_test/features/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:venteny_test/features/dashboard/data/repositories/dashboard_repositories_impl.dart';
import 'package:venteny_test/features/dashboard/domain/usecases/get_list_resource_usecase.dart';
import 'package:venteny_test/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:venteny_test/features/dashboard/task_usecases.dart';
import 'package:venteny_test/features/login/data/datasource/auth_datasource.dart';
import 'package:venteny_test/features/login/data/repositories/auth_repositories_impl.dart';
import 'package:venteny_test/features/login/domain/usecases/login_usecase.dart';
import 'package:venteny_test/features/login/presentation/cubit/login_cubit.dart';
import 'package:venteny_test/features/login/presentation/pages/login_page.dart';

final LoginUsecase loginUsecase =
    LoginUsecase(AuthRepositoriesImpl(AuthDatasourceImpl(ApiService(Dio()))));
final TaskUsecases taskUsecases = TaskUsecases();
final GetListResourceUsecase getListResourceUsecase = GetListResourceUsecase(
    DashboardRepositoriesImpl(DashboardDatasourceImpl(ApiService(Dio()))));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.instance.database;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(loginUsecase)),
        BlocProvider(
            create: (_) => DashboardCubit(
                taskUsecases: taskUsecases,
                getListResourceUsecase: getListResourceUsecase)),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const LoginPage(),
          );
        },
      ),
    ),
  );
}
