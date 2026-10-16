import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final int productId;
  const ShareProductButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final String productLink = 'https://product-links.moataz-mahmoad.workers.dev/products/$productId';
        final String shareMessage = "Look at this product: $productLink";
        await SharePlus.instance.share(ShareParams(text: shareMessage , subject: "check out this product on Huma Volve"));
      },
      icon: Icon(Icons.share),
    );
  }
}
