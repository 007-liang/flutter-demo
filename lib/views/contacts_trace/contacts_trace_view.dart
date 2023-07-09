import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../router/index.dart';
import '/utils/index.dart';
import '/model/index.dart';
import '/widget/contacts_list/contacts_list.dart';
import 'contacts_trace_controller.dart';

class ContactsTraceView extends GetView<ContactsTraceController> {
  const ContactsTraceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f5),
      appBar: AppBar(
        title: const Text('好友轨迹'),
        elevation: 1,
      ),
      body: Obx(() => EasyRefresh.custom(
              controller: controller.easyRefreshController,
              emptyWidget:
                  controller.contactsList.isEmpty ? emptyWidget(null) : null,
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
                      return contactsTraceWidget(item);
                    },
                    childCount: controller.contactsList.length,
                  ),
                ),
              ])),
    );
  }
}

Widget contactsTraceWidget(Contacts contacts) {
  return GestureDetector(
    onTap: () => contacts.canSee == 0
        ? EasyLoading.showInfo('对方已对你隐藏位置信息!')
        : checkIsVip(() => Get.toNamed(Routes.contactTraceDetail,
            arguments: {"contacts": jsonEncode(contacts)})),
    child: Container(
      padding: EdgeInsets.all(24.w),
      margin: EdgeInsets.only(
        top: 20.w,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(44.w),
                child: contacts.avatar == null || contacts.avatar.isEmpty
                    ? Image.asset(
                        'assets/images/user/avatar.png',
                        width: 88.w,
                        height: 88.w,
                      )
                    : Image.network(
                        contacts.avatar,
                        width: 88.w,
                        height: 88.w,
                      ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      contacts.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32.w,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff293033),
                      ),
                    ),
                    SizedBox(
                      height: 11.w,
                    ),
                    Text(
                      contacts.time == null
                          ? '暂无最新位置时间信息'
                          : '最新位置日期: ${contacts.time}',
                      style: TextStyle(
                        fontSize: 24.w,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff93979a),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffedeff2),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, size: 30.w, color: Colors.black38),
              SizedBox(width: 5.w),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '当前位置：',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 23.w,
                        ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Text(
                        contacts.address ?? '暂无最新位置',
                        style: TextStyle(fontSize: 23.w, height: 1.2),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}
