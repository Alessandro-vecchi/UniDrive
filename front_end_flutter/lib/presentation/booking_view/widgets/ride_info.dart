import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/ride.dart';

class RideInfo extends StatelessWidget {
  const RideInfo({Key? key}) : super(key: key);

  // final String destination = 'Via dei Sommozzatori 1, 56100 Pisa PI';
  // final String time = '10:00';
  // final String meetingPointAddress = 'Meeting Point Address';
  // final String meetingTime = '9:20';
  // final String distance = '2.5 km';
  // final int availableSeats = 2;
  // final int totSeats = 4;

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<Ride>(
      formControlName: 'selectedRide',
      builder: (context, control, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Ride Info', Icons.flag),
              const SizedBox(height: 8),
              _rowData('Destination', control.value?.destination ?? ''),
              const SizedBox(height: 4),
              _rowData('Time', control.value?.departDatetime.toString() ?? ''), //todo format time
              const SizedBox(height: 20),
              _title('Meeting Point', Icons.pin_drop),
              const SizedBox(height: 8),
              _rowData('Address', control.value?.meetingPoint.latitude.toString() ?? ''), //todo replace with address
              const SizedBox(height: 4),
              _rowData('Distance', control.value?.meetingPoint.distance.toString() ?? ''), //todo format distance
              const SizedBox(height: 4),
              _rowData('Meeting Time', control.value?.meetingPoint.meetingTime.toString() ?? ''), //todo format time
              const SizedBox(height: 16),
              _seats(control),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Book Seat'),
              ),
            ],
          ),
        );
      },
    );
  }

  Row _seats(AbstractControl<Ride> control) {
    return Row(
      children: [
        Row(
          children: List.generate(
            control.value?.availableSeats ?? 0,
            (index) => Icon(index < (4) - (control.value?.availableSeats ?? 0) ? Icons.person : Icons.person,
                //todo missing totSeats
                color: index < (4) - (control.value?.availableSeats ?? 0) ? Colors.grey : Colors.green,
                //todo missing totSeats
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
