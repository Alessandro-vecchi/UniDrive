// lib/services/ride_service.dart
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uni_drive/models/ride.dart';
import 'package:uni_drive/models/search_model.dart';

import '../models/booking.dart';
import '../models/profile.dart';

part 'ride_service.g.dart';

@RestApi(baseUrl: "http://172.27.1.184:3000")
abstract class RideService {
  factory RideService() => _RideService(Dio(
        BaseOptions(
          headers: {
            'Authorization': '9c39b23c-7d5b-4a37-b1a7-73c96bcbcefc',
          },
        ),
      )..interceptors.add(
          PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 90),
        ));

  @GET("/rides")
  Future<List<Ride>> getRides({
    @Queries() required SearchModel searchModel,
  });

  @POST("/rides/{ride_id}/booking/")
  Future<Booking> bookRide(@Path('ride_id') String id);

  @DELETE("/rides/{ride_id}/booking/{booking_id}")
  Future<void> cancelBooking(
      @Path('ride_id') String rideId, @Path('booking_id') String bookingId);

  @GET("/profile/{user_id}")
  Future<Profile> getProfile(@Path('user_id') String userId);

  @GET("/reverse_geocoding")
  Future<String> getFA(
      @Query('latitude') double latitude, @Query('longitude') double longitude);

  @GET("/autocomplete")
  Future<List<String>> autocomplete(@Query('input') String input,
      @Query('latitude') double latitude, @Query('longitude') double longitude);
}
