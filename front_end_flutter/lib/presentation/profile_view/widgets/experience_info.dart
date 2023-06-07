import 'package:flutter/material.dart';

import '../../../models/profile.dart';

class ExperienceInfo extends StatelessWidget {
  final Profile profile;

  const ExperienceInfo(this.profile, {super.key});

  final double rating = 4.8;
  final String joinedDate = 'SEPT 2022';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoBox('Rating', '${profile.rating}/5'), //todo missing rating
        const SizedBox(width: 8),
        _buildInfoBox('Completed Trips', profile.totalRidesGiven.toString()),
        const SizedBox(width: 8),
        _buildInfoBox('Joined', profile.joinedIn),
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
