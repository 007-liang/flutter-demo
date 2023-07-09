import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/utils/index.dart';
import '/router/index.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Offstage(
        offstage: _homeController.mapWidget.value == null,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: _homeController.mapWidget.value,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: true,
                child: Container(
                    margin: EdgeInsets.all(30.w),
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 88.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(220, 255, 255, 255),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          checkIsLogin(() => checkIsVip(
                              () => Get.toNamed(Routes.contactsAdd)));
                        },
                        child: Row(children: [
                          Icon(
                            Icons.search,
                            size: 50.w,
                            color: const Color(0xff999999),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(child: Text(
                            '输入好友手机号码',
                            style: TextStyle(
                              color: const Color(0xff999999),
                              fontSize: 28.w,
                            ),
                          ),),
                          
                          const Icon(
                            Icons.contacts_sharp,
                            color: Colors.black38,
                          ),
                        ]))),
              )
              // 搜索框
              ),
          Positioned(
              right: 10,
              bottom: 15,
              child: Column(
                children: [
                  iconButtonWidget(Icons.my_location_rounded,
                      () => _homeController.startLocation()),
                  SizedBox(
                    height: 20.w,
                  ),
                  iconButtonWidget(
                      Icons.people_alt, () => Get.toNamed(Routes.contactTrace)),
                ],
              ))
        ])));
  }
}

Widget iconButtonWidget(IconData icon, onTap) {
  return Material(
      color: Colors.transparent,
      child: Ink(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18.w)),
          child: SizedBox(
            height: 72.w,
            width: 72.w,
            child: InkWell(
              child: Icon(
                icon,
                size: 34.w,
                color: const Color(0xffff7600),
              ),
              onTap: () => onTap(),
            ),
          )));
}
