import 'package:entrance_test/app/data/rest_api/dio/dio_factory.dart';
import 'package:entrance_test/app/data/utils/storage_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  ///Put in Dio factory
  Get.put<DioFactory>(DioFactory());

  ///Get storage
  await GetStorage.init();
  Get.put<StorageUtils>(StorageUtils());

  ///Start fresh
  Get.find<StorageUtils>().eraseBox();

  runApp(
    FlutterSizer(
      builder: (context, orientation, screenType) => GetMaterialApp(
        title: "Nexle test",
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
