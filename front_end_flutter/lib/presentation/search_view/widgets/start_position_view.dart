import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/main.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

import '../../../services/ride_service.dart';

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
                  hintText: 'Enter your starting position',
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buttons(context),
      ],
    );
  }

  _getPosition() async {
    final userPosition = await Geolocator.getCurrentPosition();
    return userPosition;
  }

  Future<String> _getFormattedAddress() async {
    try {
      final userPosition = await _getPosition();
      final formattedAddress = await RideService()
          .getFA(userPosition.latitude, userPosition.longitude);
      return formattedAddress.substring(1, formattedAddress.length - 1);
    } catch (e) {
      print('Error occurred while getting formatted address: $e');
      return ''; // todo handle the error case as needed
    }
  }

  Future<List<String>> _getSuggestedPlaces(input) async {
    try {
      final userPosition = await _getPosition();
      final suggestedPlaces = await RideService()
          .autocomplete(input, userPosition.latitude, userPosition.longitude);
      return suggestedPlaces;
    } catch (e) {
      print('Error occurred while getting suggested places: $e');
      return ['']; // todo handle the error case as needed
    }
  }

  Row _buttons(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final formattedAddress = await _getFormattedAddress();
                ReactiveForm.of(context)?.patchValue({
                  'origin': formattedAddress,
                });
              } catch (e) {
                print('Error occurred while setting origin: $e');
                // todo Handle the error case as needed
              }
            },
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
            onPressed: () {
              ReactiveForm.of(context)?.patchValue({
                'origin': loggedInUser['University'] ?? '',
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
