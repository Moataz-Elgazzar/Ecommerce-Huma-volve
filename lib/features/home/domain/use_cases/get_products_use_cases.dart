import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/home_products_entities.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repositories.dart';

class GetProductsUseCases {
  final HomeRepositories homeRepositories;
  const GetProductsUseCases(this.homeRepositories);

  static const String _fallbackImage = 'https://placehold.co/600x600/png?text=Product';

  static final RegExp _urlRegex = RegExp(r'https?://[^\s"\[\]\\]+');
  static final RegExp _trailingCharsRegex = RegExp(r'[,.]+$');

  Future<Either<Failure, List<HomeProductsEntities>>> invoke(int? id, {required int limit, required int offset}) async {
    final result = await homeRepositories.getProducts(id, limit: limit, offset: offset);
    return result.map((products) {
      return products.map((product) {
        final validImages = _extractValidImageUrls(product.images ?? []);
        
        
        return product.copyWith(
          images: validImages.isNotEmpty ? validImages : [_fallbackImage],
        );
      }).toList();
    });
  }

  List<String> _extractValidImageUrls(List<String> rawImages) {
    final List<String> validUrls = [];

    for (final raw in rawImages) {
      final str = raw.trim();
      if (str.isEmpty) continue;

      for (final match in _urlRegex.allMatches(str)) {
        final url = match.group(0)?.replaceAll(_trailingCharsRegex, '').trim();

        if (url != null && _isValidImageUrl(url)) {
          validUrls.add(url);
        }
      }
    }

    return validUrls;
  }

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || !uri.isAbsolute) return false;

    return (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
  }
}
