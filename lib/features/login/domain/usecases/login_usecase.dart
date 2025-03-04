import 'package:venteny_test/features/login/data/model/user_model.dart';
import 'package:venteny_test/features/login/domain/repositories/auth_repositories.dart';

class LoginUsecase {
  final AuthRepositories repository;

  LoginUsecase(this.repository);

  Future<UserModel> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
