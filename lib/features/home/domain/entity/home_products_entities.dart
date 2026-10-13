import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';

class HomeProductsEntities {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  HomeCategoriesEntities? category;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;

  HomeProductsEntities({
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
}