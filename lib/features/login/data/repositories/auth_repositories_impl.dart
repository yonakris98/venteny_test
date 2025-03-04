import 'package:venteny_test/features/login/data/datasource/auth_datasource.dart';
import 'package:venteny_test/features/login/data/model/user_model.dart';
import 'package:venteny_test/features/login/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthDatasource authDatasource;

  AuthRepositoriesImpl(this.authDatasource);

  @override
  Future<UserModel> login(String email, String password) async {
    return await authDatasource.login(email, password);
  }
}
