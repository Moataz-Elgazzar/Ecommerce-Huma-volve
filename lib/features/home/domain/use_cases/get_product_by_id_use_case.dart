import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';

class GetProductByIdUseCase {
  final HomeRepositories homeRepositories;

  GetProductByIdUseCase(this.homeRepositories);

  Future<Either<Failure, HomeProductsEntities>> call(int id) {
    return homeRepositories.getProductById(id);
  }
}