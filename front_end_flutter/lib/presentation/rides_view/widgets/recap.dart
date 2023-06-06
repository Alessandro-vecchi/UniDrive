import 'package:flutter/material.dart';
import 'package:uni_drive/presentation/form_fields/time_picker_field.dart';

import '../../form_fields/date_picker_field.dart';
import '../../search_box.dart';

class Recap extends StatelessWidget {
  const Recap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildRow(
            context,
            "From",
            const Expanded(
              flex: 5,
              child: SearchBox(formControlName: 'origin'),
            ),
          ),
          const SizedBox(height: 8),
          _buildRow(
            context,
            "to",
            const Expanded(
              flex: 5,
              child: SearchBox(formControlName: 'destination'),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Arrive By',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: TimePickerField(
                  formControlName: 'time',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                  decoration: const InputDecoration(
                    hintText: 'Enter time',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  label: 'Time',
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'On',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: DatePickerField(
                  formControlName: 'date',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                  decoration: const InputDecoration(
                    hintText: 'Enter date',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(9999, 12, 31),
                  label: 'Date',
                  languageCode: 'en',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: title == 'From' ? Colors.white : null,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
