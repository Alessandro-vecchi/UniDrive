import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'date_time_view.dart';
import 'destination_view.dart';
import 'start_position_view.dart';

class SearchView extends StatefulWidget {
  final VoidCallback onClose;

  const SearchView({super.key, required this.onClose});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _form = FormGroup({
    'destination': FormControl<String>(validators: [Validators.required]),
    'startingPosition': FormControl<String>(validators: [Validators.required]),
    'date': FormControl<DateTime>(validators: [Validators.required]),
    'time': FormControl<TimeOfDay>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF222227),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Hi user,',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const DestinationView(),
                const SizedBox(height: 8),
                const StartPositionView(),
                const SizedBox(height: 8),
                const DateTimeView(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: widget.onClose,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
