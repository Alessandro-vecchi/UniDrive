import 'package:flutter/cupertino.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/review_header.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/review_list.dart';

import '../../models/review.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //color: const Color(0xFF363ABE),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            ReviewsHeader(
                name: "Mario",
                surname: "Rossi",
                totalReviews: 95,
                averageRating: 4.2),
            SizedBox(height: 16),
            ReviewsList(reviews: reviews),
          ],
        ),
      ),
    );
  }
}

final List<Review> reviews = [
  Review(
    name: 'John',
    surname: 'Doe',
    date: DateTime(2023, 4, 27),
    rating: 5,
    reviewBody:
        'The driver was fantastic! Very punctual, friendly, and professional. The car was spotless and great. Highly recommended and would definitely use again!',
  ),
  Review(
    name: 'Jane',
    surname: 'Smith',
    date: DateTime(2023, 5, 15),
    rating: 4,
    reviewBody:
        'The driver was friendly and the car was clean and comfortable. The only downside was that, due to the traffic, the driver took a longer route and made the ride a bit longer. But still, a good experience overall!',
  ),
  Review(
      name: "Ale",
      surname: "Vecchi",
      date: DateTime(2023, 2, 7),
      rating: 3,
      reviewBody:
          "The driver was on time and got us to our destination safely. However, the car was a bit messy and had an unpleasant smell. Overall, an average experience."),
  Review(
    name: 'Jane',
    surname: 'Smith',
    date: DateTime(2023, 5, 15),
    rating: 4,
    reviewBody:
        'The driver was friendly and the car was clean and comfortable. The only downside was that, due to the traffic, the driver took a longer route and made the ride a bit longer. But still, a good experience overall!',
  ),
  Review(
    name: 'Jane',
    surname: 'Smith',
    date: DateTime(2023, 5, 15),
    rating: 4,
    reviewBody:
        'The driver was friendly and the car was clean and comfortable. The only downside was that, due to the traffic, the driver took a longer route and made the ride a bit longer. But still, a good experience overall!',
  ),
  Review(
    name: 'Jane',
    surname: 'Smith',
    date: DateTime(2023, 5, 15),
    rating: 4,
    reviewBody:
        'The driver was friendly and the car was clean and comfortable. The only downside was that, due to the traffic, the driver took a longer route and made the ride a bit longer. But still, a good experience overall!',
  ),
  Review(
    name: 'Jane',
    surname: 'Smith',
    date: DateTime(2023, 5, 15),
    rating: 4,
    reviewBody:
        'The driver was friendly and the car was clean and comfortable. The only downside was that, due to the traffic, the driver took a longer route and made the ride a bit longer. But still, a good experience overall!',
  ),
  // Add more reviews here...
];
