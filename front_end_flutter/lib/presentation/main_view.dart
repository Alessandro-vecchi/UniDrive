import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/review_header.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/review_list.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/single_review.dart';

import '../models/review.dart';
import 'map_view/map_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.transparent,
        selectedBackgroundColor: const Color(0xFF363ABE),
        selectedItemColor: Colors.white,
        currentIndex: _pageIndex,
        onTap: (value) => setState(() => _pageIndex = value),
        items: [
          FloatingNavbarItem(
            //icon: const IconData(0xF013d, fontFamily: 'MaterialIcons'),
            icon: FontAwesomeIcons.magnifyingGlassLocation,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.list,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.message,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.user,
          ),
        ],
      ),
      body: IndexedStack(index: _pageIndex, children: [
        MapView(),
        ReviewsHeader(
            name: "Mario",
            surname: "Rossi",
            totalReviews: 95,
            averageRating: 4.2),
        // DriverInfo(),
        ReviewCard(
            name: "Ale",
            surname: "Vecchi",
            date: DateTime.now(),
            rating: 4,
            reviewBody:
                "The driver was on time and got us to our destination safely. However, the car was a bit messy and had an unpleasant smell. Overall, an average experience."),
        // RideInfo(),
        // PersonalInfoWidget(),

        ReviewsList(reviews: reviews),
      ]),
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
