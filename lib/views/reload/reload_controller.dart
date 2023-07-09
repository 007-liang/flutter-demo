
import 'package:get/get.dart';

class ReloadController extends GetxController {
   late String redirect;

   @override
  void onReady() {
    redirect = Get.arguments['redirect'];
  } 
}