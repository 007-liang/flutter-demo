part of model;

class Package {
  Package({
    required this.levelId,
    required this.goodName,
    required this.goodPrice,
    required this.originalPrice,
  });

  int levelId;
  String goodName;
  String goodPrice;
  String originalPrice;

  factory Package.fromJson(String str) => Package.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Package.fromMap(Map<String, dynamic> json) => Package(
        levelId: json["level_id"],
        goodName: json["good_name"],
        goodPrice: json["good_price"],
        originalPrice: json["original_price"],
      );

  Map<String, dynamic> toMap() => {
        "level_id": levelId,
        "good_name": goodName,
        "good_price": goodPrice,
        "original_price": originalPrice,
      };
}
