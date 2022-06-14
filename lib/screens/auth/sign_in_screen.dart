// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/otp.dart';
import 'package:juragan99/data/profile.dart';
import 'package:juragan99/data/user.dart';
import 'package:juragan99/screens/auth/otp/email_verification_screen.dart';
import 'package:juragan99/screens/settings/my_profile_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/screens/auth/sign_up_screen.dart';
import 'package:juragan99/dialog/forgot_password_dialog.dart';

import '../dashboard_screen.dart';

import 'package:juragan99/utils/variables.dart' as variable;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  String token;
  String email;
  String phone;

  getUser() async {
    await UserList.list(variable.email_login, variable.password_login).then(
      (value) {
        if (value.token == null) {
          Fluttertoast.showToast(
            msg: "Gagal",
            backgroundColor: CustomColor.red,
            textColor: CustomColor.white,
            gravity: ToastGravity.CENTER,
          );
        } else {
          setState(() {
            token = value.token;
            email = value.email;
            phone = value.phone;
          });
          modalPickOTP(context);
        }
      },
    );
  }

  getSpecialUser() async {
    await UserList.list(variable.email_login, variable.password_login).then(
      (value) {
        if (value.token == null) {
          Fluttertoast.showToast(
            msg: "Gagal",
            backgroundColor: CustomColor.red,
            textColor: CustomColor.white,
            gravity: ToastGravity.CENTER,
          );
        } else {
          specialUserLogin(value.token, value.email);
        }
      },
    );
  }

  specialUserLogin(String token, String email) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    await pref.setString('email', email);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
  }

  _setOtp() async {
    await SetOtp.list(email, phone).then(
      (value) {
        if (value['status'] == 200) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(
                email: email,
                phone: phone,
                token: token,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [headerWidget(context), bodyWidget(context)],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        color: CustomColor.white,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColor.darkGrey,
                              size: Dimensions.defaultTextSize,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(0)),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Masuk",
                                  style: TextStyle(
                                      color: CustomColor.darkGrey,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  bodyWidget(BuildContext context) {
    return Column(
      children: [
        inputFieldWidget(context),
        SizedBox(height: 20),
        buttonWidget(context),
        SizedBox(height: 30),
        newHereWidget(context)
      ],
    );
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.email,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    variable.email_login = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Text(
                "Sandi",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: passwordController,
                onChanged: (value) {
                  setState(() {
                    variable.password_login = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Sandi",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: CustomStyle.textStyle,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _toggleVisibility = !_toggleVisibility;
                      });
                    },
                    icon: _toggleVisibility
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                  ),
                ),
                obscureText: _toggleVisibility,
              ),
              SizedBox(height: Dimensions.heightSize),
            ],
          ),
        ));
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: GestureDetector(
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius))),
          child: Center(
            child: Text(
              "Masuk",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          if (emailController.text == "pesorosdev@gmail.com") {
            getSpecialUser();
          } else {
            getUser();
          }
        },
      ),
    );
  }

  newHereWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun? ",
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            "Daftar",
            style: TextStyle(
                color: CustomColor.primaryColor, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        )
      ],
    );
  }

  modalPickOTP(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text('Pilih Metode OTP'),
          content: SingleChildScrollView(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      variable.isEmail = true;
                    });
                    _setOtp();
                  },
                  child: Text(
                    "Email",
                    style: TextStyle(color: CustomColor.red),
                  )),
              TextButton(
                onPressed: () {
                  setState(() {
                    variable.isEmail = false;
                  });
                  Navigator.pop(context);
                  _setOtp();
                },
                child: Text(
                  "Whatsapp",
                  style: TextStyle(color: CustomColor.red),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
