// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/user.dart';
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
  String firstName;
  String lastName;
  String address;
  String phone;

  getUser() async {
    await UserList.list(variable.email_user, variable.password).then(
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
            firstName = value.firstName;
            lastName = value.lastName;
            address = value.address;
            phone = value.phone;
            variable.token = value.token;
            variable.email = value.email;
            variable.firstName = value.firstName;
            variable.lastName = value.lastName;
            variable.address = value.address;
            variable.phone = value.phone;
          });
          storeUser();
          Timer(Duration(seconds: 1), nextPage);
        }
      },
    );
  }

  nextPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
  }

  storeUser() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    await pref.setString('email', email);
    await pref.setString('lastName', lastName);
    await pref.setString('firstName', firstName);
    await pref.setString('address', address);
    await pref.setString('phone', phone);
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
                                  "Profil",
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
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    variable.email_user = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Example@email.com",
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
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    variable.password = value;
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
          getUser();
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
}
