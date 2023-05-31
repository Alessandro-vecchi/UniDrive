import 'package:flutter/material.dart';

import '../../../form_fields/date_time_picker_field.dart';
import 'search_destination_inner_container.dart';

class DateTimeView extends StatelessWidget {
  const DateTimeView({
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
            'When do you need this ride?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
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
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Expanded(child: Text('Now')), SizedBox(width: 8), Icon(Icons.access_time)],
            ),
          ),
        ],
      ),
    );
  }
}
