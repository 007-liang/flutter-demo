part of model;

class Config {
  Config({
    required this.id,
    required this.introduction,
    required this.qq,
    required this.email,
    required this.recordNum,
    required this.isTrial,
  });

  final int id;
  final String introduction;
  final String qq;
  final String email;
  final String recordNum;
  final int isTrial;

  factory Config.fromJson(String str) => Config.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Config.fromMap(Map<String, dynamic> json) => Config(
        id: json["id"],
        introduction: json["Introduction"],
        qq: json["qq"],
        email: json["email"],
        recordNum: json["record_num"],
        isTrial: json["is_trial"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Introduction": introduction,
        "qq": qq,
        "email": email,
        "record_num": recordNum,
        "is_trial": isTrial,
      };
}
