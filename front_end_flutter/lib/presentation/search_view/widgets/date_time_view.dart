import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/presentation/search_view/widgets/search_container.dart';

import '../../form_fields/date_time_picker_field.dart';

class DateTimeView extends StatelessWidget {
  const DateTimeView({
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
                'When do you need this ride?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              DateTimePickerField(
                dateFormControlName: 'date',
                timeFormControlName: 'time',
                dateLabel: 'Date',
                timeLabel: 'At',
                firstDate: DateTime.now(),
                lastDate: DateTime(9999, 12, 9),
                languageCode: 'en',
                dateDecoration: const InputDecoration(
                  hintText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                timeDecoration: const InputDecoration(
                  hintText: 'Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            ReactiveForm.of(context)?.patchValue({
              'date': DateTime.now(),
              'time': TimeOfDay.now(),
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF222227),
            minimumSize: const Size(double.infinity, kMinInteractiveDimension),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Text('Now')),
              SizedBox(width: 8),
              Icon(Icons.access_time)
            ],
          ),
        ),
      ],
    );
  }
}
