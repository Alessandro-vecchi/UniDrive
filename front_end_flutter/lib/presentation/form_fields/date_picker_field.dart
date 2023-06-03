import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DatePickerField extends StatelessWidget {
  final String formControlName;
  final String label;
  final DateTime firstDate;
  final DateTime lastDate;
  final String languageCode;
  final String? tooltipTitle;
  final String? tooltipDescription;
  final InputDecoration decoration;
  final TextStyle? style;

  const DatePickerField({
    Key? key,
    required this.formControlName,
    required this.firstDate,
    required this.lastDate,
    required this.label,
    required this.languageCode,
    this.tooltipTitle,
    this.tooltipDescription,
    this.decoration = const InputDecoration(),
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveDatePicker<DateTime>(
      builder: (context, picker, child) {
        return Semantics(
          label: 'Date',
          child: ReactiveTextField<DateTime>(
            formControlName: formControlName,
            readOnly: true,
            style: style,
            onTap: (_) => picker.showPicker(),
            valueAccessor: DateTimeValueAccessor(
              dateTimeFormat: DateFormat.yMd(),
            ),
            decoration: decoration,
          ),
        );
      },
      formControlName: formControlName,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}
