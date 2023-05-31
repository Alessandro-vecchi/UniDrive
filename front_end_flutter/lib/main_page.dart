import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'views/map_view/widgtes/labeled_floating_action_button.dart';
import 'views/map_view/widgtes/search_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearchOpen = false;

  late GoogleMapController mapController; //controller for Google map

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = Set(); //markers for google map
  LatLng _initialTargetPosition = LatLng(41.92338, 12.47403);

  @override
  void initState() {
    print("THIS IS MY POSITION");
    _getUserLocation();
    markers.add(Marker( //add marker on google map
      markerId: MarkerId(_initialTargetPosition.toString()),
      position: _initialTargetPosition, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'My position ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
    super.initState();
  }

  void _getUserLocation() async {
    print("THIS IS MY POSITION?");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    print("THIS IS MY POSITION!");
    setState(() {
      _initialTargetPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !_isSearchOpen,
        child: LabeledFloatingActionButton(
          label: 'Search a ride',
          icon: Icons.search,
          onPressed: () => setState(() => _isSearchOpen = true),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              target: _initialTargetPosition,
              zoom: 12, // you can adjust this value as needed
            ),
            markers: markers,
            //markers to show on map
            mapType: MapType.normal,
            //map type
            onMapCreated: _onMapCreated, //method called when map is created

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _isSearchOpen,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchView(
                      onClose: () => setState(() => _isSearchOpen = false),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
