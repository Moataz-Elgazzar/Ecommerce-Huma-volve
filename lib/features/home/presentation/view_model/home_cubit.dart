import 'package:ecommerce_app_huma_volve/core/error_handler/error_handler.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_categories_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCases getCategoriesUseCases;
  final GetProductsUseCases getProductsUseCases;
  List<HomeCategoriesEntities> categories = [];
  HomeCubit({required this.getCategoriesUseCases, required this.getProductsUseCases}) : super(HomeIntialState());

  final int limit = 10;
  int offset = 0;
  bool hasMoreProducts = true;
  bool isLoadingMore = false;
  int? currentCategoryId;
  int categoryRequestId = 0;
  List<HomeProductsEntities> products = [];

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

  Future<void> getProductsByCategory(int categoryId, {bool loadMore = false}) async {
    if (loadMore && (isLoadingMore || !hasMoreProducts)) return;

    if (!loadMore) {
      categoryRequestId++;
      currentCategoryId = categoryId;
      offset = 0;
      hasMoreProducts = true;
      isLoadingMore = false;
      products.clear();
    }

    final requestId = categoryRequestId;

    if (loadMore) {
      isLoadingMore = true;
      emit(ProductpaginationLoadingState(products: List.of(products)));
    } else {
      emit(ProductLoadingState());
    }

    final result = await getProductsUseCases.invoke(categoryId, limit: limit, offset: offset);

    if (requestId != categoryRequestId) return;

    result.fold(
      (failure) {
        isLoadingMore = false;
        if (loadMore) {
          emit(ProductSucessState(products: List.of(products)));
        } else {
          emit(ProductErrorState(failure.failureMessage));
        }
      },
      (newproducts) {
        products.addAll(newproducts);
        offset += newproducts.length;
        hasMoreProducts = newproducts.length == limit;
        isLoadingMore = false;
        emit(ProductSucessState(products: List.of(products)));
      },
    );
  }
}
