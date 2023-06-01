import 'package:flutter/material.dart';

class RideInfo extends StatelessWidget {
  const RideInfo({Key? key}) : super(key: key);

  final String destination = 'Via dei Sommozzatori 1, 56100 Pisa PI';
  final String time = '10:00';
  final String meetingPointAddress = 'Meeting Point Address';
  final String meetingTime = '9:20';
  final String distance = '2.5 km';
  final int availableSeats = 2;
  final int totSeats = 4;

  @override
  Widget build(BuildContext context) {
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
                  destination,
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
              Text(time),
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
                  meetingPointAddress,
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
              Text(distance),
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
              Text(meetingTime),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Row(
                children: List.generate(
                  totSeats,
                  (index) => Icon(
                      index < totSeats - availableSeats
                          ? Icons.person
                          : Icons.person, //_outline
                      color: index < totSeats - availableSeats
                          ? Colors.grey
                          : Colors.green,
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
  }
}
