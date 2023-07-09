import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/widget/cell/cell.dart';
import '/utils/index.dart';
import 'contacts_setting_controller.dart';

class ContactsSettingView extends GetView<ContactsSettingController> {
  const ContactsSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('设置'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  SizedBox(
                    height: 16.w,
                  ),
                  contactsSettingCell(Cell(
                      onTap: () {
                        controller.inputNicknameController =
                            TextEditingController(
                                text: controller.nickname.value);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    '请设置好友备注',
                                    style: TextStyle(
                                      fontSize: 30.w,
                                    ),
                                  ),
                                ),
                                content: TextField(
                                  controller:
                                      controller.inputNicknameController,
                                  maxLength: 15,
                                  onChanged: (value) =>
                                      controller.changeInputNickname(value),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('取消'),
                                    onPressed: () => Get.back(result: context),
                                  ),
                                  TextButton(
                                    child: const Text('确认'),
                                    onPressed: () async {
                                      controller.updateNickname();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      label: '备注',
                      content: Text(
                        controller.nickname.value,
                        style: TextStyle(
                            fontSize: 32.w, color: const Color(0xff999999)),
                      ))),
                  SizedBox(
                    height: 16.w,
                  ),
                  contactsSettingCell(
                    Cell(
                        onTap: () => controller.updateState('emergency'),
                        label: '设为紧急联系人',
                        content: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                activeColor: const Color(0xffff7600),
                                value: controller.isEmergency.value != 0,
                                onChanged: (value) =>
                                    controller.updateState('emergency'))),
                        isLink: false),
                  ),
                  contactsSettingCell(
                    Cell(
                        onTap: () => controller.updateState('hidden'),
                        label: '对Ta隐藏位置',
                        content: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                activeColor: const Color(0xffff7600),
                                value: controller.isHidden.value != 0,
                                onChanged: (value) =>
                                    controller.updateState('hidden'))),
                        isLink: false),
                  ),
                  SizedBox(
                    height: 48.w,
                  ),
                  Ink(
                      color: Colors.white,
                      height: 100.w,
                      child: InkWell(
                          onTap: () => CustomDialog.show(
                                  tipChildren: [
                                    Text(
                                      '是否确认删除联系人 ${controller.contacts.nickname}',
                                    )
                                  ],
                                  title: '提醒',
                                  onPressed: () => controller.deleteContacts()),
                          child: Center(
                            child: Text(
                              '删除好友',
                              style: TextStyle(
                                  fontSize: 32.w,
                                  color: const Color(0xffff3b30)),
                            ),
                          )))
                ],
              ))),
    );
  }
}

Widget contactsSettingCell(Cell cell) {
  return cell.copyWith(
      suffixIconWidget: SizedBox(
    width: 32.w,
    height: 100.w,
  ));
}
