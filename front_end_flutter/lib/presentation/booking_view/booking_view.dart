import 'package:flutter/material.dart';

import 'widgets/driver_info.dart';
import 'widgets/ride_info.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: RideInfo(),
            ),
            Expanded(
              flex: 1,
              child: DriverInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
