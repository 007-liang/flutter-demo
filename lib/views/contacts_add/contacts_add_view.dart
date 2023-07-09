import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/utils/index.dart';
import '/widget/cell/cell.dart';
import 'contacts_add_controller.dart';

class ContactsAddView extends GetView<ContactsAddController> {
  const ContactsAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Obx(
            () => Text(controller.isEmergency.value == 0 ? '添加好友' : '添加紧急联系人')),
        elevation: 1,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30.w,
          ),
          // 搜索框
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              height: 88.w,
              decoration: BoxDecoration(
                color: const Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(children: [
                Icon(
                  Icons.search,
                  size: 50.w,
                  color: const Color(0xff999999),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    flex: 1,
                    child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11) //限制长度
                        ],
                        keyboardType: TextInputType.phone,
                        controller: controller.inputPhoneCntroller,
                        onChanged: (value) =>
                            controller.changeInputPhone(value),
                        style: TextStyle(
                          color: const Color(0xff293033),
                          fontSize: 32.w,
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: '搜索',
                          hintStyle: TextStyle(
                              textBaseline: TextBaseline.alphabetic, //用于提示文字对齐
                              color: const Color(0xff999999),
                              fontSize: 28.w,
                              height: 1.0,
                              fontWeight: FontWeight.normal),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ))),
                Obx(() => controller.inputPhone.value.isNotEmpty
                    ? Ink(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                width: 1, color: const Color(0xff1e1e1e))),
                        child: InkWell(
                          onTap: () {
                            controller.changeInputPhone('');
                            controller.inputPhoneCntroller.clear();
                          },
                          child: const Icon(Icons.close_rounded),
                        ),
                      )
                    : Container())
              ])),
          Obx(() => Padding(
              padding: EdgeInsets.only(
                  top: controller.isShowSearchContacts ? 22.w : 44.w),
              child: controller.isShowSearchContacts
                  ? Cell(
                      // 寻找用户
                      height: 90,
                      suffixIconWidget: Padding(
                          padding: EdgeInsets.only(left: 53.w, right: 27.w),
                          child: Image.asset(
                            'assets/images/index/contacts/contacts_search.png',
                            width: 36.w,
                          )),
                      label: '搜索用户：${controller.inputPhone.value}',
                      border: false,
                      onTap: () => controller.searchMember(context),
                    )
                  : Row(
                      // 其他方式添加用户
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        contactsAddWidget(
                            icon:
                                'assets/images/index/contacts/addres_list_add.png',
                            label: '添加通讯录好友',
                            onTap: () =>
                                controller.selectAddressListContacts()),
                        SizedBox(
                          width: 103.w,
                        ),
                        contactsAddWidget(
                            icon: 'assets/images/index/contacts/wechat_add.png',
                            label: '添加微信好友',
                            onTap: () => share())
                      ],
                    )))
        ],
      )),
    );
  }
}

// 其他途径添加联系人
Widget contactsAddWidget(
    {required String icon, required String label, required Function onTap}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Column(
      children: [
        Image.asset(icon, height: 64.w),
        SizedBox(
          height: 20.w,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 24.w, color: const Color(0xff1e1e1e)),
        )
      ],
    ),
  );
}
