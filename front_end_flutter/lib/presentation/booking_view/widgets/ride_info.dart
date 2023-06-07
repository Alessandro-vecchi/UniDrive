import 'package:flutter/material.dart';

import '../../../models/ride.dart';

class RideInfo extends StatelessWidget {
  final Ride ride;

  const RideInfo(this.ride, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Ride Info', Icons.flag),
          const SizedBox(height: 8),
          _rowData('Destination', ride.destination),
          const SizedBox(height: 4),
          _rowData('Time', ride.departDatetime.toString()), //todo format time
          const SizedBox(height: 20),
          _title('Meeting Point', Icons.pin_drop),
          const SizedBox(height: 8),
          _rowData('Address', ride.meetingPoint.address),
          const SizedBox(height: 4),
          _rowData('Distance', ride.meetingPoint.distance),
          const SizedBox(height: 4),
          _rowData('Meeting Time', ride.meetingPoint.time),
          const SizedBox(height: 16),
          _seats(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Book Seat'),
          ),
        ],
      ),
    );
  }

  Row _seats() {
    return Row(
      children: [
        Row(
          children: List.generate(
            ride.availableSeats,
            (index) => Icon(
                index < (ride.carDetails.totSeats) - (ride.availableSeats) - 1
                    ? Icons.person
                    : Icons.person,
                color: index <
                        (ride.carDetails.totSeats) - (ride.availableSeats) - 1
                    ? Colors.grey
                    : Colors.green,
                size: 21),
          ),
        ),
      ],
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
}
