import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';

class CategoriesModel extends HomeCategoriesEntities {
  CategoriesModel({super.id, super.name, super.slug, super.image, super.creationAt, super.updatedAt});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(id: json['id'] as int?, name: json['name'] as String?, slug: json['slug'] as String?, image: json['image'] as String?, creationAt: json['creationAt'] == null ? null : DateTime.parse(json['creationAt'] as String), updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String));
  }

  CategoriesModel toEntity() {
    return CategoriesModel(id: id, name: name, slug: slug, image: image, creationAt: creationAt);
  }
}
