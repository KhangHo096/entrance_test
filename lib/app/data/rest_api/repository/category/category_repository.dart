import 'package:entrance_test/app/data/model/category/category_list_response.dart';

abstract class CategoryRepository {
  Future<CategoryListResponse> getListCategories();
}
