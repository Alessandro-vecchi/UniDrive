import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  final Widget child;
  const SearchContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222227),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
