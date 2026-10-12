import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/categories/categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products/products_model.dart';

class HomeRepo {
 static Future<List<CategoriesModel>?> getCategories() async {
    try {
      final categoriesResponse = await DioProvider.get(path: DioEndpoint.categories);
      if (categoriesResponse.statusCode == 200) {
        return (categoriesResponse.data as List).map((category)=> CategoriesModel.fromJson(category)).toList();
      } else {
        return null;
      }
    } on DioException catch (e) {
      log(e.message ?? "Error fetching categories", name: "HomeRepo");
      return null;
    }
  }

 static Future<List<ProductsModel>?> getProducts(int id) async {
    try {
      final productsResponse = await DioProvider.get(path:"${DioEndpoint.categories}/$id/${DioEndpoint.products}");
      if (productsResponse.statusCode == 200) {
        return (productsResponse.data as List).map((product) =>ProductsModel.fromJson(product)).toList();
      } else {
        return null;
      }
    } on DioException catch (e) {
      log(e.message ?? "Error fetching products", name: "HomeRepo");
      return null;
    }
  }
}
