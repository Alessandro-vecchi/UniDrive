import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  final String city = 'Roma';
  final String district = 'Monteverde';
  final String carModel = 'Citroen C3';
  final String carColor = 'White';
  final String licenseSince = '2019';
  final String instagramName = '@ale_vecchi';
  final String instagramUrlString = 'https://www.instagram.com/john_doe/';

  Future<void> _launchInstagramURL() async {
    Uri instagramUrl = Uri.parse(instagramUrlString);
    if (await canLaunchUrl(instagramUrl)) {
      await launchUrl(instagramUrl);
    } else {
      throw 'Could not launch Instagram URL: $instagramUrl';
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
              Text('$district, $city'),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            'assets/car_icon.png',
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$carModel - $carColor'),
                  Text('License since $licenseSince'),
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
                  instagramName,
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
