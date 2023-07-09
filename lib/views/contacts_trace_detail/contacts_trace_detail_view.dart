import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'contacts_trace_detail_controller.dart';

class ContactsTraceDetailView extends GetView<ContactsTraceDetailController> {
  const ContactsTraceDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xfff1f1f1),
        child: Obx(() => Stack(
              children: [
                controller.mapWidget.value ?? Container(),
                Stack(
                  children: [
                    ClipRect(
                      //背景过滤器
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Opacity(
                            opacity: 0.4,
                            child: Container(
                                width: 100.sw,
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200),
                                child: const SafeArea(
                                  top: true,
                                  child: SizedBox(
                                    height: 50,
                                  ),
                                ))),
                      ),
                    ),
                    SafeArea(
                      top: true,
                      child: SizedBox(
                          height: 50,
                          child: AppBar(
                              centerTitle: true,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              title: GestureDetector(
                                onTap: () => DatePicker.showDatePicker(
                                  context,
                                  // showTitleActions: true,
                                  maxTime: DateTime.now(),
                                  onConfirm: (date) =>
                                      controller.changeDate(date),
                                  currentTime: controller.date.value,
                                  locale: LocaleType.zh,
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40.sp,
                                      ),
                                      Text('${controller.dateToString}'),
                                      Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 40.sp,
                                      )
                                    ]),
                              ))),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Offstage(
                    offstage: controller.contacts.value == null,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        bottom: 42.w,
                        left: 36.w,
                        right: 36.w,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 50.w,
                            height: 6.w,
                            margin: EdgeInsets.only(top: 13.w, bottom: 40.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.w),
                              color: const Color(0xffd7d7d7),
                            ),
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.w),
                                child: controller.contacts.value?.avatar == null
                                    ? Image.asset(
                                        'assets/images/user/avatar.png',
                                        width: 100.w,
                                        height: 100.w,
                                      )
                                    : Image.network(
                                        controller.contacts.value!.avatar,
                                        width: 100.w,
                                        height: 100.w,
                                      ),
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                     controller
                                              .contacts.value?.nickname != null && controller
                                              .contacts.value!.nickname.isEmpty
                                          ? controller.contacts.value!.phoneNum
                                          : controller.contacts.value?.nickname ?? '',
                                      style: TextStyle(
                                        fontSize: 36.w,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff293033),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Text(
                                      controller.mapWidget.value == null
                                          ? '暂无时间信息'
                                          : controller.latestTrace!.time,
                                      style: TextStyle(
                                        fontSize: 28.w,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff93979a),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 42.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '当前位置：',
                                style: TextStyle(
                                  fontSize: 28.w,
                                  height: 1.4,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.mapWidget.value == null
                                      ? '暂无当前位置信息'
                                      : controller.latestTrace!.address,
                                  style: TextStyle(
                                    fontSize: 28.w,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
