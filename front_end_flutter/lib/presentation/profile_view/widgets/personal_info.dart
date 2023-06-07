import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/profile.dart';

class PersonalInfo extends StatelessWidget {
  final Profile profile;
  const PersonalInfo(this.profile, {super.key});

  final String licenseSince = '2019';

  Future<void> _launchInstagramURL() async {
    Uri instagramUrl = Uri.parse(profile.instagramUrl);
    if (await canLaunchUrl(instagramUrl)) {
      await launchUrl(instagramUrl);
    } else {
      log('Could not launch Instagram URL: $instagramUrl');
    }
  }

  Widget _buildInfoRow(String imageAsset, List<Widget> children) {
    return Row(
      children: [
        Image.asset(
          imageAsset,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 8),
        ...children,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF222227),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            'assets/home_icon.png',
            [
              Text('${profile.city} - ${profile.district}'),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            'assets/car_icon.png',
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${profile.carDetails.carModel} - ${profile.carDetails.carColor}'),
                  Text('License since ${profile.carDetails.licenseSince}'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            'assets/instagram_icon.png',
            [
              GestureDetector(
                onTap: _launchInstagramURL,
                child: Text(
                  profile.instagramName,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
