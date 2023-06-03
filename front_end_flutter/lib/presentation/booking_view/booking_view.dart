import 'package:flutter/material.dart';

import 'widgets/driver_info.dart';
import 'widgets/ride_info.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222227),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RideInfo(),
          DriverInfo(),
        ],
      ),
    );
  }
}
