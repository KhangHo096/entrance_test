import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/category/category_model.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api.g.dart';

@RestApi()
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String baseUrl}) = _CategoryApi;

  @GET('/categories')
  Future<List<CategoryModel>?> getListCategories();
}
