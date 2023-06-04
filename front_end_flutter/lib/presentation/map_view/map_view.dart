import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../search_view/search_view.dart';
import 'state/map_view_cubit.dart';
import 'widgets/labeled_floating_action_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapViewCubit>(
      create: (context) => MapViewCubit(),
      child: Scaffold(
        floatingActionButton: BlocBuilder<MapViewCubit, MapViewState>(
          builder: (context, state) {
            return switch (state) {
              MapViewInitial() => LabeledFloatingActionButton(
                  label: 'Search a ride',
                  icon: Icons.search,
                  onPressed: () => context.read<MapViewCubit>().search(),
                ),
              MapViewSearching() => const SizedBox(),
            };
          },
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
              child: BlocBuilder<MapViewCubit, MapViewState>(
                builder: (context, state) {
                  return switch (state) {
                    MapViewInitial() => const SizedBox(),
                    MapViewSearching() => const SafeArea(child: SearchView()),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
