import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable(createToJson: false)
class Booking {
  @JsonKey(name: 'booking_id')
  final String bookingId;
  @JsonKey(name: 'booking_timestamp')
  final String? bookingTimestamp;
  @JsonKey(name: 'car_details', includeToJson: false)
  final CarDetails? carDetails;

  Booking({
    required this.bookingId,
    this.bookingTimestamp,
    this.carDetails,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}

@JsonSerializable()
class CarDetails {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'car_model')
  final String carModel;
  @JsonKey(name: 'car_color')
  final String carColor;
  @JsonKey(name: 'car_color_hex', includeToJson: false, fromJson: _colorFromJson)
  final Color carColorHex;
  @JsonKey(name: 'car_plate')
  final String? carPlate;
  @JsonKey(name: 'license_since')
  final String? licenseSince;
  @JsonKey(name: 'tot_seats')
  final int totSeats;

  CarDetails({
    required this.userId,
    required this.carModel,
    required this.carColor,
    required this.carColorHex,
    this.carPlate,
    this.licenseSince,
    required this.totSeats,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) => _$CarDetailsFromJson(json);

  static Color _colorFromJson(Map<String, dynamic> colorValue) {
    return Color.fromRGBO(
      colorValue['R'] ?? 0,
      colorValue['G'] ?? 0,
      colorValue['B'] ?? 0,
      (colorValue['A'] ?? 0) / 255,
    );
  }
}
