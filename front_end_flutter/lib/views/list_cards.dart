import 'package:flutter/material.dart';

// Define a single ride card
class RideCard extends StatelessWidget {
  const RideCard({super.key});

  // Define the rating as a member variable
  final double rating = 3.3;

  List<Widget> buildStars(double rating) {
    int fullStars = rating.round();
    List<Widget> starWidgets = List<Widget>.generate(
        fullStars, (_) => Icon(Icons.star, color: Colors.yellow, size: 20));

    int halfStar = 0;
    if (rating - fullStars >= 0.25) {
      halfStar = 1;
      starWidgets.add(Icon(Icons.star_half, color: Colors.yellow, size: 20));
    }

    int emptyStars = 5 - fullStars - halfStar;
    starWidgets.addAll(List<Widget>.generate(emptyStars,
        (_) => Icon(Icons.star_border, color: Colors.yellow, size: 20)));

    return starWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Color.fromRGBO(34, 34, 39, 1), // Set the card background color
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
          radius: 30,
        ),
        title: Row(
          children: [
            Text("Mario Rossi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(width: 6),
            // Add some space between name and stars
            ...buildStars(rating),
            //Icon(Icons.star_border, color: Colors.yellow, size: 20),
            //const SizedBox(width: 3), // Add some space between stars and rating
            //Text("4.7", style: TextStyle(color: Colors.yellow)),
          ],
        ),
        subtitle: Text("Meet at 70m"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "81 min",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class RideCardList extends StatelessWidget {
  const RideCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return RideCard();
      },
    );
  }
}
