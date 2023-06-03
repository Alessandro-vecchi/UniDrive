import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

class StartPositionView extends StatelessWidget {
  const StartPositionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchContainer(
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
                formControlName: 'origin',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter starting position',
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buttons(),
      ],
    );
  }

  Row _buttons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF222227),
              minimumSize:
                  const Size(double.infinity, kMinInteractiveDimension),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'Your current position',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(width: 8),
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
              backgroundColor: const Color(0xFF222227),
              minimumSize:
                  const Size(double.infinity, kMinInteractiveDimension),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'University',
                    style:
                        TextStyle(fontSize: 13), // This reduces the font size
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
    );
  }
}