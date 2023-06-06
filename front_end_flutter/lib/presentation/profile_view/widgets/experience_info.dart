import 'package:flutter/material.dart';

class ExperienceInfo extends StatelessWidget {
  const ExperienceInfo({Key? key}) : super(key: key);

  final double rating = 4.8;
  final int totalTrips = 150;
  final String joinedDate = 'SEPT 2022';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoBox('Rating', '$rating/5'),
        const SizedBox(width: 8),
        _buildInfoBox('Completed Trips', totalTrips.toString()),
        const SizedBox(width: 8),
        _buildInfoBox('Joined', joinedDate),
      ],
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFF222227),
        ),
        width: double.infinity,
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
      ),
    );
  }
}
