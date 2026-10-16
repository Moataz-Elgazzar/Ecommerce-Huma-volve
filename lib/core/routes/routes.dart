import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_loader_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/home_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String details = '/products/:id';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: details,
        builder: (context, state) {
          final productId = int.tryParse(state.pathParameters['id'] ?? '');

          if (productId == null || productId <= 0) {
            return const _InvalidProductLinkScreen();
          }

          return ProductDetailsLoaderScreen(productId: productId);
        },
      ),
    ],
  );
}

class _InvalidProductLinkScreen extends StatelessWidget {
  const _InvalidProductLinkScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Invalid product link')));
  }
}
