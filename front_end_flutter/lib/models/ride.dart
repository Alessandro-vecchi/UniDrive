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

  Ride({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departDatetime,
    required this.driverProfile,
    required this.meetingPoint,
    required this.meetingTime,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
  Map<String, dynamic> toJson() => _$RideToJson(this);
}

@JsonSerializable()
class ShortProfile {
  final String userId;
  final String profilePictureUrl;
  final String name;
  final String surname;
  final double rating;
  final int availableSeats;

  ShortProfile({
    required this.userId,
    required this.profilePictureUrl,
    required this.name,
    required this.surname,
    required this.rating,
    required this.availableSeats,
  });

  factory ShortProfile.fromJson(Map<String, dynamic> json) => _$ShortProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ShortProfileToJson(this);
}
