import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repository/home_repositories_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_cases.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dummy_data.dart';
import '../../../../core/theme.dart';
import 'widgets/category_chip.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GetCategoriesUseCases getCategoriesUseCases;
  late final GetProductsUseCases getProductsUseCases;
  late final HomeRepositories homeRepositories;
  late final HomeRemoteDataSource homeRemoteDataSource;

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    homeRemoteDataSource = HomeRemoteDataSourceImpl();
    homeRepositories = HomeRepositoriesImpl(homeRemoteDataSource);
    getCategoriesUseCases = GetCategoriesUseCases(homeRepositories);
    getProductsUseCases = GetProductsUseCases(homeRepositories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(getCategoriesUseCases: getCategoriesUseCases, getProductsUseCases: getProductsUseCases)..getCategories(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
                            ),
                            child: const Icon(Icons.menu, color: AppTheme.primary),
                          ),
                          CircleAvatar(radius: 24, backgroundImage: NetworkImage(dummyUser.profilePictureUrl)),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text('Explore', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36)),
                      const SizedBox(height: 8),
                      Text('Best trendy collection!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18)),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 5))],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search clothes...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.tune, color: Colors.white, size: 20),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          final cubit = context.read<HomeCubit>();
                          if (state is CategoryLoadingState && cubit.categories.isEmpty) {
                            return SizedBox(
                              height: 44,
                              child: Center(child: CircularProgressIndicator(color: Colors.blue)),
                            );
                          } else if (state is CategoryErrorState) {
                            return Text(state.errorMessage);
                          }
                          final categories = state is CategorySucessState ? state.categories : cubit.categories;

                          if (categories.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return SizedBox(
                            height: 44,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return CategoryChip(
                                  label: categories[index].name ?? 'Category',
                                  isSelected: _selectedCategoryIndex == index,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                    final selectedCategoryId = categories[index].id;
                                    if (selectedCategoryId != null) {
                                      context.read<HomeCubit>().getProductsByCategory(selectedCategoryId);
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator(color: Colors.blue)),
                      ),
                    );
                  } else if (state is ProductErrorState) {
                    return SliverToBoxAdapter(
                      child: Padding(padding: const EdgeInsets.all(24), child: Text(state.errorMessage)),
                    );
                  } else if (state is ProductSucessState) {
                    final products = state.products;
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 16, mainAxisSpacing: 16),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return ProductCard(product: products[index]);
                        }, childCount: products.length),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
