import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/router/index.dart';
import 'login_controller.dart';
import '/widget/login_type/login_type.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 61.w),
          child: Obx((() =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // 欢迎文本
                Padding(
                    padding: EdgeInsets.only(
                      top: 78.w,
                    ),
                    child: Text(
                      'Hello 欢迎您回来',
                      style: TextStyle(
                          fontSize: (34.w).toDouble(),
                          color: const Color(0xff333333)),
                    )),
                // 登录类型文本
                Padding(
                    padding: EdgeInsets.only(
                      top: 30.w,
                    ),
                    child: Text(
                      controller.loginType.value == 0 ? '手机号码登录' : '账号密码登录',
                      style: TextStyle(
                          fontSize: (44.w).toDouble(),
                          color: const Color(0xff333333)),
                    )),
                // 手机号输入框
                Padding(
                  padding: EdgeInsets.only(
                    top: 100.w,
                  ),
                  child: Container(
                      height: 94.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 44.w,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f5f3),
                        borderRadius: BorderRadius.circular(
                          44.w,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: '请输入手机号码',
                              hintStyle: TextStyle(
                                fontSize: 26.w,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero),
                          onChanged: (value) => controller.changeTel(value),
                        ),
                      )),
                ),
                // 密码输入框
                Offstage(
                  offstage: controller.loginType.value == 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16.w,
                    ),
                    child: Container(
                        height: 94.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 44.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff6f5f3),
                          borderRadius: BorderRadius.circular(
                            44.w,
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: '请输入密码',
                                hintStyle: TextStyle(
                                  fontSize: 26.w,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.zero),
                            onChanged: (value) =>
                                controller.changePassword(value),
                          ),
                        )),
                  ),
                ),
                // 登录按钮
                Padding(
                  padding: EdgeInsets.only(top: 40.w, bottom: 30.w),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100
                        ),
                      ),
                      disabledTextColor: Colors.white,
                      disabledColor: const Color.fromRGBO(255, 118, 0, 0.4),
                      height: 94.w,
                      minWidth: double.infinity,
                      color: const Color(0xffff7600),
                      onPressed: controller.isButtonUnable
                          ? null
                          : () => controller.handleSubmit(),
                      child: controller.isLoading.value
                          ? Container(
                              height: 94.w,
                              width: 94.w,
                              padding: EdgeInsets.all(20.w),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              controller.loginType.value == 0
                                  ? '获取短信验证码'
                                  : '登录',
                              style: TextStyle(
                                  fontSize: 28.w, color: Colors.white),
                            )),
                ),
                // 忘记密码
                Offstage(
                  offstage: controller.loginType.value == 0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.w),
                    child: Center(
                        child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.passwordUpdate),
                      child: Text(
                        '忘记密码',
                        style: TextStyle(
                            fontSize: 24.w, color: const Color(0xff3c85c9)),
                      ),
                    )),
                  ),
                ),

                //隐私协议
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => GestureDetector(
                          onTap: () => controller.changeAllowState(),
                          child: Image.asset(
                            'assets/images/common/${controller.isAllow.value ? 'checkbox_active' : 'checkbox'}.png',
                            width: 40.w,
                          ),
                        )),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          const TextSpan(
                            text: '我已阅读并同意',
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.agreement,
                                  arguments: {'title': '服务协议'}),
                            text: '《服务协议》',
                            style: const TextStyle(
                              color: Color(0xff8DBFFC),
                            ),
                          ),
                          const TextSpan(
                            text: '、',
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.agreement,
                                  arguments: {'title': '隐私协议'}),
                            text: '《隐私协议》',
                            style: const TextStyle(
                              color: Color(0xff8DBFFC),
                            ),
                          ),
                          const TextSpan(
                            text: '，并授权手机号码及地址管理',
                          )
                        ]),
                        style: TextStyle(
                            fontSize: 24.w, color: const Color(0xff999999)),
                      ),
                    )
                  ],
                ),

                // 提示
                controller.loginType.value == 0
                    ? Padding(
                        padding: EdgeInsets.only(top: 30.w),
                        child: Center(
                          child: Text(
                            '新手机号验证后自动创建账户',
                            style: TextStyle(
                                color: const Color(0xff666666), fontSize: 24.w),
                          ),
                        ),
                      )
                    : Container(),
                LoginType()
              ])))),
    );
  }
}
