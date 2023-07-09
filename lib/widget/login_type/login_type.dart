import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../views/login/login_controller.dart';

class LoginType extends StatelessWidget {
  final Function? onTap;
  LoginType({Key? key, this.onTap}) : super(key: key);
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SafeArea(
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 60.w,
                    margin: EdgeInsets.symmetric(horizontal: 9.w),
                    color: const Color(0xffe6e6e6),
                  ),
                  Text('使用其他方式登录',
                      style: TextStyle(
                          color: const Color(0xff333333), fontSize: 26.w)),
                  Container(
                    height: 1,
                    width: 60.w,
                    margin: EdgeInsets.symmetric(horizontal: 9.w),
                    color: const Color(0xffe6e6e6),
                  ),
                ],
              ),
              SizedBox(height: 40.w),
              Obx(() => Ink.image(
                    image: AssetImage(
                        'assets/images/login/login_${_loginController.loginType.value > 0 ? 'code' : 'password'}.png'),
                    child: InkWell(
                      borderRadius:
                         BorderRadius.circular(100),
                      child: SizedBox(
                        width: 100.w,
                        height: 100.w,
                      ),
                      onTap: () {
                        onTap != null ? onTap!() : null;
                        _loginController.changeLoginType();
                      },
                    ),
                  )),
              SizedBox(height: 20.w),
            ],
          ),
        ));
  }
}
