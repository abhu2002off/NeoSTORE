import 'dart:convert';

class ProductDetailModel {
  int? id;
  int? productCategoryId;
  String? name;
  String? producer;
  String? description;
  int? cost;
  int? rating;
  int? viewCount;
  String? created;
  String? modified;
  List<ProductImage>? productImages;

  ProductDetailModel({
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
    this.productImages,
  });

  factory ProductDetailModel.fromRawJson(String str) =>
      ProductDetailModel.fromJson(json.decode(str)['data']);

  String toRawJson() => json.encode(toJson());

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        producer: json["producer"],
        description: json["description"],
        cost: json["cost"],
        rating: json["rating"],
        viewCount: json["view_count"],
        created: json["created"],
        modified: json["modified"],
        productImages: json["product_images"] == null
            ? []
            : List<ProductImage>.from(
                json["product_images"]!.map((x) => ProductImage.fromJson(x))),
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
        "product_images": productImages == null
            ? []
            : List<dynamic>.from(productImages!.map((x) => x.toJson())),
      };
}

class ProductImage {
  int? id;
  int? productId;
  String? image;
  String? created;
  String? modified;

  ProductImage({
    this.id,
    this.productId,
    this.image,
    this.created,
    this.modified,
  });

  factory ProductImage.fromRawJson(String str) =>
      ProductImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["product_id"],
        image: json["image"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image": image,
        "created": created,
        "modified": modified,
      };
}
