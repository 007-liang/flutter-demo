import 'dart:async';
import 'package:flutter/material.dart';
import '/controllers/index.dart';
import '/model/index.dart';
import 'package:get/get.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
// ignore: depend_on_referenced_packages
import 'package:amap_flutter_base/amap_flutter_base.dart';

class HomeController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final GlobalDataController globalDataController =
      Get.find<GlobalDataController>();
  AMapPrivacyStatement amapPrivacyStatement = const AMapPrivacyStatement(
      hasContains: true, hasShow: true, hasAgree: true);

  UserInfo? get userInfo {
    return userController.userInfo.value;
  }

  // 地图组件
  Rxn<AMapWidget> mapWidget = Rxn(null);
  AMapController? mapController;
  StreamSubscription? locationListener;
  late AMapFlutterLocation locationPlugin;

  void mapCreated(AMapController controller) {
    mapController = controller;
    locationListener = locationPlugin.onLocationChanged().listen((result) {
      dynamic latitude = result['latitude'];
      dynamic longitude = result['longitude'];
      if (latitude is double && longitude is double) {
        mapController?.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              //中心点
              target: LatLng(latitude, longitude),
              //缩放级别
              zoom: 18,
            ),
          ),
          animated: true,
        );
      }
    });
    locationPlugin.setLocationOption(AMapLocationOption(onceLocation: true));
    locationPlugin.stopLocation();
  }

  // 开始定位
  void startLocation() {
    locationPlugin.startLocation();
  }

  @override
  void onClose() {
    locationListener?.cancel();
    locationPlugin.destroy();
  }

  @override
  void onReady() async {
    // 隐私协议
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);

    locationPlugin = AMapFlutterLocation();

    mapWidget.value = AMapWidget(
      privacyStatement: amapPrivacyStatement,
      apiKey: GlobalDataController.amapApiKeys,
      myLocationStyleOptions: MyLocationStyleOptions(
        true,
        icon: BitmapDescriptor.fromIconPath(
          'assets/images/mine_location.png',
        ),
        circleFillColor: Colors.transparent,
        circleStrokeColor: Colors.transparent,
      ),
      onMapCreated: mapCreated,
    );

    AMapFlutterLocation.setApiKey("e1524d2da3c1f95f9db0cf7ca2edc2ca", "");
    Future.delayed(const Duration(milliseconds: 1500), startLocation);

    // setMarket();
  }
}
