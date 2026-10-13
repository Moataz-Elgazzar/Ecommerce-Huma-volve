import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<CategoriesModel>?> getCategories() async {
    final categoriesResponse = await DioProvider.get(path: DioEndpoint.categories);
    if (categoriesResponse.statusCode == 200) {
      return (categoriesResponse.data as List).map((category) => CategoriesModel.fromJson(category)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<ProductsModel>?> getProducts(int? id) async {
    final productsResponse = await DioProvider.get(path: "${DioEndpoint.categories}/$id/${DioEndpoint.products}");
    if (productsResponse.statusCode == 200) {
      return (productsResponse.data as List).map((product) => ProductsModel.fromJson(product)).toList();
    } else {
      return null;
    }
  }
}
