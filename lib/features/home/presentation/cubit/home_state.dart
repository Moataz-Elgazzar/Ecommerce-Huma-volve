import 'package:ecommerce_app_huma_volve/features/home/data/models/categories/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products/products_model.dart';

abstract class HomeState {}

class HomeIntialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSucessState extends HomeState {
  final List<CategoriesModel> categories;
  final List<ProductsModel> products;
  HomeSucessState({required this.categories , required this.products});
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}
