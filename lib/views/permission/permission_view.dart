import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'permission_controller.dart';

class PermissionView extends GetView<PermissionController> {
  const PermissionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('权限设置')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.w),
            cardWidget('请勿开启「省电模式」',
                '在省电模式下，本软件的运行可能会受到限制导致轨迹异常。尽量保持电量处于充足的状态，并且关闭省电模式。相关设置入口一般在状态栏或者电池相关设置里面。'),
            SizedBox(height: 10.w),
            Obx(() => cardWidget(
                '电池优化白名单', '系统为了省电，可能会在定位过程中误杀进程，需要您将本软件加入保护名单中。',
                setting: controller.isBatterySet.value,
                button: true,
                onPressed: () => controller
                    .setIgnoreBattreyOptimizations())),
            SizedBox(height: 10.w),
            Obx(() => cardWidget('后台运行权限', '将本软件加入后台保护名单，可以在一定程度上帮助app在后台持续运行。',
                text2: '设置方法：授权管理-自启动管理-允许应用自启动',
                button: true,
                setting: controller.isAutoStartSet.value,
                onPressed: () =>
                  controller.setAutoStart() )),
          ],
        ),
      ),
    );
  }
}

Widget cardWidget(String title, String text,
    {String? text2, bool? button, bool setting = false, onPressed}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.w),
    ),
    shadowColor: const Color.fromARGB(80, 0, 0, 0),
    elevation: 10.w,
    color: Colors.white, // 背景色
    borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
    child: Container(
        padding: EdgeInsets.fromLTRB(41.w, 36.w, 41.w, 47.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 32.w),
                ),
                button != null
                    ? Container(
                        height: 64.w,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFffa94c),
                              Color(0xFFfc7a22)
                            ]), // 渐变色
                            borderRadius: BorderRadius.circular(100)),
                        child: MaterialButton(
                          disabledColor:
                              const Color.fromARGB(255, 236, 213, 181),
                          splashColor: const Color.fromARGB(255, 184, 157, 95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100
                            ),
                          ),
                          height: 64.w,
                          // minWidth: 156.w,
                          onPressed: setting ? null : onPressed,
                          child: Text(
                            setting ? '已设置' : '快速设置',
                            style:
                                TextStyle(fontSize: 28.w, color: Colors.white),
                          ),
                        ))
                    : Container(),
              ],
            ),
            SizedBox(height: 30.w),
            Text(
              text,
              style: TextStyle(fontSize: 24.w, color: const Color(0xff606567)),
            ),
            text2 != null
                ? Text(
                    text2,
                    style: TextStyle(
                        fontSize: 24.w, color: const Color(0xff606567)),
                  )
                : Container(),
          ],
        )),
  );
}
