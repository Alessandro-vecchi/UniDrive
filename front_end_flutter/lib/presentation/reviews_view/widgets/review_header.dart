import 'package:flutter/material.dart';

class ReviewsHeader extends StatelessWidget {
  const ReviewsHeader({
    Key? key,
    required this.name,
    required this.surname,
    required this.totalReviews,
    required this.averageRating,
  }) : super(key: key);

  final String name;
  final String surname;
  final int totalReviews;
  final double averageRating;

  final int fiveStarReviews = 45;
  final int fourStarReviews = 30;
  final int threeStarReviews = 10;
  final int twoStarReviews = 5;
  final int oneStarReviews = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            "$name $surname's reviews",
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
          SizedBox(
            width: 240, // Adjust the width as needed
            child: Column(
              children: [
                _buildReviewBar('5', fiveStarReviews, totalReviews),
                const SizedBox(height: 8),
                _buildReviewBar('4', fourStarReviews, totalReviews),
                const SizedBox(height: 8),
                _buildReviewBar('3', threeStarReviews, totalReviews),
                const SizedBox(height: 8),
                _buildReviewBar('2', twoStarReviews, totalReviews),
                const SizedBox(height: 8),
                _buildReviewBar('1', oneStarReviews, totalReviews),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewBar(String rating, int reviews, int totalReviews) {
    final double percentage = (reviews / totalReviews);
    return Row(
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
    );
  }
}
