part of model;

class Notice {
    Notice({
        required this.id,
        required this.memberToken,
        required this.isRead,
        required this.content,
        required this.phone,
        required this.nickname,
        required this.createTime,
        required this.isAccept,
        required this.type,
        required this.isEmergency,
    });

    int id;
    String memberToken;
    int isRead;
    String content;
    String phone;
    String nickname;
    String createTime;
    int isAccept;
    int type;
    int isEmergency;

    factory Notice.fromJson(String str) => Notice.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Notice.fromMap(Map<String, dynamic> json) => Notice(
        id: json["id"],
        memberToken: json["member_token"],
        isRead: json["is_read"],
        content: json["content"],
        phone: json["phone"],
        nickname: json["nickname"],
        createTime: json["create_time"],
        isAccept: json["is_accept"],
        type: json["type"],
        isEmergency: json["is_emergency"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "member_token": memberToken,
        "is_read": isRead,
        "content": content,
        "phone": phone,
        "nickname": nickname,
        "create_time": createTime,
        "is_accept": isAccept,
        "type": type,
        "is_emergency": isEmergency,
    };
}
