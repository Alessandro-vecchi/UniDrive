import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'search_destination_inner_container.dart';

class StartPositionView extends StatelessWidget {
  const StartPositionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchDestinationInnerContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is your starting position?',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          ReactiveTextField(
            formControlName: 'startingPosition',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter starting position',
              suffixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          2), // This adds a rounded corner
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          'Your current position',
                          style: TextStyle(
                              fontSize: 13), // This reduces the font size
                        ),
                      ),
                      SizedBox(width: 8),
                      // This reduces the space between the text and the icon
                      Icon(Icons.my_location)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // This reduces the space between the buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          2), // This adds a rounded corner
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          'University',
                          style: TextStyle(
                              fontSize: 13), // This reduces the font size
                        ),
                      ),
                      SizedBox(width: 8),
                      // This reduces the space between the text and the icon
                      Icon(Icons.map)
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
