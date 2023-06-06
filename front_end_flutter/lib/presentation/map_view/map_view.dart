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
  final LatLng _initializeUserPosition = const LatLng(41.92338, 12.47403);

  LatLng? _userPosition;

  bool _showSearchingIcon = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

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
    setState(() {
      _userPosition = LatLng(userPosition.latitude, userPosition.longitude);
    });
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _userPosition!,
          zoom: 15.0,
        ),
      ),
    );
  }

  Widget _buildSearchingLocationButton() {
    return FloatingActionButton(
      onPressed: _moveToUserPosition,
      child: const Icon(Icons.location_searching),
    );
  }

  Widget _buildMyLocationButton() {
    return FloatingActionButton(
      onPressed: _moveToUserPosition,
      child: const Icon(Icons.my_location),
    );
  }

  void _moveToUserPosition() {
    if (_userPosition != null) {
      setState(() {
        _showSearchingIcon = false;
      });
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          _userPosition!,
          15.0,
        ),
      );
    }
  }

  void _checkUserPosition(CameraPosition position) {
    if (_userPosition != null) {
      final distance = Geolocator.distanceBetween(
        _userPosition!.latitude,
        _userPosition!.longitude,
        position.target.latitude,
        position.target.longitude,
      );
      setState(() {
        _showSearchingIcon = distance > 100;
      });
    }
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
              initialCameraPosition: CameraPosition(
                target: _initializeUserPosition,
                zoom: 14, // you can adjust this value as needed
              ),
              markers: _markers,
              mapType: MapType.normal,
              buildingsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              liteModeEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              // method called when map is created
              onCameraMoveStarted: () {
                setState(() {
                  _showSearchingIcon = true;
                });
              },
              onCameraIdle: () {
                setState(() {
                  _showSearchingIcon = false;
                });
              },
            ),
            Positioned(
              left: 16.0,
              bottom: 16.0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _showSearchingIcon
                    ? _buildSearchingLocationButton()
                    : _buildMyLocationButton(),
              ),
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
