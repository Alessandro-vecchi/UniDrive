import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  final String rideId;
  final String bookingTimestamp;
  final CarDetails carDetails;

  Booking({
    required this.rideId,
    required this.bookingTimestamp,
    required this.carDetails,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable()
class CarDetails {
  final String userId;
  final String carModel;
  final String carColor;
  final String carPlate;

  CarDetails({
    required this.userId,
    required this.carModel,
    required this.carColor,
    required this.carPlate,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) =>
      _$CarDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CarDetailsToJson(this);
}
