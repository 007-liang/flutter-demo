part of model;

class UserInfo {
  UserInfo({
    required this.avatar,
    required this.nickname,
    required this.sex,
    required this.age,
    required this.marriage,
    required this.vipmember,
    required this.phoneNum,
    required this.endtime,
    required this.swooletoken,
    required this.isEmergency,
  });

  String avatar;
  String nickname;
  dynamic sex;
  dynamic age;
  dynamic marriage;
  int vipmember;
  String phoneNum;
  dynamic endtime;
  String swooletoken;
  int isEmergency;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        avatar: json["avatar"],
        nickname: json["nickname"],
        sex: json["sex"],
        age: json["age"],
        marriage: json["Marriage"],
        vipmember: json["vipmember"],
        phoneNum: json["phoneNum"],
        endtime: json["endtime"],
        swooletoken: json["swooletoken"],
        isEmergency: json["is_emergency"],
      );

  Map<String, dynamic> toMap() => {
        "avatar": avatar,
        "nickname": nickname,
        "sex": sex,
        "age": age,
        "Marriage": marriage,
        "vipmember": vipmember,
        "phoneNum": phoneNum,
        "endtime": endtime,
        "swooletoken": swooletoken,
        "is_emergency": isEmergency,
      };
}
