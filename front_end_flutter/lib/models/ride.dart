// lib/models/ride.dart
import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

@JsonSerializable(createToJson: false)
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

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

}
