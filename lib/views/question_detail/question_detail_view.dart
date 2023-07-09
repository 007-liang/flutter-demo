import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'question_detail_controller.dart';
import '../../widget/loading/loading.dart';

class QuestionDetailView extends GetView<QuestionDetailController> {
  const QuestionDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('问题详情')),
      body: SingleChildScrollView(
          child: controller.obx(
              (state) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.w),
                        Text(
                          state!.title,
                          style: TextStyle(
                              fontSize: 43.w,
                              color: const Color(0xff1e1e1e),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 46.w),
                        Html(data: state.reply),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                onPressed: () => controller.commentQuestion(1),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      controller.question.comment == 1
                                          ? const Color(0xffff7600)
                                          : Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      const StadiumBorder()),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(
                                      316.w,
                                      80.w,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      const AssetImage(
                                          'assets/images/user/question_like.png'),
                                      color: controller.question.comment == 1
                                          ? Colors.white
                                          : const Color(0xff93979a),
                                      size: 32.w,
                                    ),
                                    SizedBox(
                                      width: 22.w,
                                    ),
                                    Text(
                                      '已解决',
                                      style: TextStyle(
                                          color:
                                              controller.question.comment == 1
                                                  ? Colors.white
                                                  : const Color(0xff93979a),
                                          fontSize: 28.w),
                                    ),
                                  ],
                                )),
                            OutlinedButton(
                                onPressed: () => controller.commentQuestion(2),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      controller.question.comment == 2
                                          ? const Color(0xffff7600)
                                          : Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      const StadiumBorder()),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(316.w, 80.w)),
                                ),
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      const AssetImage(
                                          'assets/images/user/question_unlike.png'),
                                      color: controller.question.comment == 2
                                          ? Colors.white
                                          : const Color(0xff93979a),
                                      size: 32.w,
                                    ),
                                    SizedBox(
                                      width: 22.w,
                                    ),
                                    Text(
                                      '未解决',
                                      style: TextStyle(
                                          color:
                                              controller.question.comment == 2
                                                  ? Colors.white
                                                  : const Color(0xff93979a),
                                          fontSize: 28.w),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
              onLoading: const Loading())),
    );
  }
}
