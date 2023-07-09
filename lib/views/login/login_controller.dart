import 'package:get/get.dart';
import '/api/index.dart';
import '/utils/index.dart';
import '/router/index.dart';
import '/controllers/index.dart';

class LoginController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final GlobalDataController globalDataController =
      Get.find<GlobalDataController>();
  RxInt loginType = 0.obs; // 0 验证码 1 账号密码

  // 手机号
  RxString tel = ''.obs;

  // 密码
  RxString password = ''.obs;

  // 按钮加载
  RxBool isLoading = false.obs;

  // 同意隐私协议
  RxBool isAllow = false.obs;
  
  // 改变同意隐私协议状态
  changeAllowState() {
    isAllow.value =  !isAllow.value;
  }

  // 按钮是否可用
  bool get isButtonUnable {
    if (loginType.value == 0) {
      return tel.value.isEmpty || !isAllow.value;
    } else {
      return tel.value.isEmpty || password.value.isEmpty || !isAllow.value;
    }
  }

  // 输入手机号
  void changeTel(String inputTel) {
    tel.value = inputTel;
  }

  // 输入密码
  void changePassword(String inputPassword) {
    password.value = inputPassword;
  }

  // 改变登录状态
  void changeLoginType() {
    password.value = '';
    loginType.value = loginType.value == 0 ? 1 : 0;
  }

  // 点击按钮
  void handleSubmit() {
    loginType.value == 0 ? sendCode() : login();
  }

  // 获取验证码
  void sendCode() async {
    isLoading.value = true;
    try {
      await AuthApis.getCode({'phone': tel.value});
      Get.toNamed('${Routes.login}/${Routes.loginCode}');
    } finally {
      isLoading.value = false;
    }
  }

  // 登录
  void login() async {
    isLoading.value = true;
    try {
      String token = await AuthApis.loginWidthPassword(
          {'tel': tel.value, 'password': password.value});
      globalDataController.updateToken(token);
      Utils.storage.write('token', token);
      await _userController.fetchUserInfo();
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }
}
