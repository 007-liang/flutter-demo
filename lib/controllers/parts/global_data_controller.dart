import 'package:get/get.dart';
import '/utils/index.dart';
// ignore: depend_on_referenced_packages
import 'package:amap_flutter_base/amap_flutter_base.dart';

class GlobalDataController extends GetxController {
  static String baseUrl = 'http://47.104.182.83:82/api/';

  static const AMapApiKey amapApiKeys = AMapApiKey(
    androidKey: 'e1524d2da3c1f95f9db0cf7ca2edc2ca',
  );
  
  RxnString token = RxnString('');

  // 更新token
  void updateToken(String? value) {
    token.value = value;
  }

  @override
  void onReady() {
    token.value = Utils.storage.read('token');
  }
}
