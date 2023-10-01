import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/category/category_list_response.dart';
import 'package:entrance_test/app/data/rest_api/dio/dio_factory.dart';
import 'package:entrance_test/app/data/rest_api/repository/category/category_api.dart';
import 'package:entrance_test/app/data/rest_api/repository/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(DioFactory client)
      : _categoryApi = CategoryApi(
          client.dio,
          baseUrl: client.baseUrl,
        );

  final CategoryApi _categoryApi;

  @override
  Future<CategoryListResponse> getListCategories() async {
    try {
      final response = await _categoryApi.getListCategories();
      return CategoryListResponse.fromResponse(response);
    } catch (error) {
      switch (error.runtimeType) {
        case DioException:
          return CategoryListResponse.fromError(error as DioException);
        default:
          return CategoryListResponse.defaultError();
      }
    }
  }
}
