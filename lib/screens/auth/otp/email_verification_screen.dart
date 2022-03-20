import 'package:flutter/material.dart';
import 'package:juragan99/screens/auth/otp/otp_confirmation.dart';

import '../../dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String emailAddress;

  const EmailVerificationScreen({Key key, this.emailAddress}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController emailController = TextEditingController();
  String _emailAddress;
  @override
  void initState() {
    super.initState();
    _emailAddress = widget.emailAddress;
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
              subTitle: 'Demo Code: 1234',
              emailAddress: _emailAddress,
              otpLength: 4,
              validateOtp: validateOtp,
              routeCallback: moveToNextScreen,
              titleColor: Colors.black,
              themeColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "1234") {
      moveToNextScreen(context);
      return "Sukses! Kode verifikasi benar";
    } else {
      return "Kode verifikasi salah";
    }
  }

  // action to be performed after OTP validation is success
  void moveToNextScreen(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DashboardScreen(0)));
  }
}
