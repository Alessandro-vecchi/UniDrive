import 'package:flutter/material.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({Key? key}) : super(key: key);

  final double rating = 4.8;
  final int totalTrips = 150;
  final String joinedDate = 'SEPT 2022';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoBox('Rating', '$rating/5'),
        _buildInfoBox('Completed Trips', totalTrips.toString()),
        _buildInfoBox('Joined', joinedDate),
      ],
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
