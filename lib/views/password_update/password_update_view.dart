import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widget/cell/cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'password_update_controller.dart';

class PasswordUpdateView extends GetView<PasswordUpdateController> {
  const PasswordUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        elevation: 0,
        title: Obx(()=> Text(controller.title.value)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(25.w),
            child: Text(
              '我们需要验证您的手机号码',
              style: TextStyle(color: const Color(0xff999999), fontSize: 24.w),
            ),
          ),
          passwordForgetViewCell(Cell(
            label: "手机号码",
            isLink: false,
            content: Padding(
                padding: EdgeInsets.only(left: 60.w),
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
                )),
          )),
          passwordForgetViewCell(Cell(
            label: "验证码",
            isLink: false,
            content: Padding(
                padding: EdgeInsets.only(left: 90.w),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                        LengthLimitingTextInputFormatter(4)
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: '请输入验证码',
                          hintStyle: TextStyle(
                            fontSize: 26.w,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero),
                      onChanged: (value) => controller.changeCode(value),
                    )),
                    Obx(() => MaterialButton(
                          height: 60.w,
                          onPressed: controller.currentTime.value > 0
                              ? null
                              : () => controller.resendCode(),
                          color: const Color(0xffff7600),
                          disabledColor: const Color.fromARGB(123, 255, 119, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w
                            ),
                          ),
                          textColor: Colors.white,
                          child: controller.isSendCodeLoading.value
                              ? Container(
                                  height: 32.w,
                                  width: 32.w,
                                  padding: EdgeInsets.all(20.w),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  controller.currentTime.value == 0
                                      ? '获取验证码'
                                      : controller.currentTime.value.toString(),
                                  style: TextStyle(
                                      color: Color(
                                          controller.currentTime.value == 0
                                              ? 0xffffffff
                                              : 0xfff1f1f1),
                                      fontSize: 26.w),
                                ),
                        )),
                    SizedBox(
                      width: 20.w,
                    )
                  ],
                )),
          )),
          passwordForgetViewCell(Cell(
            label: "新密码",
            isLink: false,
            content: Padding(
                padding: EdgeInsets.only(left: 90.w),
                child: TextField(
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
                  onChanged: (value) => controller.changePassword(value),
                )),
          )),
          Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.w),
                  child:  Obx(()=> MaterialButton(
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
                          : () => controller.updatePassword(),
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
                             '修改密码',
                              style: TextStyle(
                                  fontSize: 28.w, color: Colors.white),
                            )),
                )),
       ],
      ),
    );
  }
}

Widget passwordForgetViewCell(Cell widget) {
  return widget.copyWith(suffixIconWidget: SizedBox(width: 25.w), height: 100);
}
