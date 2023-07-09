import 'dart:convert';
import 'package:get/get.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:web_socket_channel/io.dart';
import '/controllers/index.dart';

class AddressInformation {
  double longitude = 0;
  double latitude = 0;
  String address = '';

  clear() {
    longitude = 0;
    latitude = 0;
    address = '';
  }
}

class LocationController extends GetxController {
  final UserController userController = Get.find<UserController>();
  IOWebSocketChannel? channel;
  late AMapFlutterLocation locationPlugin;
  final AddressInformation addressInformation = AddressInformation();

  // 清楚记录信息
  void clearRecordInfomation() {}

  ///开始定位
  void _startLocation() {
    _setLocationOption();
    locationPlugin.startLocation();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///将定位参数设置给定位插件
    locationPlugin.setLocationOption(locationOption);
  }

  websocketInit() {
    // 连接websocket
    try {
      channel = IOWebSocketChannel.connect('ws://47.104.182.83:9502');
      channel?.stream.listen(
        (event) {
          // print(event);
        },
        onDone: () async {
          channel?.sink.close();
          channel = null;
          Future.delayed(const Duration(seconds: 2), () => websocketInit());
        },
      );
    } catch (e) {
          Future.delayed(const Duration(seconds: 2), () => websocketInit());
    }
  }

  @override
  void onReady() async {
    // 隐私协议
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);

    await Future.delayed(const Duration(seconds: 1));

    // 设置定位key
    AMapFlutterLocation.setApiKey("e1524d2da3c1f95f9db0cf7ca2edc2ca", "");

    websocketInit();
    // 生成定位实例
    locationPlugin = AMapFlutterLocation();

    // 监听点击改变
    locationPlugin.onLocationChanged().listen((result) {
      dynamic latitude = result['latitude'];
      dynamic longitude = result['longitude'];
      dynamic address = result['address'];

      if (latitude is double &&
          longitude is double &&
          (latitude != addressInformation.latitude ||
              longitude != addressInformation.longitude) &&
          userController.userInfo.value != null) {
        addressInformation.latitude = latitude;
        addressInformation.longitude = longitude;
        addressInformation.address = address;
        channel?.sink.add(json.encode({
          "member_token": userController.userInfo.value!.swooletoken,
          "jd": longitude,
          "wd": latitude,
          'address': address,
          "type": 'goonline'
        }));
      }
    });

    // 开始定位
    Future.delayed(const Duration(milliseconds: 1500), () => _startLocation());
  }
}
