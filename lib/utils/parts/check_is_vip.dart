import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/api/index.dart';
import '/router/index.dart';

checkIsVip(Function callback) async {
  String result = await UserApis.checkIsVip({'id': '${8}'});
  if (result != '0') {
    callback();
  } else {
    EasyLoading.showInfo('请先开通会员!');
    Get.toNamed(Routes.vipOpen);
  }
}
