// ignore_for_file: missing_return, must_be_immutable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/otp.dart';
import 'package:juragan99/data/registration.dart';
import 'package:juragan99/data/user.dart';
import 'package:juragan99/screens/auth/otp/otp_confirmation.dart';
import 'package:juragan99/screens/settings/my_profile_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerificationRegistrationScreen extends StatefulWidget {
  String email;
  String password;
  String confpassword;
  String firstName;
  String lastName;
  String phone;

  EmailVerificationRegistrationScreen({
    this.email,
    this.password,
    this.confpassword,
    this.firstName,
    this.lastName,
    this.phone,
  });

  @override
  _EmailVerificationRegistrationScreenState createState() =>
      _EmailVerificationRegistrationScreenState();
}

class _EmailVerificationRegistrationScreenState
    extends State<EmailVerificationRegistrationScreen> {
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
              routeCallback: sendRegistration,
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
        sendRegistration(context);
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

  void sendRegistration(context) async {
    await Registration.list(
      widget.email,
      widget.password,
      widget.confpassword,
      widget.firstName,
      widget.lastName,
      widget.phone,
    ).then((value) {
      if (value == "registration succeed") {
        loginRegistration(context);
      } else {
        Fluttertoast.showToast(
          msg: "Data telah terpakai",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  void loginRegistration(context) async {
    await UserList.list(widget.email, widget.password).then((value) {
      String token = value.token;
      String email = value.email;
      moveToNextScreen(context, email, token);
    });
  }

  void moveToNextScreen(context, String email, String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    await pref.setString('email', email);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
  }
}
