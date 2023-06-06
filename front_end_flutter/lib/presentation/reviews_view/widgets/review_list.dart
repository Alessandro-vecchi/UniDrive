import 'package:flutter/material.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/single_review.dart';

import '../../../models/review.dart';

class ReviewsList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsList(this.reviews, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => ReviewCard(reviews[index]),
    );
  }
}
