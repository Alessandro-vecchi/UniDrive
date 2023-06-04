import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/ride.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<Ride>(
      formControlName: 'selectedRide',
      builder: (context, control, child) {
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
                    backgroundImage: NetworkImage(control.value?.driverProfile.profilePictureUrl ?? ''),
                    radius: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        control.value?.driverProfile.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        control.value?.driverProfile.surname ?? '',
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
                  Text((control.value?.driverProfile.rating ?? 0).toStringAsFixed(1)),
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
                    onPressed: _onProfilePressed,
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
      },
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

  void _onProfilePressed() {
    // todo
  }

  void _onMessagePressed() {
    // todo
  }
}
