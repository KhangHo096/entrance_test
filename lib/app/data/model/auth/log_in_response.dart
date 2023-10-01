import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/auth/user_model.dart';
import 'package:entrance_test/app/data/model/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log_in_response.g.dart';

@JsonSerializable()
class LogInResponse extends BaseResponse {
  UserModel? user;
  String? accessToken;
  String? refreshToken;

  LogInResponse({
    int? code,
    String? message,
    String? errorMessage,
    this.user,
    this.accessToken,
    this.refreshToken,
  }) : super(
          code: code,
          message: message,
          errorMessage: errorMessage,
        );

  factory LogInResponse.fromJson(Map<String, dynamic> json) =>
      _$LogInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogInResponseToJson(this);

  static LogInResponse fromError(DioException error) {
    return LogInResponse(
      code: error.response?.statusCode,
      errorMessage: error.message,
    );
  }

  static LogInResponse defaultError() {
    return LogInResponse(
      code: HttpStatus.badRequest,
      errorMessage: 'Unknown error',
    );
  }

  bool success() {
    return code == HttpStatus.ok;
  }
}
