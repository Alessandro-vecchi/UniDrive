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
  final String profilePictureUrl;
  final String bio;
  final int totalRidesGiven;
  final String joinedIn;
  final CarDetails carDetails;
  final String city;
  final String district;
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
    required this.instagramUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  // Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
