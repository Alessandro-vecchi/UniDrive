import 'package:flutter/material.dart';

class SearchDestinationInnerContainer extends StatelessWidget {
  final Widget child;
  const SearchDestinationInnerContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
