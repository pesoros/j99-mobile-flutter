// ignore_for_file: missing_return, must_be_immutable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/otp.dart';
import 'package:juragan99/screens/auth/otp/otp_confirmation.dart';
import 'package:juragan99/screens/settings/my_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String phone;
  final String token;

  const EmailVerificationScreen({this.email, this.phone, this.token});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [verificationWidget(context)],
      ),
    );
  }

  Widget verificationWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: OtpConfirmation(
              title: "Kode Verifikasi",
              otpLength: 4,
              validateOtp: validateOtp,
              routeCallback: moveToNextScreen,
              titleColor: Colors.black,
              themeColor: Colors.black,
              email: widget.email,
              phone: widget.phone,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> validateOtp(String otp) async {
    await CheckOtp.list(otp, widget.email, widget.phone).then((value) {
      if (value['status'] == 200) {
        moveToNextScreen(context);
      } else {
        Fluttertoast.showToast(
            msg: value['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16);
      }
    });
  }

  void moveToNextScreen(context) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', widget.token);
    await pref.setString('email', widget.email);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
  }
}
