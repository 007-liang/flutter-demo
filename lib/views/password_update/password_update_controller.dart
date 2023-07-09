import 'dart:async';
import 'package:get/get.dart';
import '/api/index.dart';

class PasswordUpdateController extends GetxController {

  RxString title = ''.obs;

  Timer? timer;

  // 倒计时
  RxInt currentTime = 0.obs;

  //
  RxBool isLoading = false.obs;

  // 手机号
  RxString tel = ''.obs;

  // 修改手机号
  void changeTel(String inputTel) {
    tel.value = inputTel;
  }

  // 发送验证码加载
  RxBool isSendCodeLoading = false.obs;

  // 验证码
  RxString code = ''.obs;

  // 修改验证码
  void changeCode(String inputTel) {
    code.value = inputTel;
  }

  // 密码
  RxString password = ''.obs;

  // 修改密码
  void changePassword(String inputTel) {
    password.value = inputTel;
  }

  bool get isButtonUnable {
    return code.value.isEmpty || password.value.isEmpty || tel.value.isEmpty;
  }

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
      await AuthApis.getCode({'phone': tel.value});
      countDown();
    } finally {
      isSendCodeLoading.value = false;
    }
  }

  void updatePassword() async {
    isLoading.value = true;
    try {
      await AuthApis.updatePaassword({
        'tel': tel.value,
        'code': code.value,
        'newpassword': password.value
      });
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    title.value = Get.arguments != null ? Get.arguments['title'] : '忘记密码';
  }
}
