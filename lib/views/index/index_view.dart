import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/index.dart';
import 'index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 初始化创建控制器
    initCreateController();
    return WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(controller.lastPressedAt.value) >
              const Duration(seconds: 1)) {
            controller.changeLeaveTipShowState(true);
            Future.delayed(const Duration(seconds: 1),
                () => controller.changeLeaveTipShowState(false));
            //两次点击间隔超过1秒则重新计时
            controller.lastPressedAt.value = DateTime.now();
            return false;
          }
          return true;
        },
        child: Scaffold(
            //内容区域
            body: Obx(() => Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      physics: controller.currentIndex.value == 0
                          ? const NeverScrollableScrollPhysics()
                          : const PageScrollPhysics(),
                      onPageChanged: (index) => controller.changeIndex(index),
                      itemCount: controller.bottomBarList.length,
                      itemBuilder: (context, index) {
                        return controller.pageView[index];
                      },
                    ),
                    controller.isLeaveTipShow.value
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              color: const Color.fromARGB(255, 74, 74, 74),
                              child: const Text(
                                '再按一次退出',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )),
            bottomNavigationBar: Obx((() => BottomNavigationBar(
                  items: controller.bottomNavigationBarList(),
                  currentIndex: controller.currentIndex.value,
                  selectedFontSize: 12,
                  backgroundColor: Colors.white,
                  fixedColor: const Color(0xffff750a),
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) => controller.changePage(index),
                )))));
  }
}

void initCreateController() {
  Get.put<GlobalDataController>(GlobalDataController());
  Get.put<NotificationController>(NotificationController());
  Get.put<UserController>(UserController());
  Get.put<LocationController>(LocationController());
}
