import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lifecycle/lifecycle.dart';
import 'router/index.dart';

Future<void> init() async {
  AMapFlutterLocation.updatePrivacyShow(false, false);
  AMapFlutterLocation.updatePrivacyAgree(false);
  await GetStorage.init();
  await registerWxApi(appId: 'wx703343f24902ddd4');
}

void main() async {
  await init();
  runApp(const MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    //以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  EasyLoading.instance.displayDuration = const Duration(milliseconds: 1800);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (child) => GetMaterialApp(
          navigatorObservers: [defaultLifecycleObserver],
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent, //状态栏背景颜色
                      statusBarIconBrightness:
                          Brightness.dark // dark:一般显示黑色   light：一般显示白色
                      ),
                  elevation: 1,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  shadowColor: Color(0xffe6e6e6))),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.welcome,
          builder: EasyLoading.init(
            builder: (context, child) => child ?? Container(),
          ),
          defaultTransition: Transition.cupertinoDialog,
          getPages: Routes.pages,
        ),
      ),
    );
  }
}
