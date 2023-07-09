import 'package:flutter/material.dart';
import '/utils/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/controllers/index.dart';
import '/api/index.dart';
import '/model/index.dart';

class NotificationController extends GetxController {
  final GlobalDataController globalDataController =
      Get.find<GlobalDataController>();

  EasyRefreshController easyRefreshController = EasyRefreshController();

  RxInt count = 0.obs;

  // 通知列表
  RxList<Notice> noticeList = <Notice>[].obs;

  // 获取联系人列表
  Future<void> fetchNoticeList({bool isRead = false}) async {
    String token = globalDataController.token.value ?? '';
    if (token.isNotEmpty) {
      return await UserApis.fetchNoticeList({"read": "${isRead ? 1 : 0}"})
          .then(((res) {
        count.value = isRead ? 0 : res['count'];
        noticeList.value =
            res['list'].map<Notice>((item) => Notice.fromMap(item)).toList();
      })).catchError((e) => easyRefreshController.finishRefreshCallBack!());
    } else {
      return;
    }
  }

  // 清除
  void clear() {
    count.value = 0;
    noticeList.value = <Notice>[];
  }

  // 处理好友申请
  void handleContactsApply(int noticeId, status) {
    CustomDialog.show(
        tipChildren: [
          Text('是否确认${status == 0 ? '拒绝' : '同意' }申请'),
                  Text('添加好友以后对方也可以查询您的位置',style:TextStyle(color: Colors.black45, fontSize: 24.w, height: 2))
        ],
        title: '提示',
        onPressed: () async {
          await ContactsApis.hanlderApply({"id": noticeId, "status": status});
          Get.back();
          easyRefreshController.callRefresh();
        });
  }
}
