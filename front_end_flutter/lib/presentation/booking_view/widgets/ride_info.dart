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
              const Row(
                children: [
                  Text(
                    'Ride Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.flag),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Destination:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      control.value?.destination ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'At:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(control.value?.departDatetime ?? ''),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: const Row(
                  children: [
                    Text(
                      'Meeting Point',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.pin_drop),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Address:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      control.value?.meetingPoint.latitude.toString() ?? '',//todo replace with address
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Distance:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(control.value?.meetingPoint.distance.toString() ?? ''), //todo format distance
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Meeting Time:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(control.value?.meetingPoint.meetingTime.toString() ?? ''), //todo format time
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      control.value?.availableSeats ?? 0,
                      (index) => Icon(index < (4) - (control.value?.availableSeats ?? 0) ? Icons.person : Icons.person, //todo missing totSeats
                          color: index < (4) - (control.value?.availableSeats ?? 0) ? Colors.grey : Colors.green, //todo missing totSeats
                          size: 21),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Book Seat'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
