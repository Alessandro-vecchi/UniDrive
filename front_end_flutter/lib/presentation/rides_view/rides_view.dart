import 'package:flutter/material.dart';
import 'package:uni_drive/models/ride.dart';
import 'package:uni_drive/models/search_model.dart';
import 'package:uni_drive/presentation/rides_view/widgets/recap.dart';
import 'package:uni_drive/presentation/rides_view/widgets/ride_card.dart';

class RidesView extends StatelessWidget {
  static final rides = [
    Ride(
        id: 'id1',
        origin: 'origin1',
        destination: 'destination1',
        departDatetime: 'departDatetime1',
        driverProfile: ShortProfile(
          profilePictureUrl: 'profilePictureUrl1',
          name: 'name1',
          surname: 'surname1',
          rating: 4.5,
        ),
        meetingPoint: MeetingPoint(
          latitude: 1.0,
          longitude: 1.0,
          distance: 1,
          meetingTime: 1,
        ),
        availableSeats: 3),
    Ride(
        id: 'id2',
        origin: 'origin2',
        destination: 'destination2',
        departDatetime: 'departDatetime2',
        driverProfile: ShortProfile(
          profilePictureUrl: 'profilePictureUrl2',
          name: 'name2',
          surname: 'surname2',
          rating: 4.2,
        ),
        meetingPoint: MeetingPoint(
          latitude: 1.0,
          longitude: 1.0,
          distance: 1,
          meetingTime: 1,
        ),
        availableSeats: 2),
    Ride(
        id: 'id3',
        origin: 'origin3',
        destination: 'destination3',
        departDatetime: 'departDatetime3',
        driverProfile: ShortProfile(
          profilePictureUrl: 'profilePictureUrl3',
          name: 'name3',
          surname: 'surname3',
          rating: 3.8,
        ),
        meetingPoint: MeetingPoint(
          latitude: 1.0,
          longitude: 1.0,
          distance: 1,
          meetingTime: 1,
        ),
        availableSeats: 1),
  ];

  final SearchModel searchModel;

  const RidesView(this.searchModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Recap(searchModel: searchModel),
            FutureBuilder<List<Ride>>(
              future: _getRides(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) =>
                          RideCard(ride: snapshot.data![index]),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Ride>> _getRides() async {
    //call service here and return result
    return rides;
  }
}
