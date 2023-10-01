import 'package:entrance_test/app/data/rest_api/dio/dio_factory.dart';
import 'package:entrance_test/app/data/rest_api/repository/impl/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
    Get.lazyPut<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(Get.find<DioFactory>()),
    );
  }
}
