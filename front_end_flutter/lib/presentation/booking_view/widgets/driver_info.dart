import 'package:flutter/material.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});

  /*const DriverInfo({
    Key? key,
    required this.profilePictureUrl,
    required this.name,
    required this.surname,
    required this.rating,
    required this.carModel,
    required this.carColor,
    this.onProfilePressed,
    this.onMessagePressed,
  }) : super(key: key);*/

  final String profilePictureUrl = 'https://picsum.photos/200/300';
  final String name = 'Mario';
  final String surname = 'Rossi';
  final double rating = 4.5;
  final String carModel = 'Tesla Model S';
  final String carColorString = 'Black';
  final VoidCallback? onProfilePressed = null;
  final VoidCallback? onMessagePressed = null;

  @override
  Widget build(BuildContext context) {
    Color carColor = Colors.white;
    // if (carColorString.isNotEmpty) {
    //   carColor = Color(int.parse('0x$carColorString'));
    // }
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Driver Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.info_outline),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePictureUrl),
                radius: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    surname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 8),
              Text(rating.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.car_rental, color: carColor),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carModel,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    carColorString,
                    style: TextStyle(
                      fontSize: 14,
                      color: carColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onProfilePressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF363ABE),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), // Set the icon color of the button
                ),
                child: const Text('Profile'),
              ),
              ElevatedButton(
                onPressed: onMessagePressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF363ABE),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ), // Set the icon color of the button
                ),
                child: const Icon(Icons.message),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
