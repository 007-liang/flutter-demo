import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'dart:async';

class PermissionController extends GetxController {
  RxBool isBatterySet = false.obs;
  RxBool isAutoStartSet = false.obs;

  void setAutoStart() async {
    await getAutoStartPermission();
  }

  Future<void> checkAutoStartPermission() async {
    // isAutoStartAvailable.then((value) {
    //   if (value != null && value) {
    //     isAutoStartSet.value = true;
    //   }
    // });
  }

  void setIgnoreBattreyOptimizations() async {
    if (await Permission.ignoreBatteryOptimizations.request().isGranted) {
      isBatterySet.value = true;
    }
  }

  Future<void> checkIgnoreBattreyOptimizationsPermission() async {
    isBatterySet.value = await Permission.ignoreBatteryOptimizations.isGranted;
  }

  @override
  void onReady() {
    checkAutoStartPermission();
    checkIgnoreBattreyOptimizationsPermission();
  }
}
