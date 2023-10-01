import 'dart:convert';
import 'dart:developer';

import 'package:entrance_test/app/data/model/category/category_model.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static const String tokenKey = 'access_token';
  static const String categoryKey = 'category';

  final box = GetStorage();

  String getAccessToken() {
    final token = box.read<String?>(tokenKey);
    return token ?? '';
  }

  setToken(String accessToken) {
    box.write(tokenKey, accessToken);
  }

  List<CategoryModel> getCategory() {
    final json = box.read<String?>(categoryKey);
    if (json?.isNotEmpty == true) {
      List<CategoryModel> result = [];
      try {
        final List<dynamic> jsonData = jsonDecode(json!);
        for (var item in jsonData) {
          final category = CategoryModel.fromJson(item);
          result.add(category);
        }
      } catch (e) {
        log(e.toString());
        return [];
      }
      return result;
    } else {
      return [];
    }
  }

  saveCategory(List<CategoryModel> categories) {
    final json = jsonEncode(categories);
    box.write(categoryKey, json);
  }

  eraseBox() {
    box.erase();
  }
}
