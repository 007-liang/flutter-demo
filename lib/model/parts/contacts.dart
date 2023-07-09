part of model;

class Contacts {
  Contacts({
    required this.id,
    required this.nickname,
    required this.phoneNum,
    required this.memberToken,
    required this.avatar,
    required this.longitude,
    required this.latitude,
    required this.remark,
    required this.isEmergency,
    required this.isHidden,
    required this.pidToken,
    this.jd,
    this.wd,
    this.time,
    this.address,
    required this.canSee,
  });

  final int id;
  final String nickname;
  final String phoneNum;
  final String memberToken;
  final dynamic avatar;
  final dynamic longitude;
  final dynamic latitude;
  final dynamic remark;
  final int isEmergency;
  final int isHidden;
  final String pidToken;
  final double? jd;
  final double? wd;
  final String? time;
  final String? address;
  final int canSee;

  factory Contacts.fromJson(String str) => Contacts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Contacts.fromMap(Map<String, dynamic> json) => Contacts(
        id: json["id"],
        nickname: json["nickname"],
        phoneNum: json["phoneNum"],
        memberToken: json["member_token"],
        avatar: json["avatar"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        remark: json["remark"],
        isEmergency: json["is_emergency"],
        isHidden: json["is_hidden"],
        pidToken: json["pid_token"],
        jd: json["jd"],
        wd: json["wd"],
        time: json["time"],
        address: json["address"],
        canSee: json["can_see"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nickname": nickname,
        "phoneNum": phoneNum,
        "member_token": memberToken,
        "avatar": avatar,
        "longitude": longitude,
        "latitude": latitude,
        "remark": remark,
        "is_emergency": isEmergency,
        "is_hidden": isHidden,
        "pid_token": pidToken,
        "jd": jd,
        "wd": wd,
        "time": time,
        "address": address,
        "can_see": canSee,
      };
}
