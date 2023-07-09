import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';

class QuestionDetailController extends GetxController
    with StateMixin<Question> {
  late Question question;

  Future<void> commentQuestion(int comment) async {
    await QuestionApis.commentQuestion(
        {'question_id': question.id, 'comment': comment});
    EasyLoading.showToast('感谢您的反馈');
  }

  @override
  onReady() {
    Future.delayed(const Duration(milliseconds: 800), () async {
      try {
        var res = await QuestionApis.fetchQuestionDetail(
            {'id': Get.parameters['id']});
        question = Question.fromMap(res);
      } finally {
        change(question, status: RxStatus.success());
      }
    });
  }
}
