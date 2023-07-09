part of model;

class Trace {
  Trace({
    required this.jd,
    required this.wd,
    required this.time,
    required this.type,
    required this.address,
    required this.memberToken,
  });

  final double jd;
  final double wd;
  final String time;
  final String type;
  final String address;
  final String memberToken;

  factory Trace.fromJson(String str) => Trace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trace.fromMap(Map<String, dynamic> json) => Trace(
        jd: json["jd"].toDouble(),
        wd: json["wd"].toDouble(),
        time: json["time"],
        type: json["type"],
        address: json["address"],
        memberToken: json["member_token"],
      );

  Map<String, dynamic> toMap() => {
        "jd": jd,
        "wd": wd,
        "time": time,
        "type": type,
        "address": address,
        "member_token": memberToken,
      };
}
