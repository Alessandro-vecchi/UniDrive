import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'views/map_view/widgtes/labeled_floating_action_button.dart';
import 'views/map_view/widgtes/search_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearchOpen = false;

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
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 2,
            ),
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
