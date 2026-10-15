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

  HomeProductsEntities({this.id, this.title, this.slug, this.price, this.description, this.category, this.images, this.creationAt, this.updatedAt});

  HomeProductsEntities copyWith({
  int? id,
  String? title,
  String? slug,
  int? price,
  String? description,
  HomeCategoriesEntities? category,
  List<String>? images,
  DateTime? creationAt,
  DateTime? updatedAt,
}) {
  return HomeProductsEntities(
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    images: images ?? this.images,
    creationAt: creationAt ?? this.creationAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
}
