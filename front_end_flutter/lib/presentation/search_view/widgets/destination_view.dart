import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/main.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({
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
                'Where do you want to go?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              ReactiveTextField(
                formControlName: 'destination',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter a destination',
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buttons(context),
      ],
    );
  }

  Row _buttons(context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ReactiveForm.of(context)?.patchValue({
                'destination': loggedInUser['Home'] ?? '',
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF222227),
              minimumSize:
                  const Size(double.infinity, kMinInteractiveDimension),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text('Home')),
                SizedBox(width: 8),
                Icon(Icons.home)
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ReactiveForm.of(context)?.patchValue({
                'destination': loggedInUser['University'] ?? '',
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF222227),
              minimumSize:
                  const Size(double.infinity, kMinInteractiveDimension),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text('University')),
                SizedBox(width: 8),
                Icon(Icons.work)
              ],
            ),
          ),
        )
      ],
    );
  }
}
