import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/controllers/parts/notification_controller.dart';
import '/model/index.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: const Color(0xfff7f7f7),
        width: double.infinity,
        height: double.infinity,
      ),
      Stack(
        children: [
          Image.asset('assets/images/user/background.png'),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text('消息通知'),
              ),
              body: Obx(() => EasyRefresh.custom(
                    header: MaterialHeader(),
                    footer: MaterialFooter(),
                    controller: controller.easyRefreshController,
                    onRefresh: () => controller.fetchNoticeList(isRead: true),
                    firstRefresh: true,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Notice item = controller.noticeList[index];
                            return noticeWidget(item);
                          },
                          childCount: controller.noticeList.length,
                        ),
                      )
                    ],
                  )))
        ],
      )
    ]);
  }
}

Widget noticeWidget(Notice notice) {
  final controller = Get.find<NotificationController>();
  return Column(
    children: [
      // 时间
      Padding(
        padding: EdgeInsets.symmetric(vertical: 17.w),
        child: Text(
          notice.createTime,
          style: TextStyle(
            height: 1.5,
            fontSize: 22.w,
            color: const Color(0xff8c8c8c),
          ),
        ),
      ),
      // 卡片
      Container(
          padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 卡片上部分
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // 头像
                  Image.asset(
                    'assets/images/user/${notice.type == 1 ? 'avatar' : notice.type == 2 ? 'notification_help' : 'notification_safe'}.png',
                    width: 90.w,
                    height: 90.w,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  // 右侧
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.w,
                      ),
                      // 标题
                      Text(
                        notice.type == 1 ? '好友申请' : '求助信息',
                        style: TextStyle(fontSize: 30.w),
                      ),
                      // 求助信息
                      notice.type != 1
                          ? Padding(
                              padding: EdgeInsets.only(top: 5.w),
                              child: Text(
                                notice.type == 2
                                    ? '${notice.phone}正在向你求助!'
                                    : '${notice.phone}已脱离危险!',
                                style: TextStyle(
                                  color: notice.type == 2
                                      ? const Color(0xfff24c3d)
                                      : const Color(0xff2ba245),
                                  fontSize: 30.w,
                                ),
                              ),
                            )
                          : Container(),
                      // 好友提示和救援提示
                      Padding(
                        padding: EdgeInsets.only(top: 5.w, bottom: 30.w),
                        child: Text(
                          notice.type == 1
                              ? '${notice.phone} 请求加为好友'
                              : notice.type == 2
                                  ? 'TA可能遇到危险，请立即联系TA，若联系过程中发生任何异常，建议立即报警'
                                  : '请联系Ta，确认安全',
                          style: TextStyle(
                            color: const Color(0xff666666),
                            fontSize: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
              // 分割线
              const Divider(height: 1, color: Color(0xffd6d6d6)),
              // 卡片下部分
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: notice.type == 1 && notice.isAccept == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          noticeButtonWidget(
                            onPressed: () =>
                                controller.handleContactsApply(notice.id, 0),
                            color: 0xfff6f6f6,
                            label: '拒绝',
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          noticeButtonWidget(
                              onPressed: () =>
                                  controller.handleContactsApply(notice.id, 2),
                              color: 0xffff7600,
                              label: '确认',
                              textColor: Colors.white)
                        ],
                      )
                    : Text(
                        notice.isAccept == 1
                            ? ''
                            : notice.isAccept == 0
                                ? '已拒绝'
                                : '已同意',
                        style: TextStyle(
                            fontSize: 28.w, color: const Color(0xff999999)),
                      ),
              )
            ],
          ))
    ],
  );
}

Widget noticeButtonWidget(
    {required Function onPressed,
    required String label,
    required int color,
    Color? textColor}) {
  return MaterialButton(
    onPressed: () => onPressed(),
    height: 60.w,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.w
      ),
    ),
    minWidth: 120.w,
    elevation: 0,
    textColor: textColor,
    color: Color(color),
    child: Text(
      label,
    ),
  );
}
