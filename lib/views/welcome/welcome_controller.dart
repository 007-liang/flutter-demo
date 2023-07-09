import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/controllers/parts/global_data_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '/router/index.dart';
import '/utils/index.dart';

class WelcomeController extends GetxController {
  @override
  Future<void> onReady() async {
    bool? isAllowAgreement = Utils.storage.read('is_allow_agreement');
    if (isAllowAgreement != null) {
      await Permission.location.request().isGranted;
      Future.delayed(
          const Duration(milliseconds: 1200), () => Get.offNamed(Routes.index));
    } else {
      Get.put(GlobalDataController());
      Get.dialog(
          WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Transform.translate(
                offset: Offset(0, -0.02.sh),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.w),
                    height: 550.w,
                    width: 0.9.sw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Center(
                          child: Text('服务协议和隐私协议'),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(children: [
                              const TextSpan(
                                text:
                                    '服务协议和隐私协议请你务必审慎阅读、充分理解服务协和隐私协议各条款,包括但不限于:为了向你提供实时定位，内容分享，一键求助等服务，我们需要收集你的设备位置信息，电话通讯录等个人信息。你可以在“设置”中查看，变更，查看你的授权。你可阅读',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
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
                                text: '了解详细信息,如你同意,请点击' '同意' '开始接受我们的服务',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ])
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                EasyLoading.showToast('未同意服务协议及隐私协议不可使用!');
                                Future.delayed(const Duration(seconds: 1), () {
                                  SystemNavigator.pop();
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 30.w),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.w,
                                  horizontal: 50.w,
                                ),
                                color: const Color(0xffF7F8FC),
                                child: const Text('不同意'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Utils.storage.write('is_allow_agreement', true);
                                Get.back();
                                onReady();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 30.w),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.w,
                                  horizontal: 50.w,
                                ),
                                color: const Color(0xff49D896),
                                child: const Text(
                                  '同意',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          barrierDismissible: false);
    }
  }
}
