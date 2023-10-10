import 'dart:convert';

class ProductRatingModel {
  int? status;
  Data? data;
  String? message;
  String? userMsg;

  ProductRatingModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory ProductRatingModel.fromRawJson(String str) =>
      ProductRatingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) =>
      ProductRatingModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
        "user_msg": userMsg,
      };
}

class Data {
  int? id;
  int? productCategoryId;
  String? name;
  String? producer;
  String? description;
  int? cost;
  double? rating;
  int? viewCount;
  String? created;
  String? modified;

  Data({
    this.id,
    this.productCategoryId,
    this.name,
    this.producer,
    this.description,
    this.cost,
    this.rating,
    this.viewCount,
    this.created,
    this.modified,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        producer: json["producer"],
        description: json["description"],
        cost: json["cost"],
        rating: json["rating"]?.toDouble(),
        viewCount: json["view_count"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category_id": productCategoryId,
        "name": name,
        "producer": producer,
        "description": description,
        "cost": cost,
        "rating": rating,
        "view_count": viewCount,
        "created": created,
        "modified": modified,
      };
}
