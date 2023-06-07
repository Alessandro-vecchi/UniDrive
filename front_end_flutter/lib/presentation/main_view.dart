import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'map_view/map_view.dart';
import 'profile_view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _pageIndex = 0;
  String _loggedInId = '9c39b23c-7d5b-4a37-b1a7-73c96bcbcefc';

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
      body: IndexedStack(
        index: _pageIndex,
        children: [
          MapView(),
          Placeholder(),
          Placeholder(),
          ProfileView(_loggedInId),
        ],
      ),
    );
  }
}
