part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel userModel;
  LoginSuccess(this.userModel);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
