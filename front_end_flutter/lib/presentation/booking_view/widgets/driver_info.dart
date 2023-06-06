import 'package:flutter/material.dart';
import 'package:uni_drive/presentation/profile_view/profile_view.dart';

import '../../../models/ride.dart';

class DriverInfo extends StatelessWidget {
  final Ride ride;

  const DriverInfo(this.ride, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(ride.driverProfile.profilePictureUrl),
                radius: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ride.driverProfile.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ride.driverProfile.surname,
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
              Text((ride.driverProfile.rating).toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.car_rental, color: Colors.white), // todo missing car color hex in ride
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'carModel', // todo missing car model in ride
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'carColorString', // todo missing car color in ride
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, // todo missing car color hex in ride
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
                onPressed: () => _onProfilePressed(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Profile'),
              ),
              ElevatedButton(
                onPressed: _onMessagePressed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Icon(Icons.message),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _title() {
    return const Row(
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
    );
  }

  void _onProfilePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: const ProfileView(),
        ),
      ),
    );
  }

  void _onMessagePressed() {
    // todo
  }
}
