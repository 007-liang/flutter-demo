import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widget/loading/loading.dart';
import '../../router/index.dart';
import '../../widget/cell/cell.dart';
import '../../model/index.dart';
import 'question_controller.dart';

class QuestionView extends GetView<QuestionController> {
  const QuestionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('常见问题')),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: controller.obx(
              (state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Image.asset('assets/images/user/question_bg.png'),
                      SizedBox(
                        height: 40.w,
                      ),
                      Text(
                        '常见问题',
                        style: TextStyle(
                            color: const Color(0xff293033),
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      ...List.generate(state!.length, (index) {
                        Question item = state[index];
                        return Cell(
                          label: '【${index + 1}】${item.title}',
                          height: 120,
                          key: Key(item.id.toString()),
                          border: true,
                          onTap: () => Get.toNamed('${Routes.question}/${Routes.questionDetail}',
                              parameters: {'id': item.id.toString()}),
                        );
                      })
                    ],
                  ),
              onLoading: const Loading())),
    );
  }
}
