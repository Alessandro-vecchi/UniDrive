import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride {
  final String id;
  final String origin;
  final String destination;
  final String departDatetime;
  final ShortProfile driverProfile;
  final MeetingPoint meetingPoint;
  final int availableSeats;

  Ride({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departDatetime,
    required this.driverProfile,
    required this.meetingPoint,
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

@JsonSerializable()
class MeetingPoint {
  final double latitude;
  final double longitude;
  final int distance;
  final int meetingTime;

  MeetingPoint({
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.meetingTime,
  });

  factory MeetingPoint.fromJson(Map<String, dynamic> json) => _$MeetingPointFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingPointToJson(this);
}
