import 'dart:convert';

class ProductDelete {
  int? status;
  bool? data;
  int? totalCarts;
  String? message;
  String? userMsg;

  ProductDelete({
    this.status,
    this.data,
    this.totalCarts,
    this.message,
    this.userMsg,
  });

  factory ProductDelete.fromRawJson(String str) =>
      ProductDelete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDelete.fromJson(Map<String, dynamic> json) => ProductDelete(
        status: json["status"],
        data: json["data"],
        totalCarts: json["total_carts"],
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "total_carts": totalCarts,
        "message": message,
        "user_msg": userMsg,
      };
}
