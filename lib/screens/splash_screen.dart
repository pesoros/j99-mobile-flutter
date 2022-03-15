import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:juragan99/screens/onboard/on_board_screen.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<Color> colors = <Color>[
    CustomColor.red,
    CustomColor.darkGrey,
  ];

  @override
  void initState() {
    super.initState();
    getToken();

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardScreen(0))));
  }

  getToken() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    String email = pref.getString('email');
    String firstName = pref.getString('firstName');
    String lastName = pref.getString('lastName');
    String address = pref.getString('address');
    String phone = pref.getString('phone');
    setState(() {
      variable.token = token;
      variable.email = email;
      variable.firstName = firstName;
      variable.lastName = lastName;
      variable.address = address;
      variable.phone = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: CustomStyle.bgColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/j99-logo.png',
              width: MediaQuery.of(context).size.width / 1.3,
            ),
          ],
        ),
      ),
    );
  }
}
