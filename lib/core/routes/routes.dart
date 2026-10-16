import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String details = '/details';
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) {
          final product = state.extra as HomeProductsEntities;
          return ProductDetailsScreen(product: product,);
        },
      ),
    ],
  );
}
