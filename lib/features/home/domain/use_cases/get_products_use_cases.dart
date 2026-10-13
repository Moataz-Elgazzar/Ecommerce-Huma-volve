import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';

class GetProductsUseCases {
  final HomeRepositories homeRepositories;
  GetProductsUseCases(this.homeRepositories);

  Future<Either<Failure, List<HomeProductsEntities>>> invoke(int? id) => homeRepositories.getProducts(id);
}
