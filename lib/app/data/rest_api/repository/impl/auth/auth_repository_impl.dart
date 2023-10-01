import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/auth/log_in_response.dart';
import 'package:entrance_test/app/data/model/auth/user_model.dart';
import 'package:entrance_test/app/data/rest_api/dio/dio_factory.dart';
import 'package:entrance_test/app/data/rest_api/repository/auth/auth_api.dart';
import 'package:entrance_test/app/data/rest_api/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(DioFactory client)
      : _authApi = AuthApi(
          client.dio,
          baseUrl: client.baseUrl,
        );

  final AuthApi _authApi;

  @override
  Future<LogInResponse> signIn(Map<String, dynamic> data) async {
    try {
      final response = await _authApi.signIn(data);
      return response..code = HttpStatus.ok;
    } catch (error) {
      switch (error.runtimeType) {
        case DioException:
          return LogInResponse.fromError(error as DioException);
        default:
          return LogInResponse.defaultError();
      }
    }
  }

  @override
  Future<UserModel> signUp(Map<String, dynamic> data) async {
    try {
      final response = await _authApi.signUp(data);
      return response..code = HttpStatus.ok;
    } catch (error) {
      switch (error.runtimeType) {
        case DioException:
          return UserModel.fromError(error as DioException);
        default:
          return UserModel.defaultError();
      }
    }
  }
}
