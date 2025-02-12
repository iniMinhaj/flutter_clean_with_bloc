// To parse this JSON data, do
//
//     final popularProductModel = popularProductModelFromJson(jsonString);

import 'dart:convert';

PopularProductModel popularProductModelFromJson(String str) => PopularProductModel.fromJson(json.decode(str));

String popularProductModelToJson(PopularProductModel data) => json.encode(data.toJson());

class PopularProductModel {
    final List<Product>? data;

    PopularProductModel({
        this.data,
    });

    factory PopularProductModel.fromJson(Map<String, dynamic> json) => PopularProductModel(
        data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Product {
    final int? id;
    final String? name;
    final String? slug;
    final int? itemCategoryId;
    final int? taxId;
    final int? isFeatured;
    final String? flatPrice;
    final double? convertPrice;
    final String? currencyPrice;
    final String? price;
    final int? itemType;
    final int? status;
    final String? description;
    final String? caution;
    final String? thumb;
    final String? cover;
    final String? preview;
    final String? categoryName;
    final List<dynamic>? offer;

    Product({
        this.id,
        this.name,
        this.slug,
        this.itemCategoryId,
        this.taxId,
        this.isFeatured,
        this.flatPrice,
        this.convertPrice,
        this.currencyPrice,
        this.price,
        this.itemType,
        this.status,
        this.description,
        this.caution,
        this.thumb,
        this.cover,
        this.preview,
        this.categoryName,
        this.offer,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        itemCategoryId: json["item_category_id"],
        taxId: json["tax_id"],
        isFeatured: json["is_featured"],
        flatPrice: json["flat_price"],
        convertPrice: json["convert_price"]?.toDouble(),
        currencyPrice: json["currency_price"],
        price: json["price"],
        itemType: json["item_type"],
        status: json["status"],
        description: json["description"],
        caution: json["caution"],
        thumb: json["thumb"],
        cover: json["cover"],
        preview: json["preview"],
        categoryName: json["category_name"],
        offer: json["offer"] == null ? [] : List<dynamic>.from(json["offer"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "item_category_id": itemCategoryId,
        "tax_id": taxId,
        "is_featured": isFeatured,
        "flat_price": flatPrice,
        "convert_price": convertPrice,
        "currency_price": currencyPrice,
        "price": price,
        "item_type": itemType,
        "status": status,
        "description": description,
        "caution": caution,
        "thumb": thumb,
        "cover": cover,
        "preview": preview,
        "category_name": categoryName,
        "offer": offer == null ? [] : List<dynamic>.from(offer!.map((x) => x)),
    };
}
