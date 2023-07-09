import 'package:flutter/material.dart';
import '/router/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Reload extends StatelessWidget {
  final String tip;
  final Function? onPressed;
  final String? buttonText;
  const Reload(
      {Key? key,
      required this.tip,
      this.onPressed,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset('assets/images/reload_empty.png', width: 0.5.sw),
          ),
          Padding(
            padding: EdgeInsets.only(top: 65.w, bottom: 15.w),
            child: Text(
              tip,
              style: TextStyle(fontSize: 32.w, color: Colors.black87),
            ),
          ),
          MaterialButton(
            height: 65.w,
            padding: EdgeInsets.zero,
            color: const Color(0xffff7600),
            onPressed: () => onPressed == null ? Get.toNamed(Routes.login)  : onPressed!(),
            child: Text(buttonText ?? '登录',
                style: TextStyle(fontSize: 28.w, color: Colors.white)),
          ),
        ]));
  }
}
