import 'package:ecommerce_app_huma_volve/features/home/data/models/categories/categories_model.dart';


class ProductsModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;

  ProductsModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    slug: json['slug'] as String?,
    price: json['price'] as int?,
    description: json['description'] as String?,
    category: json['category'] == null
        ? null
        : CategoriesModel.fromJson(json['category'] as Map<String, dynamic>),
    images: json['images'] as List<String>?,
    creationAt: json['creationAt'] == null
        ? null
        : DateTime.parse(json['creationAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'price': price,
    'description': description,
    'category': category?.toJson(),
    'images': images,
    'creationAt': creationAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
