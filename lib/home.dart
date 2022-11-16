import 'package:flutter/material.dart';
import 'views/control_view.dart';
import 'views/info_view.dart';
import 'styles/color.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[InfoPage(), ControlPage()];

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
          selectedItemColor: createMaterialColor(Color(0xff153228)),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
