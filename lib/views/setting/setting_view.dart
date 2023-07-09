import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/model/index.dart';
import '/router/index.dart';
import '/widget/cell/cell.dart';
import 'setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Rxn<UserInfo> userInfo = controller.userInfo;
    final TextEditingController textController = controller.textController();
    return Scaffold(
        backgroundColor: const Color(0xfff7f6f5),
        appBar: AppBar(
          elevation: 0,
          title: const Text('设置'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 17.w,
          ),
          settingViewCell(Cell(
            label: '头像',
            onTap: () => showAdaptiveActionSheet(
              context: context,
              androidBorderRadius: 30,
              actions: controller.updateAvatarOptionList
                  .map((item) => BottomSheetAction(
                      title: Text(item.title),
                      onPressed: () {
                        Get.back(result: context);
                        controller.updateAvatar(item.source);
                      }))
                  .toList(),
              cancelAction: CancelAction(
                  title: const Text(
                '取消',
                style: TextStyle(color: Colors.red),
              )), // onPressed parameter is optional by default will dismiss the ActionSheet
            ),
            isLink: false,
            content: Padding(
              padding: EdgeInsets.only(right: 29.w),
              child: ClipOval(
                  child: Obx(() => userInfo.value == null || userInfo.value!.avatar.isEmpty
                      ? Image.asset(
                          'assets/images/user/avatar.png',
                          width: 72.w,
                          height: 72.w,
                        )
                      : Image.network(
                          userInfo.value!.avatar,
                          width: 72.w,
                          height: 72.w,
                          fit: BoxFit.cover,
                        ))),
            ),
          )),
          settingViewCell(
            Cell(
                label: '昵称',
                onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              '修改名称',
                              style: TextStyle(
                                fontSize: 30.w,
                              ),
                            ),
                          ),
                          content: TextField(
                            controller: textController,
                            maxLength: 15,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('取消'),
                              onPressed: () => Get.back(result: context),
                            ),
                            TextButton(
                                child: const Text('确认'),
                                onPressed: () {
                                  if (textController.text.isEmpty) {
                                    EasyLoading.showToast('名称不能为空');
                                  } else {
                                    Get.back(result: context);
                                    controller
                                        .updateNickname(textController.text);
                                  }
                                }),
                          ],
                        );
                      },
                    ),
                content: Obx(() => Text(
                    userInfo.value!.nickname.isEmpty
                        ? userInfo.value!.phoneNum
                        : userInfo.value!.nickname,
                    style: TextStyle(
                        fontSize: 32.w, color: const Color(0xff666666))))),
          ),
          SizedBox(
            height: 17.w,
          ),
          settingViewCell(
              Cell(label: '密码修改', onTap: () => Get.toNamed(Routes.passwordUpdate, arguments: {
                "title": "密码修改"
              }))),
          settingViewCell(
              Cell(label: '权限设置', onTap: () => Get.toNamed(Routes.permission))),
          settingViewCell(
              Cell(label: '服务协议', onTap: () => Get.toNamed(Routes.agreement,arguments: {'title': '服务协议'}))),
          settingViewCell(
              Cell(label: '隐私协议', onTap: () => Get.toNamed(Routes.agreement,arguments: {'title': '隐私协议'}))),
          settingViewCell(Cell(
              label: '永久销户',
              onTap: () => Get.bottomSheet(CloseAccountBottomSheet()))),
          settingViewCell(Cell(
              label: '当前版本',
              isLink: false,
              content: Padding(
                padding: EdgeInsets.only(right: 29.w),
                child: Text('V2.0.0',
                    style: TextStyle(
                        fontSize: 28.w, color: const Color(0xff999999))),
              ))),

        ])));
  }
}

Widget settingViewCell(Cell cell) {
  return cell.copyWith(suffixIconWidget: SizedBox(width: 33.w), height: 100);
}

// 注销账号
class CloseAccountBottomSheet extends StatelessWidget {
  CloseAccountBottomSheet({Key? key}) : super(key: key);

  final SettingController controller = Get.find<SettingController>();

  final TextStyle tipStyle =
      TextStyle(color: const Color(0xff1e1e1e), fontSize: 28.w);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 637.w,
        padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.w),
            topRight: Radius.circular(
              50.w,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20.w,
              top: 0,
              child: IconButton(
                onPressed: () => Get.back(result: context),
                color: const Color(0xff93979a),
                splashColor: Colors.black,
                highlightColor: Colors.black,
                icon: const Icon(
                  Icons.close,
                ),
                iconSize: 60.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.w),
                Text(
                  '注销账号风险提示',
                  style: TextStyle(fontSize: 40.w, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 51.w,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Colors.black,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '注销账号会删除用户所有的信息，包括会员信息',
                          style: tipStyle,
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 19.w)),
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: Colors.black,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15.w)),
                        Text('若您是想退出登录，页面底部有按钮可以操作哦', style: tipStyle)
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => GestureDetector(
                              onTap: () =>
                                  controller.changeConfirmCancelAccount(),
                              child: Image.asset(
                                'assets/images/common/${controller.isConfirmCancelAccount.value ? 'checkbox_active' : 'checkbox'}.png',
                                width: 40.w,
                              ),
                            )),
                        SizedBox(width: 15.w),
                        Text(
                          '我已阅读以上提示，确认注销账号',
                          style: TextStyle(
                              fontSize: 24.w, color: const Color(0xff999999)),
                        )
                      ],
                    ),
                    SizedBox(height: 33.w),
                    Container(
                        width: 690.w,
                        height: 90.w,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFffa94c),
                              Color(0xFFfc7a22)
                            ]), // 渐变色
                            borderRadius: BorderRadius.circular(20.w)),
                        child: Obx(() => MaterialButton(
                              disabledColor:
                                  const Color.fromARGB(255, 236, 213, 181),
                              splashColor:
                                  const Color.fromARGB(255, 184, 157, 95),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w
                                ),
                              ),
                              height: 64.w,
                              // minWidth: 156.w,
                              onPressed: controller.isConfirmCancelAccount.value && !controller.isCancelAccountLoading.value
                                  ? () => controller.cancelAccount()
                                  : null,
                              child: controller.isCancelAccountLoading.value
                          ? Container(
                              height: 64.w,
                              width: 64.w,
                              padding: EdgeInsets.all(20.w),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ) :
                              
                              Text(
                                '注销账号',
                                style: TextStyle(
                                    fontSize: 36.w, color: Colors.white),
                              ),
                            )))
                  ],
                )),
              ],
            )
          ],
        ));
  }
}
