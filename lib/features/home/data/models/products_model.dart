import 'package:ecommerce_app_huma_volve/features/home/data/models/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';

class ProductsModel extends HomeProductsEntities {
  ProductsModel({super.id, super.title, super.slug, super.price, super.description, super.category, super.images, super.creationAt, super.updatedAt});

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(id: json['id'] as int?, title: json['title'] as String?, slug: json['slug'] as String?, price: json['price'] as int?, description: json['description'] as String?, category: json['category'] == null ? null : CategoriesModel.fromJson(json['category'] as Map<String, dynamic>), images: (json['images'] as List<dynamic>?)?.map((image) => image.toString()).toList(), creationAt: json['creationAt'] == null ? null : DateTime.parse(json['creationAt'] as String), updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String));

  ProductsModel toEntity() {
    return ProductsModel(
      id:id,
      title:title,
      slug:slug,
      price:price,
      description:description,
      category:category,
      images:images,
      creationAt:creationAt,
      updatedAt:updatedAt,
    );
  }
}
