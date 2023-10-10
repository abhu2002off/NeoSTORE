import 'dart:convert';

class CartItem {
  int? status;
  List<Datum>? data;
  int? count;
  int? total;

  CartItem({
    this.status,
    this.data,
    this.count,
    this.total,
  });

  factory CartItem.fromRawJson(String str) =>
      CartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "total": total,
      };
}

class Datum {
  int? id;
  int? productId;
  int? quantity;
  Product? product;

  Datum({
    this.id,
    this.productId,
    this.quantity,
    this.product,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "product": product?.toJson(),
      };
}

class Product {
  int? id;
  String? name;
  int? cost;
  String? productCategory;
  String? productImages;
  int? subTotal;

  Product({
    this.id,
    this.name,
    this.cost,
    this.productCategory,
    this.productImages,
    this.subTotal,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        productCategory: json["product_category"],
        productImages: json["product_images"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "product_category": productCategory,
        "product_images": productImages,
        "sub_total": subTotal,
      };
}
