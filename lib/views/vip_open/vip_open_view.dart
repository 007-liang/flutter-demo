import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/router/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/model/index.dart';
import '/controllers/index.dart';
import '/widget/vip_privilege/vip_privilege.dart';
import 'vip_open_controller.dart';

class VipOpenView extends GetView<VipOpenController> {
  VipOpenView({Key? key}) : super(key: key);
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffefc),
      appBar: AppBar(
        title: const Text('开通会员'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                child: Column(
              children: [
                // 用户信息
                Container(
                  padding: EdgeInsets.all(41.w),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xff38322d),
                    Color(0xff2d2828),
                    Color(0xff211e23)
                  ])),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _userController
                                      .userInfo.value!.nickname.isNotEmpty
                                  ? _userController.userInfo.value!.nickname
                                  : _userController.userInfo.value!.phoneNum,
                              style: TextStyle(
                                  color: const Color(0xffe8d5a5),
                                  fontSize: 36.w,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                                _userController.userInfo.value != null &&
                                        _userController
                                                .userInfo.value!.vipmember !=
                                            0
                                    ? 'vip到期时间:${_userController.userInfo.value!.endtime}'
                                    : '未开通会员',
                                style: TextStyle(
                                    color: const Color(0xff978569),
                                    fontSize: 24.w)),
                          ],
                        ),
                        ClipOval(
                          child: _userController.userInfo.value!.avatar.isEmpty
                              ? Image.asset(
                                  'assets/images/user/avatar.png',
                                  width: 86.w,
                                  height: 86.w,
                                )
                              : Image.network(
                                  _userController.userInfo.value!.avatar,
                                  fit: BoxFit.cover,
                                  width: 86.w,
                                  height: 86.w,
                                ),
                        )
                      ]),
                ),
                // 会员特权
                VipPrivilege(),
                // 套餐选择
                Obx(() => package(controller)),
                // 是否自动续费
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 50.w, bottom: 34.w, left: 24.w),
                  child: Text('支付方式',
                      style: TextStyle(
                          color: const Color(0xff1e1e1e),
                          fontSize: 30.w,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xffe6e6e6)),
                // 支付方式
                pay(controller),
                SizedBox(height: 40.w),
                // 提示
                DefaultTextStyle(
                    style: const TextStyle(color: Color(0xff6a6a75), height: 1),
                    child: Column(
                      children: [
                        Text(
                          '*本产品为虚拟内容服务，开通后将无法退款请您理解',
                          style: TextStyle(
                            fontSize: 20.w,
                          ),
                        ),
                      Obx(()=> controller.isShowTip.value == 1 ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Text(
                            '本软件需双方下载授权才能定位分享。',
                            style: TextStyle(
                              fontSize: 20.w,
                            ),
                          ),
                        ) : SizedBox(height: 15.w,),),
                        Text.rich(
                          TextSpan(children: [
                            const TextSpan(text: '注：点击立即开通视为您已阅读并同意'),
                            TextSpan(
                              style: const TextStyle(
                                color: Color(0xff8DBFFC),
                              ),
                              text: '《服务协议》',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(Routes.agreement,
                                    arguments: {'title': '服务协议'}),
                            ),
                            TextSpan(
                              style: const TextStyle(
                                color: Color(0xff8DBFFC),
                              ),
                              text: '《隐私协议》',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(Routes.agreement,
                                    arguments: {'title': '隐私协议'}),
                            ),
                          ]),
                          style: TextStyle(
                            fontSize: 20.w,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                      ],
                    ))
              ],
            )),
          ),
          // 立即开通
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
            height: 90.w,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF38322d),
                  Color(0xFF2d2828),
                  Color(0xFF211e23),
                ]), // 渐变色
                borderRadius: BorderRadius.circular(20.w)),
            child: Obx(() => MaterialButton(
                  disabledTextColor: Colors.white,
                  disabledColor: const Color.fromARGB(255, 171, 171, 171),
                  padding: EdgeInsets.only(left: 25.w, right: 5.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  height: 64.w,
                  // minWidth: 156.w,
                  onPressed: controller.isButtonUnable
                      ? null
                      : () => controller.handleSubmit(),
                  child: controller.isLoading.value
                      ? Container(
                          height: 94.w,
                          width: 94.w,
                          padding: EdgeInsets.all(20.w),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _userController.userInfo.value!.vipmember == 0
                              ? '立即开通'
                              : '续费会员',
                          style: TextStyle(
                              fontSize: 36.w, color: const Color(0xfffbeac7)),
                        ),
                )),
          ),
        ],
      ),
    );
  }
}

// 套餐选择
Widget package(VipOpenController memberOpenController) =>
    memberOpenController.packageList.value != null
        ? Column(children: [
            ...List.generate(memberOpenController.packageList.value!.length,
                (index) {
              Package item = memberOpenController.packageList.value![index];
              return GestureDetector(
                onTap: () => memberOpenController.changePackageIndex(index),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 58.w),
                  margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: index ==
                              memberOpenController.currentPackageIndex.value
                          ? [
                              const Color(0xfffceec8),
                              const Color(0xfff9e5ab),
                              const Color(0xfff5db8d),
                            ]
                          : [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                        color: index ==
                                memberOpenController.currentPackageIndex.value
                            ? Colors.transparent
                            : const Color(0xFFe1e1e1),
                        width: 1.w), // border
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        item.goodName,
                        style: TextStyle(
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold,
                          color: index ==
                                  memberOpenController.currentPackageIndex.value
                              ? const Color(0xff4e310d)
                              : const Color(0xff222222),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text.rich(TextSpan(
                          style: TextStyle(
                              color: index ==
                                      memberOpenController
                                          .currentPackageIndex.value
                                  ? const Color(0xff4e310d)
                                  : const Color(0xffc8963a),
                              fontSize: 36.w,
                              fontWeight: FontWeight.bold,
                              height: 1),
                          children: [
                            const TextSpan(text: '￥'),
                            TextSpan(
                                text: item.goodPrice,
                                style: TextStyle(fontSize: 67.w)),
                          ])),
                      Text(
                        '￥${item.originalPrice}',
                        style: TextStyle(
                          fontSize: 38.w,
                          color: index ==
                                  memberOpenController.currentPackageIndex.value
                              ? const Color(0xffc0ad76)
                              : const Color(0xff999999),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '立省${double.parse(item.originalPrice) - double.parse(item.goodPrice)}元',
                        style: TextStyle(
                          fontSize: 26.w,
                          color: const Color(0xff483123),
                        ),
                      ),
                      SizedBox(height: 40.w),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(width: 24.w)
          ])
        : Container();

// 支付方式
Widget pay(VipOpenController memberOpenController) => Column(
      children: [
        ...List.generate(memberOpenController.payList.length, (index) {
          Pay item = memberOpenController.payList[index];
          return Ink(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              color: Colors.white,
              child: InkWell(
                  onTap: () => memberOpenController.changePayIndex(index),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 32.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Image.asset(
                                item.icon,
                                width: 44.w,
                              ),
                            ),
                            Text(
                              item.label,
                              style: TextStyle(
                                  color: const Color(0xff262626),
                                  fontSize: 30.w),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 30.w),
                                      child: Obx(() => Image.asset(
                                            'assets/images/common/${index == memberOpenController.currentPayIndex.value ? 'checkbox_active' : 'checkbox'}.png',
                                            width: 40.w,
                                          ))),
                                ))
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xffc6c6c6))
                    ],
                  )));
        })
      ],
    );
