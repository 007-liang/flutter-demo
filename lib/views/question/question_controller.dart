import 'package:get/get.dart';
import '/api/index.dart';
import '/model/index.dart';

class QuestionController extends GetxController
    with StateMixin<List<Question>> {
  late List<Question> questionList;

  @override
  Future<void> onReady() async {
    try { 
      var res = await QuestionApis.fetchQuestionList();
      questionList =
          res.map<Question>((item) => Question.fromMap(item)).toList();
    } finally {
      change(questionList, status: RxStatus.success());
    } 
  }
}
