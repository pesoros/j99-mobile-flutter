import 'package:juragan99/data/profile.dart';
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
    if (token != null) {
      setState(() {
        variable.token = token;
        variable.email = email;
      });
      getProfile(email, token);
    }
  }

  getProfile(String email, String token) async {
    await Profile.list(email).then((value) {
      setState(() {
        variable.first_name = token;
        variable.email = value['email'];
        variable.first_name = value['first_name'];
        variable.last_name = value['last_name'];
        variable.address = value['address'];
        variable.phone = value['phone'];
        variable.identity = value[''];
        variable.identity_number = value['identity'];
      });
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
