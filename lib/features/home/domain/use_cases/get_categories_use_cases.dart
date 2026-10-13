import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';

class GetCategoriesUseCases {
  final HomeRepositories homeRepositories;
  GetCategoriesUseCases(this.homeRepositories);

  Future<Either<Failure, List<HomeCategoriesEntities>>> invoke() => homeRepositories.getCategories();
}
