import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/home_icon.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text('$district, $city'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // const Icon(Icons.car_crash),
              Image.asset(
                'assets/car_icon.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$carModel - $carColor'),
                  Text('License since $licenseSince'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'assets/instagram_icon.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
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
