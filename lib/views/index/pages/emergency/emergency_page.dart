import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/router/index.dart';
import '/widget/reload/reload.dart';
import '/controllers/index.dart';
import '/utils/index.dart';
import '/widget/contacts_list/contacts_list.dart';
import 'emergency_controller.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  final EmergencyController _emergencyControlle =
      Get.put(EmergencyController());
  final UserController _userController = Get.find<UserController>();

  @override
  void dispose() {
    super.dispose();
    Get.delete<EmergencyController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _userController.userInfo.value == null
        ? const Reload(tip: '登录后使用紧急功能')
        : lifecycleWrapper(() {
            if (!_emergencyControlle.isFirstLoad.value) {
              _emergencyControlle.easyRefreshController.callRefresh();
            }
          },
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  '紧急求助',
                ),
              ),
              body: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40.w, bottom: 50.w),
                            child: Center(
                              child: Image.asset(
                                'assets/images/index/emergency/emergency.png',
                                width: 180.w,
                                height: 160.w,
                              ),
                            ),
                          ),
                          Text(
                            '发送紧急求救',
                            style: TextStyle(
                              fontSize: 42.w,
                            ),
                          ),
                          Text(
                            '遇到紧急情况，发送求助信息给您的紧急联系人(可多位)。您的联系人将会受到短信以及app消息。',
                            style: TextStyle(
                              fontSize: 30.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.w),
                            child: Obx(() => MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  disabledColor: const Color(0xffededed),
                                  textColor: Colors.white,
                                  height: 90.w,
                                  minWidth: double.infinity,
                                  color: Color(_userController
                                              .userInfo.value?.isEmergency ==
                                          0
                                      ? 0xfff24c3d
                                      : 0xff1ccfad),
                                  onPressed: _emergencyControlle
                                          .contactsList.isEmpty
                                      ? null
                                      : () => checkIsVip(() =>
                                          CustomDialog.show(
                                              tipChildren: [
                                                Text(
                                                  _userController.userInfo.value
                                                              ?.isEmergency ==
                                                          0
                                                      ? '是否向所有紧急联系人发出求助'
                                                      : '请确认是否脱离危险',
                                                  style: TextStyle(
                                                      fontSize: 28.w,
                                                      color: const Color(
                                                          0xff666666)),
                                                )
                                              ],
                                              title:
                                                  '确认${_userController.userInfo.value?.isEmergency == 0 ? '求助' : '安全'}',
                                              confirmTitle: _userController
                                                          .userInfo
                                                          .value
                                                          ?.isEmergency ==
                                                      0
                                                  ? '确认'
                                                  : '我已安全',
                                              onPressed: () =>
                                                  _emergencyControlle
                                                      .updateEmergencyState())),
                                  child: Text(
                                    _userController
                                                .userInfo.value?.isEmergency ==
                                            0
                                        ? 'SOS发出求助'
                                        : '我已安全',
                                    style: TextStyle(fontSize: 30.w),
                                  ),
                                )),
                          )
                        ],
                      )),

                  // 分割
                  Container(
                    height: 16.w,
                    color: const Color(0xfff7f6f5),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.w,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 32.w, right: 15.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '紧急联系人',
                                    style: TextStyle(
                                      fontSize: 32.w,
                                      color: const Color(0xff293033),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () => checkIsVip(() =>
                                          Get.toNamed(Routes.contactsAdd,
                                              arguments: {"isEmergency": 1})),
                                      child: const Text(
                                        '添加紧急联系人',
                                        style:
                                            TextStyle(color: Color(0xff6a7fa5)),
                                      ))
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: ContactsList(
                                  controller: _emergencyControlle,
                                  isEmergency: 1))
                        ],
                      )),
                ],
              ),
            )));
  }
}
