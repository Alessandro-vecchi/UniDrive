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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          ReactiveTextField(
            formControlName: 'startingPosition',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter starting position',
              fillColor: Colors.white.withOpacity(0.1),
              filled: true,
              isDense: true,
              hintStyle:
              Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Text('Your current position')),
                      SizedBox(width: 8),
                      Icon(Icons.my_location)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Expanded(child: Text('University')), SizedBox(width: 8), Icon(Icons.map)],
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
