import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:theme_json_converter/theme_json_converter.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(name: 'ride_id')
  final String rideId;
  @JsonKey(name: 'booking_timestamp')
  final String bookingTimestamp;
  @JsonKey(name: 'car_details', includeToJson: false)
  final CarDetails carDetails;

  Booking({
    required this.rideId,
    required this.bookingTimestamp,
    required this.carDetails,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

// Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable(createFactory: false)
@ColorConverter()
class CarDetails {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'car_model')
  final String carModel;
  @JsonKey(name: 'car_color')
  final String carColor;
  @JsonKey(
      name: 'car_color_hex', includeToJson: false, fromJson: _colorFromJson)
  final Color carColorHex;
  @JsonKey(name: 'car_plate')
  final String? carPlate;
  @JsonKey(name: 'license_since')
  final String? licenseSince;
  @JsonKey(name: 'tot_seats')
  final int totSeats;

  CarDetails({
    this.userId,
    required this.carModel,
    required this.carColor,
    required this.carColorHex,
    this.carPlate,
    this.licenseSince,
    required this.totSeats,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) {
    return CarDetails(
      userId: json['user_id'] as String?,
      carModel: json['car_model'] as String,
      carColor: json['car_color'] as String,
      carColorHex: _colorFromJson(json['car_color_hex']),
      carPlate: json['car_plate'] as String?,
      licenseSince: json['license_since'] as String?,
      totSeats: json['tot_seats'] as int,
    );
  }

  static Color _colorFromJson(String? colorValue) {
    if (colorValue != null && colorValue.isNotEmpty) {
      return Color(int.parse(colorValue, radix: 16)).withOpacity(1.0);
    } else {
      // Return a default color if the value is null or empty
      return Colors.transparent;
    }
  }

// Map<String, dynamic> toJson() => _$CarDetailsToJson(this);
}
