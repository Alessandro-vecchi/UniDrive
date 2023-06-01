import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'booking_view/booking_view.dart';
import 'booking_view/widgets/driver_info.dart';
import 'booking_view/widgets/ride_info.dart';
import 'map_view/map_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.transparent,
        selectedBackgroundColor: const Color(0xFF363ABE),
        selectedItemColor: Colors.white,
        currentIndex: _pageIndex,
        onTap: (value) => setState(() => _pageIndex = value),
        items: [
          FloatingNavbarItem(
            //icon: const IconData(0xF013d, fontFamily: 'MaterialIcons'),
            icon: FontAwesomeIcons.magnifyingGlassLocation,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.list,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.message,
          ),
          FloatingNavbarItem(
            icon: FontAwesomeIcons.user,
          ),
        ],
      ),
      body: IndexedStack(index: _pageIndex, children: const [
        MapView(),
        DriverInfo(),
        RideInfo(),
        BookingView(),
      ]),
    );
  }
}
