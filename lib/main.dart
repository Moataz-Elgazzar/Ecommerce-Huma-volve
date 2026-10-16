import 'package:ecommerce_app_huma_volve/core/routes/routes.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
    );
  }
}
