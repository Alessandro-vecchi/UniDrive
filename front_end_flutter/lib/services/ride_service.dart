// lib/services/ride_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uni_drive/models/ride.dart';

import '../models/profile.dart';

part 'ride_service.g.dart';

@RestApi(baseUrl: "http://192.168.0.105:3000")
abstract class RideService {
  factory RideService() => _RideService(
        Dio(
          BaseOptions(
            headers: {
              'Authorization': 'xxxxxxxx',
            },
          ),
        ),
      );

  @GET("/rides")
  Future<List<Ride>> getRides({
    @Query('origin') String? origin,
    @Query('origin_lat') String? originLat,
    @Query('origin_lon') String? originLon,
    @Query('destination') required String destination,
    @Query('date_time') required String date,
  });

  @GET("/rides/{ride_id}")
  Future<Ride> getRide(@Path('ride_id') String id);

  @POST("/rides/{ride_id}/booking")
  Future<void> bookRide(@Path('ride_id') String id);

  @DELETE("/rides/{ride_id}/booking/{booking_id}")
  Future<void> cancelBooking(
      @Path('ride_id') String rideId, @Path('booking_id') String bookingId);

  @GET("/profile/{user_id}")
  Future<Profile> getProfile(@Path('user_id') String userId);
}
