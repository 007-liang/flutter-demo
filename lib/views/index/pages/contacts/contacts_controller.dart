import '/controllers/parts/notification_controller.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';

class ContactsController extends GetxController {
  final NotificationController notificationController = Get.find<NotificationController>();

  EasyRefreshController easyRefreshController = EasyRefreshController();
  
  RxBool isFirstLoad = true.obs;

  // 联系人列表
  RxList<Contacts> contactsList = <Contacts>[].obs;

  // 获取联系人列表
  Future<void> fetchContactsList() async {
    isFirstLoad.value = false;
    return await ContactsApis.fetchContactsList({
      "page": '1',
      "limit": '99999',
    })
        .then(((res) => {
              contactsList.value =
                  res.map<Contacts>((item) => Contacts.fromMap(item)).toList()
            }))
        .catchError((e) => easyRefreshController.finishRefreshCallBack!());
  }
}
