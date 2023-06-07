import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ride.dart';
import '../state/booking_view_cubit.dart';

class RideInfo extends StatelessWidget {
  final Ride ride;

  const RideInfo(this.ride, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is Booked) {
          _dialogBuilder(context);
        }
        if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking failed'),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title('Ride Info', Icons.flag),
                _seats(context),
              ],
            ),
            const SizedBox(height: 10),
            _rowData('Destination', ride.destination),
            const SizedBox(height: 6),
            _rowData('Time', ride.departDatetime.toString()),
            const SizedBox(height: 35),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_title('Meeting Point', Icons.pin_drop), _dropdown()],
            ),
            const SizedBox(height: 10),
            _rowData('Address', ride.meetingPoint.address),
            const SizedBox(height: 6),
            _rowData('Distance', ride.meetingPoint.distance),
            const SizedBox(height: 6),
            _rowData('Meeting Time', ride.meetingPoint.time),
            const SizedBox(height: 16),
            BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                return switch (state) {
                  BookingIdle() =>
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.read<BookingCubit>().bookRide(ride.id),
                          child: const Text('Book Seat'),
                        ),
                      ),
                  BookingOperationLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  Booked() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.read<BookingCubit>().cancelBooking(state.booking.id), // todo manca booking id?
                      child: const Text('Cancel Booking'),
                    ),
                  ),
                  BookingError() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.read<BookingCubit>().bookRide(ride.id),
                      child: const Text('Retry'),
                    ),
                  ),
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _seats(context) {
    return Row(
      children: List.generate(
        ride.availableSeats,
            (index) =>
            GestureDetector(
              onTap: () {
                _showSeatStatusDialog(context, index);
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.person,
                    color: index <
                        (ride.carDetails.totSeats) - (ride.availableSeats) - 1
                        ? Colors.grey
                        : Colors.green,
                    size: 30,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index <
                            (ride.carDetails.totSeats) -
                                (ride.availableSeats) -
                                1
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _showSeatStatusDialog(context, int seatIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final bool isOccupied =
            seatIndex < (ride.carDetails.totSeats) - (ride.availableSeats) - 1;
        final String seatStatus = isOccupied ? 'Occupied' : 'Available';
        final Color dotColor = isOccupied ? Colors.red : Colors.green;

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                color: dotColor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                seatStatus,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Row _rowData(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }

  Row _title(String title, IconData icon) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon),
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 48,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your booking was successful!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The ride has been added to your booking section. Check it out!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle "My Bookings" button press
                        Navigator.of(context).pop();
                      },
                      child: const Text('My bookings'),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -12,
                right: -12,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dropdown() {
    String selectedOption = 'Walking'; // Initial selected option

    return DropdownButton<String>(
      value: selectedOption,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white60),
      onChanged: (String? newValue) {
        if (newValue != null) {
          selectedOption = newValue;
        }
      },
      items: <String>['Walking', 'Driving', 'Cycling']
          .map<DropdownMenuItem<String>>((String value) {
        IconData icon;
        if (value == 'Walking') {
          icon = Icons.directions_walk;
        } else if (value == 'Driving') {
          icon = Icons.directions_car;
        } else {
          icon = Icons.directions_bike;
        }

        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }
}
