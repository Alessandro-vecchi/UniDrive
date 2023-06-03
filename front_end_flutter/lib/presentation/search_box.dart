import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SearchBox extends StatelessWidget {
  final String formControlName;
  const SearchBox({super.key, required this.formControlName});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
      decoration: const InputDecoration(
        fillColor: Colors.white,
        hintText: 'Enter starting position',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Color.fromRGBO(34, 34, 39, 1)),
      ),
    );
  }
}
