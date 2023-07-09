import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future show(
          {required List<Widget> tipChildren,
          required String title,
          required Function onPressed,
          confirmTitle = '确认'}) =>
      Get.dialog(DefaultTextStyle(
        style:
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        child: Transform.translate(
          offset: Offset(0, -0.05.sh),
          child: Center(
            child: SizedBox(
              width: 600.w,
              child: Stack(
                children: [
                  Image.asset('assets/images/common/dialog_bg.png'),
                  Positioned(
                      width: 600.w,
                      top: 60.w,
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 40.w),
                          ),
                        ),
                      )),
                  Positioned(
                    width: 600.w,
                    top: 130.w,
                    child: DefaultTextStyle(
                        style: TextStyle(
                            color: const Color(0xff666666), fontSize: 28.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: tipChildren,
                        )),
                  ),
                  Positioned(
                      width: 600.w,
                      bottom: 50.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                elevation: 0,
                                color: const Color(0xfff3f5f7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.w),
                                ),
                                minWidth: 250.w,
                                height: 88.w,
                                // minWidth: 156.w,
                                onPressed: () => Get.back(),
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: 32.w,
                                      color: const Color(0xff999999)),
                                )),
                            Container(
                              height: 88.w,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffff7a4c),
                                    Color(0xffff3737)
                                  ]), // 渐变色
                                  borderRadius: BorderRadius.circular(12.w)),
                              child: MaterialButton(
                                minWidth: 250.w,
                                height: 88.w,
                                splashColor:
                                    const Color.fromARGB(255, 222, 47, 47),
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 15.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.w
                                  ),
                                ),
                                onPressed: () => onPressed(),
                                child: Text(
                                  confirmTitle,
                                  style: TextStyle(
                                      fontSize: 32.w, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ));
}
