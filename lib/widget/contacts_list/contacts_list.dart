import 'dart:convert';
import 'package:flutter/material.dart';
import '/views/index/pages/emergency/emergency_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../api/index.dart';
import '/views/index/pages/contacts/contacts_controller.dart';
import '/utils/index.dart';
import '/model/index.dart';
import '/router/index.dart';

class ContactsList extends StatelessWidget {
  final ContactsController controller;
  final int? isEmergency;
  const ContactsList({Key? key, required this.controller, this.isEmergency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SlidableAutoCloseBehavior(
            child: EasyRefresh.custom(
                controller: controller.easyRefreshController,
                emptyWidget: controller.contactsList.isEmpty
                    ? emptyWidget(isEmergency)
                    : null,
                header: MaterialHeader(),
                footer: MaterialFooter(),
                firstRefresh: true,
                onRefresh: () async {
                  await controller.fetchContactsList();
                },
                slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Contacts item = controller.contactsList[index];
                    return contactsWidget(item, isEmergency);
                  },
                  childCount: controller.contactsList.length,
                ),
              ),
            ])));
  }
}

// 联系人
Widget contactsWidget(Contacts contacts, int? isEmergency) {
  return Slidable(
      enabled: isEmergency == 1,
      key: Key(contacts.id.toString()),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => CustomDialog.show(
                    tipChildren: [
                      Text(
                        '是否将 ${contacts.nickname} 移出紧急联系人',
                      )
                    ],
                    title: '提醒',
                    onPressed: () async {
                      EmergencyController emergencyController =
                          Get.find<EmergencyController>();
                      await ContactsApis.updateContacts({
                        "id": contacts.id,
                        "is_emergency": 0,
                        "is_hidden": contacts.isHidden,
                      });
                      Get.back();
                      emergencyController.easyRefreshController.callRefresh();
                    }),
                child: Container(
                  height: double.infinity,
                  color: const Color(0xff5856d6),
                  child: Center(
                      child: Text(
                    '移出',
                    style: TextStyle(color: Colors.white, fontSize: 30.w),
                  )),
                ),
              ))
        ],
      ),
      child: Ink(
        padding: EdgeInsets.only(bottom: 15.w),
        child: InkWell(
          onTap: () => contacts.canSee == 0
              ? EasyLoading.showInfo('对方已对你隐藏位置信息!')
              : checkIsVip(() => Get.toNamed(Routes.contactTraceDetail,
                  arguments: {"contacts": jsonEncode(contacts)})),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.w),
              child: Row(children: [
                ClipOval(
                  child: contacts.avatar != null
                      ? Image.network(
                          contacts.avatar,
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/user/avatar.png',
                          width: 100.w,
                          height: 100.w,
                        ),
                ),
                SizedBox(
                  width: 22.w,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contacts.nickname,
                          style: TextStyle(
                              fontSize: 30.w, color: const Color(0xff1e1e1e)),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Text(
                          contacts.time == null || contacts.time!.isEmpty
                              ? '暂无最新位置'
                              : '最新位置日期: ${contacts.time}',
                          style: TextStyle(
                              fontSize: 24.w, color: const Color(0xff999999)),
                        )
                      ]),
                ),
                IconButton(
                    onPressed: () => Get.toNamed(Routes.contactsSetting,
                        arguments: {'contacts': jsonEncode(contacts)}),
                    icon: Icon(
                      Icons.settings,
                      size: 40.w,
                    ))
              ])),
        ),
      ));
}

// 空白
Widget emptyWidget(int? isEmergency) {
  return Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/index/contacts/empty.png'),
      Transform.translate(
        offset: Offset(0.0, -80.w.toDouble()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '暂无${isEmergency == null ? '好友' : '紧急联系人'}',
              style: TextStyle(color: const Color(0xff1e1e1e), fontSize: 30.w),
            ),
            SizedBox(
              height: 10.w,
            ),
            isEmergency == null
                ? Text('添加好友关注ta的动态吧',
                    style: TextStyle(
                        color: const Color(0xff999999), fontSize: 24.w))
                : Column(
                    children: [
                      Text('至少添加一名紧急联系人',
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 24.w)),
                      Text('才能使用该功能哦',
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: 24.w))
                    ],
                  ),
            SizedBox(
              height: 59.w,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.w),
                ),
                disabledTextColor: Colors.white,
                disabledColor: const Color.fromRGBO(255, 118, 0, 0.4),
                height: 94.w,
                minWidth: 600.w,
                color: const Color(0xffff7600),
                onPressed: () => checkIsVip(() {
                      if (isEmergency == null) {
                        Get.toNamed(Routes.contactsAdd);
                      } else {
                        Get.toNamed(Routes.contactsAdd,
                            arguments: {"isEmergency": 1});
                      }
                    }),
                child: Text(
                  '添加${isEmergency == null ? '好友' : '紧急联系人'}',
                  style: TextStyle(fontSize: 28.w, color: Colors.white),
                )),
          ],
        ),
      )
    ]),
  );
}
