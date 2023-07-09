import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'agreement_controller.dart';
import '../../widget/loading/loading.dart';

class AgreementView extends GetView<AgreementController> {
  const AgreementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Obx(() =>Text(controller.title.value)),
            centerTitle: true),
        body: SingleChildScrollView(
            child: controller.obx(
          (state) => Container(
            margin: EdgeInsets.fromLTRB(15.w, 30.w, 15.w, 0),
            child: Html(data:state),
          ),
          onLoading: const Loading(),
        )));
  }
}
