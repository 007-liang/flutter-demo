import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'service_controller.dart';
import '../../widget/loading/loading.dart';

class ServiceView extends GetView<ServiceController> {
  const ServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('联系客服')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: controller.obx(
            (state) => Column(
                  children: [
                    SizedBox(height: 21.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.w),
                      child: Image.asset('assets/images/user/service_bg.png'),
                    ),
                    serviceCell(
                        icon: 'assets/images/user/service_mail.png',
                        label: '邮件客服',
                        desc: state!.email,
                        buttonText: '复制',
                        onPressed: () => controller.copy(state.email)),
                    serviceCell(
                        icon: 'assets/images/user/service_qq.png',
                        label: 'QQ客服',
                        desc: state.qq,
                        buttonText: '复制',
                        onPressed: () => controller.copy(state.qq)),
                  ],
                ),
            onLoading: const Loading()),
      ),
    );
  }
}

Widget serviceCell(
    {required String icon,
    required String label,
    required String desc,
    required String buttonText,
    required Function onPressed}) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.w),
      ),
      shadowColor: const Color.fromARGB(47, 0, 0, 0),
      elevation: 8.w,
      margin: EdgeInsets.only(top: 21.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            icon,
            width: 60.w,
          ),
          SizedBox(width: 30.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    TextStyle(color: const Color(0xff1e1e1e), fontSize: 36.w),
              ),
              SizedBox(height: 10.w),
              Text(desc,
                  style: TextStyle(
                      color: const Color(0xff666666), fontSize: 26.w)),
            ],
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 60.w,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFffa94c),
                          Color(0xFFfc7a22)
                        ]), // 渐变色
                        borderRadius: BorderRadius.circular(100)),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100
                        ),
                      ),
                      height: 64.w,
                      // minWidth: 156.w,
                      onPressed: () => onPressed(),
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 28.w, color: Colors.white),
                      ),
                    )),
              ))
        ]),
      ));
}
