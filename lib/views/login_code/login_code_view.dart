import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../widget/login_type/login_type.dart';
import 'login_code_controller.dart';

class LoginCodeView extends GetView<LoginCodeController> {
  const LoginCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 61.w),
          child: Obx((() =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // 提示
                Padding(
                    padding: EdgeInsets.only(
                      top: 74.w,
                    ),
                    child: Text(
                      '输入短信验证码',
                      style: TextStyle(
                          fontSize: (44.w).toDouble(),
                          color: const Color(0xff333333)),
                    )),
                // 手机号
                Padding(
                    padding: EdgeInsets.only(
                      top: 30.w,
                    ),
                    child: Text(
                      '4位验证码已发至:${controller.hidePhoneNumber}',
                      style: TextStyle(
                          fontSize: (27.w).toDouble(),
                          color: const Color(0xff333333)),
                    )),
                // 手机号输入框
                Padding(
                    padding: EdgeInsets.only(top: 59.w),
                    child: Center(
                      child: Pinput(
                        enabled: !controller.isLoginLoading.value,
                        onCompleted: (pin) => controller.login(pin),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                      child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 50.w.toDouble(), vertical: 15.w)),
                      overlayColor:
                          MaterialStateProperty.all(const Color(0xfff6f6f6)),
                    ),
                    onPressed: () => controller.resendCode(),
                    child: controller.isSendCodeLoading.value
                        ? Container(
                            height: 32.w,
                            width: 32.w,
                            padding: EdgeInsets.all(20.w),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            '重新发送${controller.currentTime.value > 0 ? '${' ( ${controller.currentTime.value}'} )' : ''}',
                            style: TextStyle(
                                color: Color(
                                    controller.currentTime.value > 0
                                        ? 0xffc6c6c6
                                        : 0xff333333),
                                fontSize: 32.w),
                          ),
                  )),
                ),
                // 提示
                Padding(
                  padding: EdgeInsets.only(top: 145.w),
                  child: Center(
                    child: Text(
                      '新手机号验证后自动创建账户',
                      style: TextStyle(
                          color: const Color(0xff666666), fontSize: 24.w),
                    ),
                  ),
                ),
                LoginType(onTap: () => Get.back())
              ])))),
    );
  }
}
