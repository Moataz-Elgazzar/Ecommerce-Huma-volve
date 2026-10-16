import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';

abstract class HomeRepositories {
  Future<Either<Failure, List<HomeCategoriesEntities>>> getCategories();
  Future<Either<Failure, List<HomeProductsEntities>>> getProducts(int? id, {required int limit, required int offset});
  Future<Either<Failure, HomeProductsEntities>> getProductById(int id);
}
