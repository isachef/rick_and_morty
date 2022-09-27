import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/episode_screen/episode_screen.dart';
import 'package:rick_and_morty/screens/location_screen/location_screen.dart';
import 'package:rick_and_morty/screens/user_screen/user_screen.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List _widgetOptions = [
    const UserScreen(),
    const LocationScreen(),
    const EpisodeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/Subtract.png'),
            label: 'персонажи',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/Group1.png'),
            label: 'локации',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              color: Color(0xffBDBDBD),
              size: 25,
            ),
            label: 'эпизоды',
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.settings_outlined,
          //     color: Color(0xffBDBDBD),
          //     size: 25,
          //   ),
          //   label: 'настройки',
          // ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
      ),
    );
  }
}
