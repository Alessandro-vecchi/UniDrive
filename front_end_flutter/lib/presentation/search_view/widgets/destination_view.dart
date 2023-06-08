import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

import '../../../main.dart';
import '../../../services/ride_service.dart';
import '../../form_fields/autocomplete/enel_reactive_autocomplete_field.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key? key}) : super(key: key);

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  // IconData suffixIcon = Icons.search;

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
              ReactiveAutocompleteField<String>(
                formControlName: 'destination',
                suggestionItemsSearch: (pattern) async {
                  final suggestions = await _getSuggestedPlaces(pattern);
                  return suggestions;
                },
                suggestionItemsBuilder: (suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                suggestionToString: (suggestion) => suggestion,
                hint: 'Enter a destination',
                suffixIcon: const Icon(Icons.search, color: Colors.white),
                /*onChanged: (value) {
                  if (value == null || value.isEmpty) {
                    suffixIcon = Icons.search;
                  } else {
                    suffixIcon = Icons.clear;
                  }
                },*/
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _button(context, 'Home', Icons.home),
            const SizedBox(width: 8),
            _button(context, 'University', Icons.work),
          ],
        )
      ],
    );
  }

  _getPosition() async {
    final userPosition = await Geolocator.getCurrentPosition();
    return userPosition;
  }

  Future<List<String>> _getSuggestedPlaces(input) async {
    try {
      final userPosition = await _getPosition();
      final suggestedPlaces = await RideService()
          .autocomplete(input, userPosition.latitude, userPosition.longitude);
      return suggestedPlaces;
    } catch (e) {
      log('Error occurred while getting suggested places: $e');
      return ['']; // todo handle the error case as needed
    }
  }

  Expanded _button(BuildContext context, String label, IconData icon) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // Replace with actual user data
          ReactiveForm.of(context)?.patchValue({
            'destination': loggedInUser[label] ?? '',
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF222227),
          minimumSize: const Size(double.infinity, kMinInteractiveDimension),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Text(label)),
            const SizedBox(width: 8),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
