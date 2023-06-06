import 'package:flutter/material.dart';

class RecentReviewsContainer extends StatelessWidget {
  const RecentReviewsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recent Reviews',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              // const Text('See All'),
              // const SizedBox(width: 4),
              IconButton(
                onPressed: () {
                  // Handle See All button press
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
