import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride extends Equatable {
  final String id;
  final String origin;
  final String destination;
  final String departDatetime;
  final ShortProfile driverProfile;
  final MeetingPoint meetingPoint;
  final int availableSeats;
  final int totSeats;

  const Ride({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departDatetime,
    required this.driverProfile,
    required this.meetingPoint,
    required this.availableSeats,
    required this.totSeats,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

  Map<String, dynamic> toJson() => _$RideToJson(this);

  @override
  List<Object?> get props => [
        id,
        origin,
        destination,
        departDatetime,
        driverProfile,
        meetingPoint,
        availableSeats,
        totSeats,
      ];
}

@JsonSerializable()
class ShortProfile extends Equatable {
  final String profilePictureUrl;
  final String name;
  final String surname;
  final double rating;

  const ShortProfile({
    required this.profilePictureUrl,
    required this.name,
    required this.surname,
    required this.rating,
  });

  factory ShortProfile.fromJson(Map<String, dynamic> json) =>
      _$ShortProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ShortProfileToJson(this);

  @override
  List<Object?> get props => [profilePictureUrl, name, surname, rating];
}

@JsonSerializable()
class MeetingPoint extends Equatable {
  final double latitude;
  final double longitude;
  final int distance;
  final int meetingTime;

  const MeetingPoint({
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.meetingTime,
  });

  factory MeetingPoint.fromJson(Map<String, dynamic> json) =>
      _$MeetingPointFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingPointToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, distance, meetingTime];
}
