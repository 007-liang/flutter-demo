import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'pages/home/home_page.dart';
import 'pages/contacts/contacts_page.dart';
import 'pages/emergency/emergency_page.dart';
import 'pages/user/user_page.dart';

class BottomBarListItem {
  String icon;
  String label;
  BottomBarListItem({required this.icon, required this.label});
}

class IndexController extends GetxController {
  // 页面
  List<Widget> pageView = [
    const HomePage(),
    const ContactsPage(),
    const EmergencyPage(),
    UserPage()
  ];

  // 底部栏数据
  List<BottomBarListItem> bottomBarList = [
    BottomBarListItem(icon: 'index', label: '定位'),
    BottomBarListItem(icon: 'contacts', label: '好友'),
    BottomBarListItem(icon: 'sos', label: '紧急'),
    BottomBarListItem(icon: 'user', label: '我的'),
  ];

  // 底部栏
  List<BottomNavigationBarItem> bottomNavigationBarList() => bottomBarList
      .map(
        (item) => BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/index/${item.icon}_active.png',
              width: 25,
              height: 25,
            ),
            icon: Image.asset(
              'assets/images/index/${item.icon}.png',
              width: 25,
              height: 25,
            ),
            label: item.label),
      )
      .toList();

  // 当前页面下标
  RxInt currentIndex = 0.obs;

  // 页面控制器
  final PageController pageController = PageController();

  // 切换下标
  void changeIndex(int index) {
    currentIndex.value = index;
  }
  
  //上次点击时间
  Rx<DateTime> lastPressedAt = DateTime.now().obs; 
  
  // 退出软件提醒
  RxBool isLeaveTipShow = false.obs;
  
  
  changeLeaveTipShowState(bool status) {
    isLeaveTipShow.value = status;
  }

  changePage(int index) {
    changeIndex(index);
    pageController.jumpToPage(index);
  }
}
