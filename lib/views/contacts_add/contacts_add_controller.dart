import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import '/api/index.dart';

class ContactsAddController extends GetxController {
  final TextEditingController inputPhoneCntroller = TextEditingController();

  RxInt isEmergency = 0.obs;

  // 输入的手机号
  RxString inputPhone = ''.obs;

  // 改变输入的手机号
  void changeInputPhone(value) {
    inputPhone.value = value;
  }

  // 是否显示搜索用户
  bool get isShowSearchContacts {
    if (GetUtils.isPhoneNumber(inputPhone.value)) {
      return true;
    } else {
      return false;
    }
  }

  // 选择联系人
  void selectAddressListContacts() async {
    final PhoneContact contacts = await FlutterContactPicker.pickPhoneContact();
    String? phone = contacts.phoneNumber?.number;
    if (phone != null) {
      phone = GetUtils.removeAllWhitespace(phone);
      inputPhone.value = phone;
      inputPhoneCntroller.value = TextEditingValue(
          text: phone,
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream, offset: phone.length)));
    }
  }

  // 输入备注的控制器
  final TextEditingController inputNicknameController = TextEditingController();

  // 输入的备注
  String nickname = '';

  // 改变备注
  void changeNickname(value) {
    nickname = value;
  }

  // 检测是否注册
  void searchMember(BuildContext context) async {
    int isMember = await ContactsApis.checkIsMmber({'phone': inputPhone.value});
    if (isMember > 0) {
      nickname = '';
      inputNicknameController.text = '';
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  '添加好友',
                  style: TextStyle(
                    fontSize: 30.w,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '请输入备注（选填）',
                      hintStyle: TextStyle(
                          color: const Color(0xff999999),
                          fontSize: 28.w,
                          height: 1.0,
                          fontWeight: FontWeight.normal),
                    ),
                    controller: inputNicknameController,
                    maxLength: 15,
                    onChanged: (value) => changeNickname(value),
                  ),
                  SizedBox(height: 30.w,),
                  Text('对方同意才可以查看位置',style:TextStyle(color: Colors.black45, fontSize: 24.w) ),
                  Text('添加好友以后对方也可以查询您的位置',style:TextStyle(color: Colors.black45, fontSize: 24.w, height: 2))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('取消'),
                  onPressed: () => Get.back(result: context),
                ),
                TextButton(
                  child: const Text('确认'),
                  onPressed: () async {
                    await ContactsApis.addContacts({
                      "phone": inputPhone.value,
                      "nickname": nickname,
                      "is_emergency": isEmergency.value
                    });
                    Get.back();
                    EasyLoading.showInfo('已发送好友申请,请等待好友同意');
                  },
                ),
              ],
            );
          });
    } else {
      EasyLoading.showInfo('账号不存在');
    }
  }

  @override
  void onReady() {
    isEmergency.value =
        Get.arguments != null ? Get.arguments['isEmergency'] : 0;
  }
}
