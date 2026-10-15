import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';

abstract class HomeState {}

class HomeIntialState extends HomeState {}

class CategoryLoadingState extends HomeState {}

class CategorySucessState extends HomeState {
  final List<HomeCategoriesEntities> categories;
  CategorySucessState({required this.categories});
}

class CategoryErrorState extends HomeState {
  final String errorMessage;
  CategoryErrorState(this.errorMessage);
}

class ProductLoadingState extends HomeState {}

class ProductSucessState extends HomeState {
  final List<HomeProductsEntities> products;
  ProductSucessState({required this.products});
}

class ProductErrorState extends HomeState {
  final String errorMessage;
  ProductErrorState(this.errorMessage);
}

class ProductpaginationLoadingState extends HomeState {
  final List<HomeProductsEntities> products;

  ProductpaginationLoadingState({required this.products});
}

class ProductPaginationErrorState extends HomeState {
  final String errorMessage;
  ProductPaginationErrorState(this.errorMessage);
}
