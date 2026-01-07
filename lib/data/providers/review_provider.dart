import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewProvider extends ChangeNotifier {
  final List<Review> _reviews = [];

  /// Ürüne ait yorumlar
  List<Review> reviewsByProduct(String productId) {
    return _reviews.where((r) => r.productId == productId).toList();
  }

  /// Yorum ekle
  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }

  /// Ortalama puan
  double averageRating(String productId) {
    final productReviews = reviewsByProduct(productId);
    if (productReviews.isEmpty) return 0;

    final total = productReviews.fold<double>(0, (sum, r) => sum + r.rating);

    return double.parse((total / productReviews.length).toStringAsFixed(1));
  }

  /// Yorum sayısı
  int reviewCount(String productId) {
    return reviewsByProduct(productId).length;
  }
}
