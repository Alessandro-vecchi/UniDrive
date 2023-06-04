import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride extends Equatable {
  final String id;
  final String origin;
  final String destination;
  @JsonKey(name: 'depart_datetime')
  final String departDatetime;
  @JsonKey(name: 'driver_profile')
  final ShortProfile driverProfile;
  @JsonKey(name: 'meeting_point')
  final MeetingPoint meetingPoint;
  @JsonKey(name: 'available_seats')
  final int availableSeats;
  @JsonKey(name: 'tot_seats')
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
  @JsonKey(name: 'profile_picture_url')
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
  final int time;

  const MeetingPoint({
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.time,
  });

  factory MeetingPoint.fromJson(Map<String, dynamic> json) =>
      _$MeetingPointFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingPointToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, distance, time];
}
