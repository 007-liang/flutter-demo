import 'dart:async';
import 'package:get/get.dart';
import '/utils/index.dart';
import '/controllers/index.dart';
import '/views/login/login_controller.dart';
import '/api/index.dart';

class LoginCodeController extends GetxController {
  final LoginController _loginController = Get.find<LoginController>();
  final UserController userController = Get.find<UserController>();
  final GlobalDataController globalDataController =
      Get.find<GlobalDataController>();
  // 手机号
  String get phone {
    return _loginController.tel.value;
  }

  // 隐藏中间
  String get hidePhoneNumber {
    return phone.replaceFirst(RegExp(r'\d{4}'), '****', 3);
  }

  // 登录加载
  RxBool isLoginLoading = false.obs;

  // 登录
  void login(String code) async {
    isLoginLoading.value = true;
    try {
      String token = await AuthApis.loginWithCode({'tel': phone, 'code': code});
      globalDataController.updateToken(token);
      Utils.storage.write('token', token);
      await userController.fetchUserInfo();
      Get.back();
      Get.back();
    } finally {
      isLoginLoading.value = false;
    }
  }

  // 倒计时
  RxInt currentTime = 120.obs;

  Timer? timer;

  // 发送验证码加载
  RxBool isSendCodeLoading = false.obs;

  // 倒计时
  void countDown() {
    currentTime.value = 120;
    timer = null;
    timer = Timer.periodic(const Duration(seconds: 1), //每秒调用一次
        (Timer timer) {
      if (currentTime.value < 1) {
        timer.cancel();
      } else {
        currentTime.value -= 1; //自减一
      }
    });
  }

  // 重新发送
  Future<void> resendCode() async {
    isSendCodeLoading.value = true;
    try {
      await AuthApis.getCode({'phone': phone});
      countDown();
    } finally {
      isSendCodeLoading.value = false;
    }
  }

  @override
  onReady() {
    countDown();
  }

  @override
  void onClose() {
    timer?.cancel();
  }
}
