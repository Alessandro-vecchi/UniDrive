import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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
  @override
  void initState() {
    super.initState();
    _initializeUserLocation();
  }

  void _initializeUserLocation() async {
    print("THIS IS MY POSITION");
    await _getUserLocation();
    _addMarkerToMap();
  }

  void _addMarkerToMap() {
    markers.add(
      Marker(
        markerId: MarkerId(_initialTargetPosition.toString()),
        position: _initialTargetPosition,
        infoWindow: InfoWindow(
          title: 'My position ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  Future<void> _getUserLocation() async {
    if (!(await Permission.location.serviceStatus.isEnabled)) {
      // You could optionally add some logic here to inform the user that location services are not enabled
      return;
    }

    var status = await Permission.location.status;
    if (status.isGranted) {
      await _fetchAndSetPosition();
      return;
    }

    if (status.isDenied) {
      await _requestLocationPermission();
    }

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
      await _fetchAndSetPosition();
    }
  }

  Future<void> _requestLocationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [Permission.location]
        .request();

    if (statuses[Permission.location]?.isGranted ?? false) {
      await _fetchAndSetPosition();
    } else {
      // add some logic here to inform the user that permission was not granted
    }
  }

  Future<void> _fetchAndSetPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
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
              zoom: 13, // you can adjust this value as needed
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
