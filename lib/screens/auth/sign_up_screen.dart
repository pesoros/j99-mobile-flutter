// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/check_registration.dart';
import 'package:juragan99/data/otp.dart';
import 'package:juragan99/data/registration.dart';
import 'package:juragan99/screens/auth/otp_registration/email_verification_registration_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/screens/auth/otp/email_verification_screen.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
  }

  _setOtp() async {
    await SetOtp.list(emailController.text, phoneController.text).then(
      (value) {
        if (value['status'] == 200) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmailVerificationRegistrationScreen(
                email: emailController.text,
                password: passwordController.text,
                confpassword: confirmPasswordController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneController.text,
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
              children: [
                BackWidget(
                  title: "Daftar",
                ),
                bodyWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Column(
      children: [
        inputFieldWidget(context),
        SizedBox(height: Dimensions.heightSize * 2),
        buttonWidget(context),
        SizedBox(height: Dimensions.heightSize * 2),
        alreadyHaveAccountWidget(context)
      ],
    );
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Depan",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          style: CustomStyle.textStyle,
                          controller: firstNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Nama Depan",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelStyle: CustomStyle.textStyle,
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle: CustomStyle.textStyle,
                            focusedBorder: CustomStyle.focusBorder,
                            enabledBorder: CustomStyle.focusErrorBorder,
                            focusedErrorBorder: CustomStyle.focusErrorBorder,
                            errorBorder: CustomStyle.focusErrorBorder,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Belakang",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          style: CustomStyle.textStyle,
                          controller: lastNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Nama Belakang",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelStyle: CustomStyle.textStyle,
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle: CustomStyle.textStyle,
                            focusedBorder: CustomStyle.focusBorder,
                            enabledBorder: CustomStyle.focusErrorBorder,
                            focusedErrorBorder: CustomStyle.focusErrorBorder,
                            errorBorder: CustomStyle.focusErrorBorder,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              Text(
                "No. Handphone",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "No. Handphone",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Icons.phone),
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 0.5),
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
                decoration: InputDecoration(
                    hintText: "example@email.com",
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
                    prefixIcon: Icon(Icons.mail)),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
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
              SizedBox(height: Dimensions.heightSize * 0.5),
              Text(
                "Konfirmasi sandi",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: "Konfirmasi sandi",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.transparent,
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
                  hintStyle: CustomStyle.textStyle,
                ),
                obscureText: _toggleVisibility,
              ),
              SizedBox(height: Dimensions.heightSize * 0.5),
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
              "Daftar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          if (firstNameController.text != "" ||
              lastNameController.text != "" ||
              emailController.text != "" ||
              phoneController.text != "" ||
              passwordController.text != "" ||
              confirmPasswordController.text != "") {
            await CheckRegistration.list(emailController.text).then((value) {
              if (value['status'] == 200) {
                if (passwordController.text != confirmPasswordController.text) {
                  Fluttertoast.showToast(
                    msg: "Konfirmasi sandi tidak cocok",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  modalPickOTP(context);
                }
              } else {
                Fluttertoast.showToast(
                  msg: "Email telah terdaftar",
                  backgroundColor: CustomColor.red,
                  textColor: CustomColor.white,
                  gravity: ToastGravity.CENTER,
                );
              }
            });
          } else {
            Fluttertoast.showToast(
              msg: "Lengkapi data",
              backgroundColor: CustomColor.red,
              textColor: CustomColor.white,
              gravity: ToastGravity.CENTER,
            );
          }
        },
      ),
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

  alreadyHaveAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah punya akun? ",
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            "Masuk",
            style: TextStyle(
                color: CustomColor.primaryColor, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignInScreen()));
          },
        )
      ],
    );
  }
}
