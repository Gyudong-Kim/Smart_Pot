import 'package:flutter/material.dart';
import 'pot_control_screen.dart';
import 'pot_info_screen.dart';
import '../theme/color_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[PotInfoScreen(), PotControlScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '스마트 화분',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'Info'),
            BottomNavigationBarItem(
                icon: Icon(Icons.water_drop_outlined), label: 'Control'),
          ],
          selectedItemColor: ColorTheme.createMaterialColor(Color(0xff153228)),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
