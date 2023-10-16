// To parse this JSON data, do
//
//     final addToCartPayload = addToCartPayloadFromJson(jsonString);

import 'dart:convert';

AddToCartPayload addToCartPayloadFromJson(String str) =>
    AddToCartPayload.fromJson(json.decode(str));

String addToCartPayloadToJson(AddToCartPayload data) =>
    json.encode(data.toJson());

class AddToCartPayload {
  final int userId;
  final DateTime date;
  final List<CartProduct> products;

  AddToCartPayload({
    required this.userId,
    required this.date,
    required this.products,
  });

  AddToCartPayload copyWith({
    int? userId,
    DateTime? date,
    List<CartProduct>? products,
  }) =>
      AddToCartPayload(
        userId: userId ?? this.userId,
        date: date ?? this.date,
        products: products ?? this.products,
      );

  factory AddToCartPayload.fromJson(Map<String, dynamic> json) =>
      AddToCartPayload(
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<CartProduct>.from(
            json["products"].map((x) => CartProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({
    required this.productId,
    required this.quantity,
  });

  CartProduct copyWith({
    int? productId,
    int? quantity,
  }) =>
      CartProduct(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
