import '/api/index.dart';
import 'package:get/get.dart';

class AgreementController extends GetxController with StateMixin<String> {
  RxString title = ''.obs;
  String text = '';

  @override
  onReady() {
    title.value = Get.arguments['title'] ?? '';
    Future.delayed(const Duration(milliseconds: 800), () async {
      try {
        Function() future = title.value == '隐私协议'
            ? CommonApis.fetchAgreetext
            : CommonApis.fetchAgreement;
        Map res = await future();
        text = res['text'];
      } finally {
        change(text, status: RxStatus.success());
      }
    });
  }
}
