import 'package:flutter/material.dart';
import '/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import '/controllers/index.dart';
import '/widget/vip_privilege/vip_privilege.dart';
import '/router/index.dart';
import '/widget/cell/cell.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();
  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    notificationController.fetchNoticeList();
    userController.fetchUserFunctionState();
    return  SingleChildScrollView(
          child: Obx(() => Stack(children: [
            Image.asset('assets/images/user/background.png'),
            Column(
              children: [
                AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      // 信息
                      Center(
                        child: Ink(
                            height: 64.w,
                            width: 64.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
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
                                    ))
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 30.w,
                      )
                    ]),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(children: [
                    // 头像
                    SizedBox(
                        width: 108.w,
                        height: 108.w,
                        child: userController.userInfo.value != null &&
                                userController.userInfo.value!.avatar.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  userController.userInfo.value!.avatar,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset('assets/images/user/avatar.png')),
                    SizedBox(width: 20.w),
                    // 用户信息
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => userController.toLogin(),
                          child: Text(
                            userController.userInfo.value != null
                                ? userController
                                        .userInfo.value!.nickname.isEmpty
                                    ? userController.userInfo.value!.phoneNum
                                    : userController.userInfo.value!.nickname
                                : '登录',
                            style: TextStyle(
                                fontSize: 40.w, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text(
                          userController.userInfo.value != null &&
                                  userController.userInfo.value!.vipmember != 0
                              ? 'vip到期时间:${userController.userInfo.value!.endtime}'
                              : '未开通会员',
                          style: TextStyle(
                              letterSpacing: -0.5.w,
                              fontSize: 26.w,
                              color: const Color(0xff413931)),
                        )
                      ],
                    ),
                  ]),
                ),
                userController.vipOpenFucntionState.value == 1 ? Column(
                    children: [
                      SizedBox(height: 40.w),
                      // 会员
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: SizedBox(
                          height: 154.w,
                          child: Stack(children: [
                            Image.asset('assets/images/user/vip.png'),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 47.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // 会员左
                                  Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/images/user/vip_icon.png',
                                            height: 34.w),
                                        SizedBox(height: 10.w),
                                        Text(
                                          '开通会员 · 平台服务通用',
                                          style: TextStyle(
                                              color: const Color(0xffd1c4b6),
                                              fontSize: 24.w.toDouble()),
                                        ),
                                      ]),
                                  // 会员右
                                  Center(
                                      child: Container(
                                    height: 64.w,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color(0xFFfdeeac),
                                          Color(0xFFc4a662)
                                        ]), // 渐变色
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: MaterialButton(
                                        splashColor: const Color.fromARGB(
                                            255, 184, 157, 95),
                                        padding: EdgeInsets.only(
                                            left: 25.w, right: 15.w),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        height: 64.w,
                                        // minWidth: 156.w,
                                        onPressed: () =>
                                            Get.toNamed(Routes.vipOpen),
                                        child: Row(
                                          children: [
                                            Text(
                                             userController.userInfo.value == null ||  userController.userInfo.value
                                                          ?.vipmember ==
                                                      0
                                                  ? '立即开通'
                                                  : '续费会员',
                                              style: TextStyle(
                                                  fontSize: 28.w,
                                                  color:
                                                      const Color(0xff573328)),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 25.w,
                                              color: const Color(0xff573328),
                                            )
                                          ],
                                        )),
                                  ))
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                      // 会员
                      Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFfaf9f5), Color(0xFFffffff)]),
                          ),
                          child: VipPrivilege())
                      // 设置
                      ,
                    ],
                  ) : Container(),
                SizedBox(
                  height: 21.w,
                ),
                Cell(
                    suffixIcon: 'assets/images/user/setting.png',
                    label: '设置',
                    content: Text('更换头像、权限、退出在这里',
                        style: TextStyle(
                            color: const Color(0xff999999), fontSize: 26.w)),
                    border: false,
                    onTap: () => Get.toNamed(Routes.setting)),
                userController.vipTrial.value == 1 ? Padding(
                    padding: EdgeInsets.only(top: 21.w),
                    child: Cell(
                        suffixIcon: 'assets/images/user/test.png',
                        label: '会员试用',
                        border: false,
                        onTap: () => vipShip()),
                  ) : Container(),
                // Offstage(
                //   offstage: 
                //   child: 
                // ),
                SizedBox(
                  height: 21.w,
                ),
                Cell(
                  suffixIcon: 'assets/images/user/share_friend.png',
                  label: '分享好友',
                  onTap: () => shareToWeChat(
                    WeChatShareWebPageModel(
                      'http://apptest.quguonet.com/nkuw',
                      title: '手机定位迹寻app下载',
                      thumbnail: WeChatImage.asset('assets/images/welcome.png'),
                      scene: WeChatScene.SESSION,
                    ),
                  ),
                ),
                Cell(
                  suffixIcon: 'assets/images/user/service.png',
                  label: '联系客服',
                  onTap: () => Get.toNamed(Routes.service),
                ),
                Cell(
                  suffixIcon: 'assets/images/user/problem.png',
                  label: '常见问题',
                  onTap: () => Get.toNamed(Routes.question),
                ),
                SizedBox(
                  height: 32.w,
                ),
                Ink(
                  width: double.infinity,
                  color: Colors.white,
                  height: 120.w,
                  child: InkWell(
                      onTap: () => userController.userInfo.value == null
                          ? userController.toLogin()
                          : userController.logout(),
                      child: Center(
                        child: Obx(
                          () => Text(
                            userController.userInfo.value != null
                                ? '退出登录'
                                : '登录',
                            style: TextStyle(
                                fontSize: 32.w, color: const Color(0xffff3b30)),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 30.w),
              ],
            ),
          ]),
        ));
  }
}

void vipShip() {
  final UserController userController = Get.find<UserController>();
  checkIsLogin(() => Get.dialog(
        Transform.translate(
          offset: Offset(0, -0.1.sh),
          child: Center(
            child: SizedBox(
              width: 600.w,
              child: Stack(
                children: [
                  Image.asset('assets/images/user/vip_dialog.png'),
                  Positioned(
                      width: 600.w,
                      bottom: 175.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '可免费领取会员VIP一天，',
                            style: TextStyle(
                              fontSize: 28.w,
                              color: const Color(0xff666666),
                            ),
                          ),
                          Text(
                            '享用4大特权，是否领取？',
                            style: TextStyle(
                              fontSize: 28.w,
                              color: const Color(0xff666666),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      width: 600.w,
                      bottom: 50.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                elevation: 0,
                                color: const Color(0xfff3f5f7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.w),
                                ),
                                minWidth: 250.w,
                                height: 88.w,
                                // minWidth: 156.w,
                                onPressed: () => Get.back(),
                                child: Text(
                                  '下次再说',
                                  style: TextStyle(
                                      fontSize: 32.w,
                                      color: const Color(0xff999999)),
                                )),
                            Container(
                              height: 88.w,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFFecddc9),
                                    Color(0xFFd0a787)
                                  ]), // 渐变色
                                  borderRadius: BorderRadius.circular(12.w)),
                              child: MaterialButton(
                                minWidth: 250.w,
                                height: 88.w,
                                splashColor:
                                    const Color.fromARGB(255, 184, 157, 95),
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 15.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.w),
                                ),
                                onPressed: () => userController.prime(),
                                child: Text(
                                  '领取会员',
                                  style: TextStyle(
                                      fontSize: 32.w,
                                      color: const Color(0xff563c2a)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ));
}
