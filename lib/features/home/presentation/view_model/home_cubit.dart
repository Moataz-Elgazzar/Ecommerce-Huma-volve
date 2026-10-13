import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCases getCategoriesUseCases;
  final GetProductsUseCases getProductsUseCases;
  List<HomeCategoriesEntities> categories = [];
  HomeCubit({required this.getCategoriesUseCases, required this.getProductsUseCases}) : super(HomeIntialState());

  Future<void> getCategories() async {
    emit(CategoryLoadingState());

    final categories = await getCategoriesUseCases.invoke();
    categories.fold((failure) => emit(CategoryErrorState(failure.failureMessage)), (categories) async {
      this.categories = categories;
      emit(CategorySucessState(categories: categories));
      if (categories.isNotEmpty && categories.first.id != null) {
        await getProductsByCategory(categories.first.id!);
      }
    });
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(ProductLoadingState());

    final products = await getProductsUseCases.invoke(categoryId);
    products.fold((failure) => emit(ProductErrorState(failure.failureMessage)), (products) => emit(ProductSucessState(products: products)));
  }
}
