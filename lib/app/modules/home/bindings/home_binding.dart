import 'package:entrance_test/app/data/rest_api/dio/dio_factory.dart';
import 'package:entrance_test/app/data/rest_api/repository/impl/category/category_repository_impl.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CategoryRepositoryImpl>(
      () => CategoryRepositoryImpl(Get.find<DioFactory>()),
    );
  }
}
