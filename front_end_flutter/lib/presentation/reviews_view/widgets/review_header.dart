import 'package:flutter/material.dart';

class ReviewsHeader extends StatelessWidget {
  final String fullName;
  final int totalReviews;
  final double averageRating;

  final int fiveStarReviews;
  final int fourStarReviews;
  final int threeStarReviews;
  final int twoStarReviews;
  final int oneStarReviews;

  const ReviewsHeader({
    Key? key,
    required this.fullName,
    required this.totalReviews,
    required this.averageRating,
    required this.fiveStarReviews,
    required this.fourStarReviews,
    required this.threeStarReviews,
    required this.twoStarReviews,
    required this.oneStarReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
            "$fullName's reviews",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "$totalReviews reviews",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white60,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle write a review button press
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 16,
              ),
            ),
            child: const Text('WRITE A REVIEW'),
          ),
          const SizedBox(height: 20),
          _buildReviewBar('5', fiveStarReviews, totalReviews),
          const SizedBox(height: 8),
          _buildReviewBar('4', fourStarReviews, totalReviews),
          const SizedBox(height: 8),
          _buildReviewBar('3', threeStarReviews, totalReviews),
          const SizedBox(height: 8),
          _buildReviewBar('2', twoStarReviews, totalReviews),
          const SizedBox(height: 8),
          _buildReviewBar('1', oneStarReviews, totalReviews),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReviewBar(String rating, int reviews, int totalReviews) {
    final double percentage = (reviews / totalReviews);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Row(
        children: [
          Text(rating),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
