import 'package:flutter/material.dart';
import '/controllers/index.dart';
import 'package:get/get.dart';
import '/router/index.dart';

class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware({int? priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    final UserController userController = Get.find<UserController>();
    return userController.userInfo.value != null
        ? null
        : RouteSettings(name: Routes.reload, arguments: {"redirect": route});
  }
}
