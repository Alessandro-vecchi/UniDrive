import 'package:flutter/material.dart';

import 'widgets/driver_info.dart';
import 'widgets/ride_info.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              flex: 11,
              child: RideInfo(),
            ),
            Container(
              width: 1,
              // color: Colors.grey,
            ),
            const Expanded(
              flex: 9,
              child: DriverInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
