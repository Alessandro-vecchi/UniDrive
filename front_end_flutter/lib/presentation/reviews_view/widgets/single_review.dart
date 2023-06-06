import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      // ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${review.name} ${review.surname}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _getFormattedDate(review.date),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(5, (index) {
                    if (index < review.rating) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      );
                    } else {
                      return const Icon(
                        Icons.star_border,
                        color: Colors.grey,
                        size: 16,
                      );
                    }
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.reviewBody,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(date) {
    return DateFormat('MMM dd yyyy').format(date);
  }
}
