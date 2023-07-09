import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VipPrivilegeItem {
  final String icon;
  final String label;
  final String desc;
  VipPrivilegeItem(
      {required this.icon, required this.label, required this.desc});
}

class VipPrivilege extends StatelessWidget {
  VipPrivilege({Key? key}) : super(key: key);

  // 会员特权
  final List<VipPrivilegeItem> vipPrivilegeList = [
    VipPrivilegeItem(icon: 'line', label: '轨迹查看', desc: '探索Ta的足迹'),
    VipPrivilegeItem(icon: 'focus', label: '关注Ta在哪', desc: '了解Ta的动向'),
    VipPrivilegeItem(icon: 'share', label: '实时位置', desc: '实时查看精准定位'),
    VipPrivilegeItem(icon: 'sos', label: '一键求助', desc: '遇险一键求助'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.w,
        ),
        // 会员提示
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/user/crown.png',
              height: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '开通会员享受4大特权',
              style: TextStyle(color: const Color(0xffd5b679), fontSize: 32.w),
            )
          ],
        ),
        SizedBox(height: 35.w),
        // 会员特权
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: vipPrivilegeList
              .map((item) => Column(
                    children: [
                      Image.asset(
                        'assets/images/user/${item.icon}.png',
                        width: 72.w,
                        height: 72.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14.w, bottom: 4.w),
                        child: Text(
                          item.label,
                          style: TextStyle(
                              color: const Color(0xff222222), fontSize: 26.w),
                        ),
                      ),
                      Text(
                        item.desc,
                        style: TextStyle(
                            color: const Color(0xff999999), fontSize: 20.w),
                      ),
                    ],
                  ))
              .toList(),
        ),
        SizedBox(
          height: 45.w,
        )
      ],
    );
  }
}
