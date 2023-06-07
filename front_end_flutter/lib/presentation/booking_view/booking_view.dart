import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_drive/presentation/booking_view/state/booking_view_cubit.dart';

import '../../models/ride.dart';
import 'widgets/driver_info.dart';
import 'widgets/ride_info.dart';

class BookingView extends StatelessWidget {
  final Ride ride;

  const BookingView(this.ride, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>(
      create: (context) => BookingCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF222227),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              RideInfo(ride),
              const Divider(color: Colors.white),
              DriverInfo(ride),
            ],
          ),
        ),
      ),
    );
  }
}
