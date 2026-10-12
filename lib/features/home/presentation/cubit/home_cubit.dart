import 'package:ecommerce_app_huma_volve/features/home/data/models/categories/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products/products_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repo/home_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeIntialState());

  final List<CategoriesModel> categories = [];
  final List<ProductsModel> products = [];

  Future<void> getCategorisAndProducts() async {
    emit(HomeLoadingState());

    try {
      final result = await Future.wait([HomeRepo.getCategories(), HomeRepo.getProducts(0)]);

      final categoriesResponse = result[0] as List<CategoriesModel>?;
      final productsResponse = result[1] as List<ProductsModel>?;

      if (categoriesResponse != null || productsResponse != null) {
        categories.addAll(categoriesResponse ?? []);
        emit(CategoriesSucessState(categories: categories));
        products.addAll(productsResponse ?? []);
        emit(ProductsSucessState(products: products));
      }
    } on Exception catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
