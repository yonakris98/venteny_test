import 'package:venteny_test/features/login/data/model/user_model.dart';

abstract class AuthRepositories {
  Future<UserModel> login(String email, String password);
}