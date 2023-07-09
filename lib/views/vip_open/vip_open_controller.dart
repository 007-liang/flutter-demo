import '/controllers/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';
import 'package:tobias/tobias.dart' as tobias;

class Pay {
  final String icon;
  final String label;
  Pay({required this.icon, required this.label});
}

class VipOpenController extends GetxController {
  RxInt isShowTip = 1.obs;

  // 套餐选项
  Rxn<List<Package>> packageList = Rxn(null);

  // 当前选择套餐
  Rxn<int> currentPackageIndex = Rxn(0);

  // 切换套餐
  void changePackageIndex(int index) => currentPackageIndex.value = index;

  // 支付方式
  List<Pay> payList = [
    // Pay(label: '微信支付', icon: 'assets/images/user/wechat_pay.png'),
    Pay(label: '支付宝支付', icon: 'assets/images/user/ali_pay.png'),
  ];

  // 当前选择支付方式
  Rxn<int> currentPayIndex = Rxn(0);

  // 切换支付方式
  void changePayIndex(int index) => currentPayIndex.value = index;

  // 按钮是否可用
  bool get isButtonUnable {
    return currentPackageIndex.value == null || currentPayIndex.value == null;
  }

  // 按钮加载
  RxBool isLoading = false.obs;

  // 购买/续费会员
  void handleSubmit() async {
    isLoading.value = true;
    try {
      var res = await UserApis.buyVip({
        'level_id': packageList.value![currentPackageIndex.value!].levelId,
      });

      var result = await tobias.aliPay(res);

      if (result['resultStatus'] == 6001) {
        EasyLoading.showInfo('用户已取消支付');
      }
      if (result['resultStatus'] == '9000') {
        UserController userController = Get.find<UserController>();
        EasyLoading.showSuccess('支付成功');
        await userController.fetchUserInfo();
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    CommonApis.fetchFunctionState(8).then((res) => isShowTip.value = res);
    UserApis.fetchPackageList().then((res) {
      List<Package> list =
          res.map<Package>((item) => Package.fromMap(item)).toList();
      packageList.value = list;
    });
  }
}
