import 'package:juragan99/screens/splash_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColor.red,
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
    );
  }
}
