import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni_drive/views/map_view/widgets/search_view.dart';

import 'widgets/labeled_floating_action_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _isSearchOpen = false;
  late GoogleMapController _mapController; //controller for Google map
  final Set<Marker> _markers = {}; //markers for google map
  final _initialTargetPosition = const LatLng(41.92338, 12.47403);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  @override
  void initState() {
    super.initState();
    _initializeUserLocation();
  }

  void _initializeUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    final userPosition = await Geolocator.getCurrentPosition();
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  void _addMarkerToMap() {
    _markers.add(
      Marker(
        markerId: MarkerId(_initialTargetPosition.toString()),
        position: _initialTargetPosition,
        infoWindow: const InfoWindow(
          title: 'My position ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
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
            initialCameraPosition: CameraPosition(
              target: _initialTargetPosition,
              zoom: 13, // you can adjust this value as needed
            ),
            markers: _markers,
            mapType: MapType.normal,
            buildingsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            liteModeEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated, // method called when map is created
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
