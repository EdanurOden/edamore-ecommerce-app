import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/models/review.dart';
import '../../data/providers/review_provider.dart';

class ReviewDialog extends StatefulWidget {
  final String productId;

  const ReviewDialog({super.key, required this.productId});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 0;
  bool _showName = true;
  File? _imageFile;
  final _commentController = TextEditingController();

  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submit() {
    if (_rating == 0 || _commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Puan ve yorum zorunludur')));
      return;
    }

    final review = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: widget.productId,
      rating: _rating,
      comment: _commentController.text.trim(),
      showName: _showName,
      imagePath: _imageFile?.path,
      createdAt: DateTime.now(),
    );

    context.read<ReviewProvider>().addReview(review);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DEĞERLENDİRME YAP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // YILDIZ
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 32,
                unratedColor: Colors.grey[300],
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // İSİM GÖRÜNSÜN MÜ
              const Text('Yorumda isminiz görünsün mü?'),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _showName,
                    onChanged: (v) => setState(() => _showName = v!),
                  ),
                  const Text('Evet'),
                  Radio<bool>(
                    value: false,
                    groupValue: _showName,
                    onChanged: (v) => setState(() => _showName = v!),
                  ),
                  const Text('Hayır'),
                ],
              ),

              const SizedBox(height: 12),

              // RESİM SEÇ
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image_outlined),
                  label: const Text(
                    'Resim Seç',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // YORUM
              TextField(
                controller: _commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Yorum',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // GÖNDER
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _submit,
                  child: const Text('GÖNDER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
