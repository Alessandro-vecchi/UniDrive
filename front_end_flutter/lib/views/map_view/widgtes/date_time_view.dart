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
            decoration: InputDecoration(
              fillColor: Colors.white.withOpacity(0.1),
              filled: true,
              isDense: true,
              hintStyle:
              Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
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
