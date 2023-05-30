// lib/services/ride_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_drive/models/ride.dart';

class RideService {
  final String _baseUrl = "http://localhost:3000";

  Future<List<Ride>> getRides(String origin, String destination, String dateTime,
  ) async {

    // Create the url for the http request. The URL includes the base URL
    // and the parameters for the request. In this case, the parameters
    // are origin, destination, and date.
    String url = '$_baseUrl/rides?origin=$origin&destination=$destination&date_time=$dateTime';

    // Send the http request and wait for the response
    http.Response response = await http.get(Uri.parse(url));

    // Check the status code of the response.
    // If it's 200, it means the request was successful
    if (response.statusCode == 200) {

      // Convert the response body, which is a JSON string, to a Dart List
      List<dynamic> data = jsonDecode(response.body);

      // Convert each item in the list to a Ride object and return the list of Ride objects
      return data.map((item) => Ride.fromJson(item)).toList();

    } else {

      // If the request was not successful, throw an error
      throw Exception('Failed to load rides');
    }
  }
}
