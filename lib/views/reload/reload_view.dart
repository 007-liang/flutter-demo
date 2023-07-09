import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/router/index.dart';
import '/widget/reload/reload.dart';
import 'reload_controller.dart';

class ReloadView extends GetView<ReloadController> {
  const ReloadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          elevation: 0,
        ),
        Transform.translate(offset: Offset(0, -0.02.sh),child:  Reload(
          buttonText: '登录',
          tip: '请登录后再访问',
          onPressed: () => Get.toNamed(Routes.login)?.then(
            (value) => Get.offNamed(controller.redirect),
          ),
        ),)
       
      ],
    );
  }
}
