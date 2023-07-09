import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 250.w),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(38.w),
                    child: Image.asset(
                      'assets/images/welcome.png',
                      width: 140.w,
                      height: 140.w,
                    )),
                SizedBox(
                  height: 140.w,
                ),
                Text(
                  '守 护 您 的 每 一 天',
                  style: TextStyle(color: const Color.fromARGB(255, 159, 159, 159), fontSize: 36.sp),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
