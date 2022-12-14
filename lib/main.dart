import 'package:flutter/material.dart';
import 'home.dart';
import 'styles/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Pot',
      theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xff153228)),
          fontFamily: 'DoHyeonRegular'),
      home: Home(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: child!,
        ),
      ),
    );
  }
}
