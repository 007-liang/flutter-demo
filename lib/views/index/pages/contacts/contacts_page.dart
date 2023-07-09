import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/widget/contacts_list/contacts_list.dart';
import '/widget/reload/reload.dart';
import '/utils/index.dart';
import '/controllers/index.dart';
import '/router/index.dart';
import 'contacts_controller.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final ContactsController _contactsController = Get.put(ContactsController());
  final UserController _userController = Get.find<UserController>();
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  void dispose() {
    super.dispose();
    Get.delete<ContactsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_userController.userInfo.value == null) {
        return const Reload(tip: '登录后查看好友列表');
      } else {
        notificationController.fetchNoticeList();
        return lifecycleWrapper(() {
          if (!_contactsController.isFirstLoad.value) {
            _contactsController.easyRefreshController.callRefresh();
          }
        },
            Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text('好友列表'),
                  actions: [
                    Center(
                      child: Ink(
                          height: 64.w,
                          width: 64.w,
                          decoration: BoxDecoration(
                              color: const Color(0xfff6f6f6),
                              borderRadius: BorderRadius.circular(100)),
                          child: Stack(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/common/alert.png',
                                  width: 28.w,
                                  height: 32.w,
                                )),
                                onTap: () => Get.toNamed(Routes.notification),
                              ),
                              Offstage(
                                offstage:
                                    notificationController.count.value == 0,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffff3b30),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Center(
                      child: Ink(
                        height: 64.w,
                        width: 64.w,
                        decoration: BoxDecoration(
                          color: const Color(0xfff6f6f6),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(100),
                          child: Center(
                              child: Image.asset(
                            'assets/images/index/contacts/add_contacts.png',
                            width: 28.w,
                            height: 32.w,
                          )),
                          onTap: () => checkIsVip(()=> Get.toNamed(Routes.contactsAdd)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    )
                  ],
                ),
                body: ContactsList(
                  controller: _contactsController,
                )));
      }
    });
  }
}
