import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venteny_test/features/login/data/model/user_model.dart';
import 'package:venteny_test/features/login/presentation/cubit/login_cubit.dart';
import 'package:venteny_test/features/login/domain/usecases/login_usecase.dart';

class LoginTest extends Mock implements LoginUsecase {}

void main() {
  late LoginCubit loginCubit;
  late LoginTest loginTest;

  setUp(() {
    loginTest = LoginTest();
    loginCubit = LoginCubit(loginTest);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    const email = 'eve.holt@reqres.in';
    const password = 'cityslicka';
    const token = 'mock_token';

    test('initial state is LoginInitial', () {
      expect(loginCubit.state, LoginInitial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () {
        when(() => loginTest.call(email, password))
            .thenAnswer((_) async => const UserModel(token: token));
        return loginCubit;
      },
      act: (cubit) => cubit.login(email, password),
      expect: () => [
        LoginLoading(),
        LoginSuccess(const UserModel(token: token)),
      ],
      verify: (_) {
        verify(() => loginTest.call(email, password)).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () {
        when(() => loginTest.call(email, password))
            .thenThrow(Exception('Login failed'));
        return loginCubit;
      },
      act: (cubit) => cubit.login(email, password),
      expect: () => [
        LoginLoading(),
        LoginFailure('Exception: Login failed'),
      ],
      verify: (_) {
        verify(() => loginTest.call(email, password)).called(1);
      },
    );
  });
}
