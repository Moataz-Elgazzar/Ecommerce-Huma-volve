import 'package:ecommerce_app_huma_volve/features/home/data/models/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoriesModel>?> getCategories();
  Future<List<ProductsModel>?> getProducts(int? id , {required int limit  ,required int offset});
  Future<ProductsModel?> getProductById(int id);
}
