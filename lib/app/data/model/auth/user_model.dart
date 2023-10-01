import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseResponse {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? createdAt;
  String? updatedAt;

  UserModel({
    int? code,
    String? message,
    String? errorMessage,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.createdAt,
    this.updatedAt,
  }) : super(
          code: code,
          message: message,
          errorMessage: errorMessage,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static UserModel fromError(DioException error) {
    return UserModel(
      code: error.response?.statusCode,
      errorMessage: error.message,
    );
  }

  static UserModel defaultError() {
    return UserModel(
      code: HttpStatus.badRequest,
      errorMessage: 'Unknown error',
    );
  }

  bool success() {
    return code == HttpStatus.ok;
  }
}
