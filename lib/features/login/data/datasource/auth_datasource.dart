import 'dart:convert';

import 'package:venteny_test/core/endpoints/auth_endpoint.dart';
import 'package:venteny_test/core/network/api_interceptor.dart';
import 'package:venteny_test/features/login/data/model/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> login(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  final ApiService apiService;

  AuthDatasourceImpl(this.apiService);

  @override
  Future<UserModel> login(String email, String password) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response =
        await apiService.postRequest(AuthEndpoint.login, jsonEncode(data));

    if (response.statusCode == 200 && response.data != null) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Login Failed');
    }
  }
}
