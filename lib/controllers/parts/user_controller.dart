import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/controllers/index.dart';
import '/api/index.dart';
import '/model/index.dart';
import '/router/index.dart';
import '/utils/index.dart';
import '/views/index/index_controller.dart';

class UserController extends GetxController {
  GlobalDataController globalDataController = Get.find<GlobalDataController>();
  NotificationController notificationController =
      Get.find<NotificationController>();
  RxInt vipOpenFucntionState = 1.obs;
  RxInt vipTrial = 1.obs;

  void fetchUserFunctionState() async {
    vipOpenFucntionState.value = await CommonApis.fetchFunctionState(6);
    vipTrial.value = await CommonApis.fetchFunctionState(7);
  }

  // 用户信息
  Rxn<UserInfo> userInfo = Rxn(null);

  // 跳转登录
  void toLogin() {
    if (userInfo.value == null) {
      Get.toNamed(Routes.login);
    }
  }

  // 退出
  void logout() async {
    CustomDialog.show(
      tipChildren: [
        const Text('是否确认退出登录'),
      ],
      title: '退出登录',
      onPressed: () async {
        LocationController locationController = Get.find<LocationController>();
        Get.back();
        globalDataController.updateToken(null);
        notificationController.clear();
        locationController.addressInformation.clear();
        await Utils.storage.remove('token');
        userInfo.value = null;
      },
    );
  }

  // 会员试用
  void prime() async {
    await UserApis.fetchPrime();
    await fetchUserInfo();
    EasyLoading.showSuccess('成功领取试用会员');
    Get.back();
  }

  Future fetchUserInfo() async {
    Map<String, dynamic> res = await UserApis.fetchUserInfo();
    userInfo.value = UserInfo.fromMap(res);
  }

  @override
  Future<void> onReady() async {
    String token = globalDataController.token.value ?? '';
    if (token.isNotEmpty) {
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.doubleBounce
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45
        ..boxShadow = []
        ..backgroundColor = Colors.transparent
        ..textColor = Colors.white
        ..indicatorColor = Colors.white;

      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      try {
        await fetchUserInfo();
        EasyLoading.dismiss();
      } catch (e) {
        final IndexController indexController = Get.find<IndexController>();
        Future.delayed(const Duration(milliseconds: 1500), () {
          EasyLoading.showError('获取用户信息失败');
          indexController.changePage(3);
        });
      } finally {
        Future.delayed(const Duration(milliseconds: 1000),
            () => EasyLoading.instance..loadingStyle = EasyLoadingStyle.dark);
      }
    }
  }
}
