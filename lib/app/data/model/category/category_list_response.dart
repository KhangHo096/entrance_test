import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/base/base_response.dart';
import 'package:entrance_test/app/data/model/category/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_list_response.g.dart';

@JsonSerializable()
class CategoryListResponse extends BaseResponse {
  List<CategoryModel>? categories;

  CategoryListResponse({
    int? code,
    String? message,
    String? errorMessage,
    this.categories,
  }) : super(
          code: code,
          message: message,
          errorMessage: errorMessage,
        );

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListResponseToJson(this);

  static CategoryListResponse fromError(DioException error) {
    return CategoryListResponse(
      code: error.response?.statusCode,
      errorMessage: error.message,
    );
  }

  static CategoryListResponse defaultError() {
    return CategoryListResponse(
      code: HttpStatus.badRequest,
      errorMessage: 'Unknown error',
    );
  }

  bool success() {
    return code == HttpStatus.ok;
  }

  static CategoryListResponse fromResponse(List<CategoryModel>? categories) {
    return CategoryListResponse(
      code: HttpStatus.ok,
      categories: categories,
    );
  }
}
