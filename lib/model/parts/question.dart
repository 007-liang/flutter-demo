part of model;

class Question {
  Question({
    required this.id,
    required this.title,
    required this.reply,
    required this.good,
    required this.bad,
    required this.comment,
  });

  final int id;
  final String title;
  final String reply;
  final int good;
  final int bad;
  final int comment;

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        reply: json["reply"],
        good: json["good"],
        bad: json["bad"],
        comment: json["comment"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "reply": reply,
        "good": good,
        "bad": bad,
        "comment": comment,
      };
}
