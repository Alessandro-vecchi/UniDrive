// lib/models/ride.dart
class Ride {
  final String id;
  final String origin;
  final String destination;
  final String departDatetime;
  final String driverName;
  final String driverId;
  final int availableSeats;

  Ride({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departDatetime,
    required this.driverName,
    required this.driverId,
    required this.availableSeats,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      origin: json['origin'],
      destination: json['destination'],
      departDatetime: json['depart_datetime'],
      driverName: json['driver_name'],
      driverId: json['driver_id'],
      availableSeats: json['available_seats'],
    );
  }
}
