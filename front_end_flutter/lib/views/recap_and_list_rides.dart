import 'package:flutter/material.dart';

import 'list_cards.dart';
import 'recap.dart';

class CombinedPage extends StatelessWidget {
  const CombinedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Recap(),
          SizedBox(height: 16), // Add spacing between the two widgets
          Expanded(
            child: SizedBox(
              height: 200.0,
              child: RideCardList(),
            ),
          ),
        ],
      ),
    );
  }
}
