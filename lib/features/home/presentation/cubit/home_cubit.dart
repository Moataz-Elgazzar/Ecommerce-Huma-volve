import 'package:ecommerce_app_huma_volve/features/home/data/models/categories/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products/products_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repo/home_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeIntialState());

  final List<CategoriesModel> categories = [];
  final List<ProductsModel> products = [];

 
Future<void> getCategories() async {
  emit(HomeLoadingState());

  try {
    final response = await HomeRepo.getCategories();

    if (response == null || response.isEmpty) {
      emit(HomeErrorState(
        errorMessage: 'Failed to load categories',
      ));
      return;
    }

    categories
      ..clear()
      ..addAll(response);

    await getProductsByCategory(categories.first.id!);
  } catch (e) {
    emit(HomeErrorState(errorMessage: e.toString()));
  }
}

Future<void> getProductsByCategory(int categoryId) async {
  emit(HomeLoadingState());

  try {
    final response = await HomeRepo.getProducts(categoryId);

    if (response == null) {
      emit(HomeErrorState(
        errorMessage: 'Failed to load products',
      ));
      return;
    }

    products
      ..clear()
      ..addAll(response);

    emit(HomeSucessState(
      categories: categories,
      products: products,
    ));
  } catch (e) {
    emit(HomeErrorState(errorMessage: e.toString()));
  }
}

}
