import 'package:entrance_test/app/data/model/category/category_model.dart';
import 'package:entrance_test/app/data/rest_api/repository/impl/category/category_repository_impl.dart';
import 'package:entrance_test/app/data/utils/storage_utils.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _categoryRepo = Get.find<CategoryRepositoryImpl>();
  final listCategories = <CategoryModel>[].obs;
  final loading = false.obs;


  @override
  void onInit() {
    _getListCategories();
    super.onInit();
  }

  _getListCategories() async {
    loading.value = true;
    final response = await _categoryRepo.getListCategories();
    loading.value = false;
    if (response.success()) {
      listCategories.value = response.categories ?? [];
    } else {
      ///TODO - Handle error here
    }
  }

  onItemTapped(CategoryModel category) {
    category.selected = !(category.selected ?? false);
    listCategories.refresh();
  }

  bool hasSelectedItems() {
    final index = listCategories.indexWhere((e) => e.selected ?? false);
    return index != -1;
  }

  saveSelectedItems() {
    final selectedItems =
        listCategories.where((e) => e.selected ?? false).toList();
    if (selectedItems.isNotEmpty) {
      Get.find<StorageUtils>().saveCategory(selectedItems);
    }
  }
}
