import 'package:flutter/material.dart';
import '../models/product_review.dart';

class ProductReviewProvider extends ChangeNotifier {
  final Map<String, List<ProductReview>> _reviewsByProduct = {};

  List<ProductReview> reviewsOf(String productId) {
    return _reviewsByProduct[productId] ?? [];
  }

  void addReview({
    required String productId,
    required double rating,
    required String comment,
  }) {
    final review = ProductReview(
      productId: productId,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    _reviewsByProduct.putIfAbsent(productId, () => []);
    _reviewsByProduct[productId]!.add(review);

    notifyListeners();
  }
}
