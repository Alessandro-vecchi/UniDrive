import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/models/search_model.dart';

import '../../search_box.dart';

class Recap extends StatefulWidget {
  final SearchModel searchModel;

  const Recap({super.key, required this.searchModel});

  @override
  State<Recap> createState() => _Recap();
}

class _Recap extends State<Recap> {
  final _form = FormGroup({
    'destination': FormControl<String>(validators: [Validators.required]),
    'origin': FormControl<String>(validators: [Validators.required]),
    'date': FormControl<DateTime>(validators: [Validators.required]),
    'time': FormControl<TimeOfDay>(validators: [Validators.required]),
  });

  @override
  void initState() {
    super.initState();
    _form.patchValue({
      'destination': widget.searchModel.destination,
      'origin': widget.searchModel.origin,
      'date': widget.searchModel.date,
      'time': TimeOfDay.fromDateTime(widget.searchModel.date),
    });
  }

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
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'From',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: SearchBox(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'To',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: SearchBox(),
                    ),
                  ],
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
                      child: ReactiveTextField(
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
                      child: ReactiveTextField(
                        formControlName: 'date',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                        decoration: const InputDecoration(
                          hintText: 'Enter date',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 12), // Set the color of the hintText
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
