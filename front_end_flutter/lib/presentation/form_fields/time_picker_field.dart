// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:reactive_forms/reactive_forms.dart';


class TimePickerField extends StatelessWidget {
  final String formControlName;
  final String label;
  final String? tooltipTitle;
  final String? tooltipDescription;
  final InputDecoration decoration;
  final TextStyle? style;

  const TimePickerField({
    required this.formControlName,
    required this.label,
    this.tooltipTitle,
    this.tooltipDescription,
    this.decoration = const InputDecoration(),
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTimePicker(
      formControlName: formControlName,
      builder: (context, picker, child) {
        return ReactiveTextField<TimeOfDay>(
          formControlName: formControlName,
          readOnly: true,
          style: style,
          onTap: (_) => picker.showPicker(),
          valueAccessor: TimeOfDayValueAccessor(),
          decoration: decoration,
        );
      },
    );
  }
}
