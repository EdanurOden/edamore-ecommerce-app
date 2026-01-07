import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/product_review_provider.dart';

class ProductReviewDialog extends StatefulWidget {
  final String productId;

  const ProductReviewDialog({super.key, required this.productId});

  @override
  State<ProductReviewDialog> createState() => _ProductReviewDialogState();
}

class _ProductReviewDialogState extends State<ProductReviewDialog> {
  double _rating = 0;
  final _controller = TextEditingController();

  void _submit() {
    if (_rating == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lütfen puan verin")));
      return;
    }

    context.read<ProductReviewProvider>().addReview(
      productId: widget.productId,
      rating: _rating,
      comment: _controller.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Değerlendirme Yap",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            RatingBar.builder(
              itemCount: 5,
              allowHalfRating: true,
              itemBuilder: (_, __) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (value) {
                setState(() => _rating = value);
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Yorumunuzu yazın",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text("Gönder"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
