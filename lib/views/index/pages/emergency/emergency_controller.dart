import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';
import '/controllers/index.dart';
import '../contacts/contacts_controller.dart';

class EmergencyController extends ContactsController {
  final UserController userController = Get.find<UserController>();

  // 获取联系人列表
  @override
  Future<void> fetchContactsList() async {
    isFirstLoad.value = false;
    return await ContactsApis.fetchContactsList(
            {"page": "1", "limit": "999999", "is_emergency": "1"})
        .then(((res) => {
              contactsList.value =
                  res.map<Contacts>((item) => Contacts.fromMap(item)).toList()
            }))
        .catchError((e) => easyRefreshController.finishRefreshCallBack!());
  }

  // 更新紧急状态
  updateEmergencyState() async {
    Get.back();
    await UserApis.updateEmergencyState({
      "is_emergency": userController.userInfo.value?.isEmergency == 0 ? 1 : 0
    });
    userController.fetchUserInfo();
  }
}
