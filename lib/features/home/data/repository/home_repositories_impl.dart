import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';

class HomeRepositoriesImpl implements HomeRepositories {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoriesImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<HomeCategoriesEntities>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.getCategories();
      return Right(categories!.map((category) => category.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductsEntities>>> getProducts(int? id) async {
    try {
      final products = await homeRemoteDataSource.getProducts(id);
      return Right(products!.map((product) => product.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
