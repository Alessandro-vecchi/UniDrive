import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
          _buildRow(context, "From", "origin"),
          const SizedBox(height: 8),
          _buildRow(context, "To", 'destination'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: _label(context, "At"),
              ),
              Expanded(
                flex: 1,
                child: _timePicker(context),
              ),
              Expanded(
                flex: 1,
                child: _label(context, "On"),
              ),
              Expanded(
                flex: 1,
                child: _datePicker(context),
              ),
              Expanded(
                flex: 2,
                child: _radius(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String formName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
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
        Expanded(
          flex: 5,
          child: SearchBox(formControlName: formName),
        )
      ],
    );
  }

  Widget _label(context, title) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _timePicker(context) {
    return TimePickerField(
      formControlName: "time",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black,
          ),
      decoration: const InputDecoration(
        hintText: "Enter time",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        filled: true,
        fillColor: Colors.white,
      ),
      label: "Time",
    );
  }

  Widget _datePicker(context) {
    return DatePickerField(
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
    );
  }

  Widget _radius(context) {
    return SizedBox(
      height: kMinInteractiveDimension,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReactiveValueListenableBuilder(
            formControlName: 'radius',
            builder: (context, control, child) {
              return Text(
                'Radius: ${control.value} km',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
          Expanded(
            child: ReactiveSlider(
              formControlName: 'radius',
              min: 0,
              max: 4,
              divisions: 10,
              labelBuilder: (value) => '${value.toInt()} km',
            ),
          ),
        ],
      ),
    );
  }
}
