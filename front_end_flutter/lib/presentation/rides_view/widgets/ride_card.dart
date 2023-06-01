import 'package:flutter/material.dart';

import '../../../models/ride.dart';

class RideCard extends StatelessWidget {
  final Ride ride;

  const RideCard({super.key, required this.ride});

  List<Widget> buildStars(double rating) {
    int fullStars = rating.round();
    List<Widget> starWidgets = List<Widget>.generate(
      fullStars,
      (_) => const Icon(Icons.star, color: Colors.yellow, size: 20),
    );

    int halfStar = 0;
    if (rating - fullStars >= 0.25) {
      halfStar = 1;
      starWidgets.add(
        const Icon(Icons.star_half, color: Colors.yellow, size: 20),
      );
    }

    int emptyStars = 5 - fullStars - halfStar;
    starWidgets.addAll(
      List<Widget>.generate(
        emptyStars,
        (_) => const Icon(Icons.star_border, color: Colors.yellow, size: 20),
      ),
    );

    return starWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: const Color.fromRGBO(34, 34, 39, 1),
      // Set the card background color
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
            //todo
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          ),
          radius: 30,
        ),
        title: Wrap(
          spacing: 6,
          children: [
            Text(
              "${ride.driverProfile.name} ${ride.driverProfile.surname}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: buildStars(3), //todo
            ),
          ],
        ),
        subtitle: const Text("Meet at 70m"),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "81 min",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
