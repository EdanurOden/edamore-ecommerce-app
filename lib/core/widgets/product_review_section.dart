import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/providers/review_provider.dart';
import '../../data/models/review.dart';
import '../../features/product/review_dialog.dart';

class ProductReviewSection extends StatelessWidget {
  final String productId;

  const ProductReviewSection({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewProvider>(
      builder: (context, reviewProvider, child) {
        final reviews = reviewProvider.reviewsByProduct(productId);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YORUM YAP BUTONU
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ReviewDialog(productId: productId),
                  );
                },
                child: const Text('DEĞERLENDİRME YAP'),
              ),
            ),

            const SizedBox(height: 16),

            // HENÜZ YORUM YOK
            if (reviews.isEmpty)
              const Text(
                'Bu ürün için henüz yorum yapılmamış.',
                style: TextStyle(color: Colors.grey),
              ),

            // YORUM KARTLARI
            for (final review in reviews) ...[
              _ReviewCard(review: review),
              const SizedBox(height: 12),
            ],
          ],
        );
      },
    );
  }
}

// TEK BİR YORUM KARTI
class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.showName ? 'Kullanıcı' : 'Anonim',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RatingBarIndicator(
                rating: review.rating,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                itemSize: 16,
                itemCount: 5,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // FOTOĞRAF
          if (review.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                File(review.imagePath!),
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          if (review.imagePath != null) const SizedBox(height: 8),

          // YORUM
          Text(review.comment, style: TextStyle(color: Colors.grey[800])),

          const SizedBox(height: 8),

          // TARİH
          Text(
            '${review.createdAt.day}.${review.createdAt.month}.${review.createdAt.year}',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
