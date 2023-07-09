import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/index.dart';
import '/api/index.dart';

class ContactsSettingController extends GetxController {
  // 联系人
  late Contacts contacts;

  // 备注
  RxString nickname = ''.obs;

  // 输入的昵称
  String inputNickname = '';

  late TextEditingController inputNicknameController;

  // 改变输入昵称
  void changeInputNickname(String value) {
    inputNickname = value;
  }

  // 修改备注
  void updateNickname() async {
    Map data = {"id": contacts.id, 'nickname': inputNickname};
    await ContactsApis.updateContacts(data);
    nickname.value = inputNickname;
    Get.back();
  }

  // 是否是紧急联系人
  RxInt isEmergency = 0.obs;

  // 是否隐藏位置
  RxInt isHidden = 0.obs;

  // 修改状态
  void updateState(String type) async {
    int number =
        (type == 'hidden' ? isHidden.value : isEmergency.value) > 0 ? 0 : 1;
    Map data = {
      "id": contacts.id,
      "is_emergency": isEmergency.value,
      "is_hidden": isHidden.value,
    };
    data[type == 'hidden' ? 'is_hidden' : 'is_emergency'] = number;
    await ContactsApis.updateContacts(data);
    type == 'hidden' ? (isHidden.value = number) : (isEmergency.value = number);
  }

  // 删除联系人
  void deleteContacts() async {
    await ContactsApis.deleteContacts({'id': contacts.id});
    Get.back();
    Get.back();
  }

  @override
  onReady() {
    String? jsonContacts = Get.arguments['contacts'];
    if (jsonContacts != null) {
      contacts = Contacts.fromJson(jsonDecode(jsonContacts));
      isEmergency.value = contacts.isEmergency;
      isHidden.value = contacts.isHidden;
      nickname.value = contacts.nickname;
    }
  }
}
