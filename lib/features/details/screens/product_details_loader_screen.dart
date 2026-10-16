
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repository/home_repositories_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';


class ProductDetailsLoaderScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsLoaderScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsLoaderScreen> createState() =>
      _ProductDetailsLoaderScreenState();
}

class _ProductDetailsLoaderScreenState
    extends State<ProductDetailsLoaderScreen> {
  late Future<dynamic> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _loadProduct();
  }

  Future<dynamic> _loadProduct() async {
    final remoteDataSource = HomeRemoteDataSourceImpl();
    final repository = HomeRepositoriesImpl(remoteDataSource);
    final useCase = GetProductByIdUseCase(repository);

    return useCase.call(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Failed to load product')),
          );
        }

        final result = snapshot.data!;

        return result.fold(
          (failure) => Scaffold(
            body: Center(
              child: Text(failure.toString()),
            ),
          ),
          (product) => ProductDetailsScreen(product: product),
        );
      },
    );
  }
}
