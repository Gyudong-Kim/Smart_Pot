import 'package:flutter/material.dart';
import 'control.dart';
import 'status.dart';
import 'creatColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: createMaterialColor(Color(0xff153228))),
      home: const MyHomePage(title: 'Smart Pot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: <Widget>[control(), status()],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.looks_one, color: Colors.blue),
            ),
            Tab(
              icon: Icon(Icons.looks_two, color: Colors.blue),
            )
          ],
          controller: controller,
        ));
  }
}
