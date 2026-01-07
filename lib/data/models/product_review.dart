class ProductReview {
  final String productId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  ProductReview({
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}
