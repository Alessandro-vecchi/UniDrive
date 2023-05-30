import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            // todo add api key in manifest
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 2,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: _isSearchOpen,
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
          ],
        ),
      ),
    );
  }
}
