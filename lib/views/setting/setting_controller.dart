import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../router/index.dart';
import '/api/index.dart';
import '/model/index.dart';
import '/utils/index.dart';
import '/controllers/index.dart';

class UpdateAvatarOption {
  final String title;
  final ImageSource source;

  UpdateAvatarOption({required this.title, required this.source});
}

class SettingController extends GetxController {
  final UserController _userController = Get.find<UserController>();

  Rxn<UserInfo> get userInfo => _userController.userInfo;

  List<UpdateAvatarOption> updateAvatarOptionList = [
    UpdateAvatarOption(title: '拍照', source: ImageSource.camera),
    UpdateAvatarOption(title: '相册', source: ImageSource.gallery),
  ];

  // 修改头像
  Future<void> updateAvatar(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      String img = await CommonApis.uploadImage(image);
      Map form = {
        'avatar': img,
        "nickname": _userController.userInfo.value!.nickname
      };
      await UserApis.updateUserInfo(form);
      await _userController.fetchUserInfo();
      EasyLoading.showSuccess('修改成功!');
    }
  }

  // 文本控制器
  TextEditingController textController() => TextEditingController(
        text: userInfo.value != null
            ? userInfo.value!.nickname.isEmpty
                ? userInfo.value!.phoneNum
                : userInfo.value!.nickname
            : '',
      );

  Future<void> updateNickname(String nickname) async {
    if (nickname.isEmpty) {
    } else {
      Map form = {
        'avatar': _userController.userInfo.value!.avatar,
        "nickname": nickname
      };
      await UserApis.updateUserInfo(form);
      await _userController.fetchUserInfo();
      EasyLoading.showSuccess('修改成功!');
    }
  }

  // 确认销号
  RxBool isConfirmCancelAccount = false.obs;

  // 改变确认状态
  void changeConfirmCancelAccount() {
    isConfirmCancelAccount.value = !isConfirmCancelAccount.value;
  }

  RxBool isCancelAccountLoading = false.obs;

  // 销号
  Future<void> cancelAccount() async {
    isCancelAccountLoading.value = true;
    try {
      await UserApis.cancelAccount();
      EasyLoading.showSuccess('注销成功!');
      Utils.storage.remove('token');
      Get.offAllNamed(Routes.index);
    } finally {
      isCancelAccountLoading.value = false;
    }
  }
}
