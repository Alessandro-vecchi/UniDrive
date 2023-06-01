import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride {
  final String id;
  final String origin;
  final String destination;
  final String departDatetime;
  final ShortProfile driverProfile;
  final String meetingPoint;
  final String meetingTime;
  final int availableSeats;

  Ride({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departDatetime,
    required this.driverProfile,
    required this.meetingPoint,
    required this.meetingTime,
    required this.availableSeats,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
  Map<String, dynamic> toJson() => _$RideToJson(this);
}

@JsonSerializable()
class ShortProfile {
  final String profilePictureUrl;
  final String name;
  final String surname;
  final double rating;

  ShortProfile({
    required this.profilePictureUrl,
    required this.name,
    required this.surname,
    required this.rating,
  });

  factory ShortProfile.fromJson(Map<String, dynamic> json) => _$ShortProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ShortProfileToJson(this);
}
