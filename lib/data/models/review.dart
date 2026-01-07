class Review {
  final String id;
  final String productId;
  final double rating;
  final String comment;
  final bool showName;
  final String? imagePath;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.showName,
    this.imagePath,
    required this.createdAt,
  });
}
