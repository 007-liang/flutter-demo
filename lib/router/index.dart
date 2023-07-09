import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/middlewares/routh_auth.dart';
import '/views/question_detail/question_detail_view.dart';
import '/views/question_detail/question_detail_controller.dart';
import '/views/question/question_view.dart';
import '/views/question/question_controller.dart';
import '/views/service/service_view.dart';
import '/views/service/service_controller.dart';
import '/views/agreement/agreement_view.dart';
import '/views/agreement/agreement_controller.dart';
import '/views/permission/permission_view.dart';
import '/views/permission/permission_controller.dart';
import '/views/setting/setting_controller.dart';
import '/views/setting/setting_view.dart';
import '/views/vip_open/vip_open_view.dart';
import '/views/vip_open/vip_open_controller.dart';
import '/views/notification/notification_view.dart';
import '/views/contacts_setting/contacts_setting_view.dart';
import '/views/contacts_setting/contacts_setting_controller.dart';
import '/views/contacts_add/contacts_add_view.dart';
import '/views/contacts_add/contacts_add_controller.dart';
import '/views/contacts_trace_detail/contacts_trace_detail_view.dart';
import '/views/contacts_trace_detail/contacts_trace_detail_controller.dart';
import '/views/contacts_trace/contacts_trace_view.dart';
import '/views/contacts_trace/contacts_trace_controller.dart';
import '/views/reload/reload_view.dart';
import '/views/reload/reload_controller.dart';
import '/views/password_update/password_update_controller.dart';
import '/views/password_update/password_update_view.dart';
import '/views/login_code/login_code_view.dart';
import '/views/login_code/login_code_controller.dart';
import '/views/login/login_view.dart';
import '/views/login/login_controller.dart';
import '/views/index/index_view.dart';
import '/views/index/index_controller.dart';
import '/views/welcome/welcome_view.dart';
import '/views/welcome/welcome_controller.dart';

abstract class Routes {
  static const questionDetail = '/questionDetail';
  static const question = '/question';
  static const service = '/service';
  static const agreement = '/agreement';
  static const permission = '/permission';
  static const setting = '/setting';
  static const vipOpen = '/vip_open';
  static const notification = '/notification';
  static const contactsSetting = '/contactsSetting';
  static const contactsAdd = '/contactsAdd';
  static const contactTraceDetail = '/contactTraceDetail';
  static const contactTrace = '/contactTrace';
  static const passwordUpdate = '/passwordUpdate';
  static const loginCode = '/loginCode';
  static const login = '/login';
  static const index = '/index';
  static const welcome = '/welcome';
  static const reload = '/reload';
  static const auth = '/';

  static final pages = [
    // 需要登录
    GetPage(name: auth, page: () => Container(), middlewares: [
      RouteAuthMiddleware(priority: 1)
    ], children: [
      // 常见问题列表
      GetPage(
          name: question,
          page: () => const QuestionView(),
          binding:
              BindingsBuilder(() => Get.lazyPut(() => QuestionController())),
          children: [
            // 常见问题详情
            GetPage(
              name: questionDetail,
              page: () => const QuestionDetailView(),
              binding: BindingsBuilder(
                  () => Get.lazyPut(() => QuestionDetailController())),
            ),
          ]),
      // 设置
      GetPage(
        name: setting,
        page: () => const SettingView(),
        binding: BindingsBuilder(() => Get.lazyPut(() => SettingController())),
      ),
      // 开通会员
      GetPage(
        name: vipOpen,
        page: () => VipOpenView(),
        binding: BindingsBuilder(() => Get.lazyPut(() => VipOpenController())),
      ),
      // 通知
      GetPage(
        name: notification,
        page: () => const NotificationView(),
      ),
      // 联系人设置
      GetPage(
        name: contactsSetting,
        page: () => const ContactsSettingView(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => ContactsSettingController())),
      ),
      // 添加联系人
      GetPage(
        name: contactsAdd,
        page: () => const ContactsAddView(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => ContactsAddController())),
      ),
      // 联系人轨迹详情
      GetPage(
          name: contactTraceDetail,
          page: () => const ContactsTraceDetailView(),
          binding: BindingsBuilder(
              () => Get.lazyPut(() => ContactsTraceDetailController()))),
      // 联系人轨迹
      GetPage(
          name: contactTrace,
          page: () => const ContactsTraceView(),
          binding: BindingsBuilder(
              () => Get.lazyPut(() => ContactsTraceController()))),
    ]),

    // 重新加载
    GetPage(
        name: reload,
        page: () => const ReloadView(),
        binding: BindingsBuilder(
          () => Get.put<ReloadController>(ReloadController()),
        ),
        transition: Transition.noTransition,
        transitionDuration: Duration.zero),

    // 客服
    GetPage(
      name: service,
      page: () => const ServiceView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ServiceController())),
    ),

    // 权限
    GetPage(
      name: permission,
      page: () => const PermissionView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PermissionController())),
    ),

    // 隐私协议
    GetPage(
      name: agreement,
      page: () => const AgreementView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AgreementController())),
    ),

    // 忘记/修改 密码
    GetPage(
      name: passwordUpdate,
      page: () => const PasswordUpdateView(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => PasswordUpdateController())),
    ),

    // 登录
    GetPage(
        name: login,
        page: () => const LoginView(),
        binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
        children: [
          // 验证码登录
          GetPage(
            name: loginCode,
            page: () => const LoginCodeView(),
            binding:
                BindingsBuilder(() => Get.lazyPut(() => LoginCodeController())),
          ),
        ]),

    // 首页
    GetPage(
      name: index,
      page: () => const IndexView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => IndexController())),
    ),

    // 欢迎页
    GetPage(
      name: welcome,
      page: () => const WelcomeView(),
      binding: BindingsBuilder(
          () => Get.put<WelcomeController>(WelcomeController())),
      transition: Transition.fade,
    )
  ];
}
