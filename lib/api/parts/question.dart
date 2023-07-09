part of apis;

abstract class QuestionApis {
  // 获取问题列表
  static fetchQuestionList() {
    return api.connect('Register/questionList');
  }

  // 获取问题列表
  static fetchQuestionDetail(query) {
    return api.connect('Register/questionInfo', query: query);
  }

  // 评价问题
  static commentQuestion(data) {
    return api.connect('Register/questionComment', method: 'post', data: data);
  }
}
