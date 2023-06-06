import 'package:json_annotation/json_annotation.dart';

import "booking.dart";

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String id;
  final String name;
  final String surname;
  final int age;
  final String faculty;
  final String university;
  @JsonKey(name: 'profile_picture_url')
  final String profilePictureUrl;
  final String bio;
  @JsonKey(name: 'total_rides_given')
  final int totalRidesGiven;
  @JsonKey(name: 'joined_in')
  final String joinedIn;
  @JsonKey(name: 'car_details')
  final CarDetails carDetails;
  final String city;
  final String district;
  @JsonKey(name: 'instagram_name')
  final String instagramName;
  @JsonKey(name: 'instagram_url')
  final String instagramUrl;

  Profile({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.faculty,
    required this.university,
    required this.profilePictureUrl,
    required this.bio,
    required this.totalRidesGiven,
    required this.joinedIn,
    required this.carDetails,
    required this.city,
    required this.district,
    required this.instagramName,
    required this.instagramUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
