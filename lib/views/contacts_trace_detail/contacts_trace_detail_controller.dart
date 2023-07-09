import 'dart:convert';
import '/controllers/parts/global_data_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:amap_flutter_base/amap_flutter_base.dart';
import '/api/index.dart';
import '/model/index.dart';

class ContactsTraceDetailController extends GetxController {
  Rxn<AMapWidget> mapWidget = Rxn(null);
  Rxn<Contacts> contacts = Rxn(null);
  Trace? currentTrace;
  Trace? latestTrace;
  final Map<String, Polyline> _polylines = <String, Polyline>{};

  // 选择时间
  Rx<DateTime> date = DateTime.now().obs;

  // 时间（显示用）
  get dateToString {
    if (DateTime.now().difference(date.value).inDays == 0) {
      return '今天';
    } else {
      return '${date.value.year}.${date.value.month}.${date.value.day}';
    }
  }

  // 时间 （获取api用）
  get dateToFetch {
    return '${date.value.year}-${date.value.month}-${date.value.day}';
  }

  // 切换时间
  void changeDate(DateTime value) {
    date.value = value;
    getInfo();
  }

  // 地图创建时
  void mapCreated(AMapController controller) {
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //中心点
          target: LatLng(currentTrace!.wd, currentTrace!.jd),
          //缩放级别
          zoom: 18,
        ),
      ),
      animated: true,
    );
  }

  void getInfo() async {
    List res = await ContactsApis.fetchTraceList(
        {"friend": contacts.value!.memberToken, "time": dateToFetch});
    res = res.where((item) => item['jd'] != null && item['wd'] != null).toList();
    if (res.isNotEmpty) {
      List<Trace> traceList = res.map((item) => Trace.fromMap(item)).toList();

      currentTrace = traceList[0];

      latestTrace = traceList[traceList.length - 1];

      List<LatLng> points = <LatLng>[];

      for (Trace item in traceList) {
        points.add(LatLng(item.wd, item.jd));
      }

      Polyline polyline = Polyline(
        color: const Color(0xff3193FF),
        width: 15.w,
        geodesic: true,
        capType: CapType.arrow,
        points: points,
      );
      _polylines[polyline.id] = polyline;

      // 创建地图组件
      mapWidget.value = AMapWidget(
        apiKey: GlobalDataController.amapApiKeys,
        onMapCreated: mapCreated,
        polylines: Set<Polyline>.of(_polylines.values),
      );
    } else {
      mapWidget.value = null;
    }
  }

  @override
  void onReady() {
    String? jsonContacts = Get.arguments['contacts'];
    if (jsonContacts != null) {
      contacts.value = Contacts.fromJson(jsonDecode(jsonContacts));
    }
    getInfo();
  }
}
