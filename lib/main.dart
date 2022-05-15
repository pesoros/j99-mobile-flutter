// @dart=2.9

import 'package:juragan99/screens/splash_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(MyApp());
  await dotenv.load(fileName: ".env");
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
