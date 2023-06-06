import 'package:flutter/material.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/single_review.dart';

import '../../../models/review.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final review in reviews)
            ReviewCard(
              name: review.name,
              surname: review.surname,
              date: review.date,
              rating: review.rating,
              reviewBody: review.reviewBody,
            ),
        ],
      ),
    );
  }
}
