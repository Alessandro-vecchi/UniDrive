import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'startingPosition',
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Enter starting position',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Color.fromRGBO(34, 34, 39, 1)),
      ),
    );
  }
}
