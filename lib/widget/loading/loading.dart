import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 50.w),
        height: 50.w,
        child: Center(
            child: SizedBox(
          height: 50.w,
          width: 50.w,
          child: const CircularProgressIndicator(
            strokeWidth: 4,
          ),
        )));
  }
}
