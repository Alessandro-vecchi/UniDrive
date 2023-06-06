import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(name: 'ride_id')
  final String rideId;
  @JsonKey(name: 'booking_timestamp')
  final String bookingTimestamp;
  @JsonKey(name: 'car_details')
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
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'car_model')
  final String carModel;
  @JsonKey(name: 'car_color')
  final String carColor;
  @JsonKey(name: 'car_plate')
  final String carPlate;
  @JsonKey(name: 'tot_seats')
  final String totSeats;

  CarDetails({
    required this.userId,
    required this.carModel,
    required this.carColor,
    required this.carPlate,
    required this.totSeats,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) =>
      _$CarDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CarDetailsToJson(this);
}
