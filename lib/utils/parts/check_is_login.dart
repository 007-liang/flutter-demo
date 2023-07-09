import '/controllers/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

checkIsLogin(Function callback) async {
  UserController userController = Get.find<UserController>();

  if (userController.userInfo.value == null) {
    EasyLoading.showToast('请先登录账号');
  } else {
    callback();
  }
}
