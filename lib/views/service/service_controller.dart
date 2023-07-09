import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';

class ServiceController extends GetxController with StateMixin<Config> {
  late Config config;

  void copy(String content) {
    ClipboardData data = ClipboardData(text: content);
    Clipboard.setData(data);
    EasyLoading.showToast('已复制');
  }

  @override
  Future<void> onReady() async {
    try {
      var res = await CommonApis.fetchConfig();
      config = Config.fromMap(res);
    } finally {
      change(config, status: RxStatus.success());
    }
  }
}
