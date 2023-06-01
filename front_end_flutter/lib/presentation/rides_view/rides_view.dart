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
        driverName: 'driverName1',
        driverId: 'driverId1',
        availableSeats: 3),
    Ride(
        id: 'id2',
        origin: 'origin2',
        destination: 'destination2',
        departDatetime: 'departDatetime2',
        driverName: 'driverName2',
        driverId: 'driverId2',
        availableSeats: 2),
    Ride(
        id: 'id3',
        origin: 'origin3',
        destination: 'destination3',
        departDatetime: 'departDatetime3',
        driverName: 'driverName3',
        driverId: 'driverId3',
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
                      itemBuilder: (context, index) => RideCard(ride: snapshot.data![index]),
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
