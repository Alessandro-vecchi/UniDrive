import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

import '../../../services/ride_service.dart';

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
                onChanged: (value) async {
                  // Call the backend API with the entered value
                  // and update the suggestions list
                  final suggestions = await _getSuggestedPlaces(value);
                  form.control('suggestions').value = suggestions;
                },
              ),
              StreamBuilder<List<String>>(
                stream: form.control('suggestions').valueStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Suggested Places:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Text(
                              snapshot.data![index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
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
      print('Error occurred while getting suggested places: $e');
      return ['']; // todo handle the error case as needed
    }
  }

  Expanded _button(BuildContext context, String label, IconData icon) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          final loggedInUser = {}; // Replace with actual user data
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
