import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/data/change_password.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
  }

  changePassword() async {
    await ChangePassword.list(
      variable.email,
      newPasswordController.text,
      confirmNewPasswordController.text,
    ).then((value) {
      if (value == true) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(
                title: "Ubah Sandi",
              ),
              bodyWidget(context),
              buttonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 70,
        bottom: 70,
      ),
      child: inputFieldWidget(context),
    );
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sandi baru",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    hintText: "Sandi baru",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
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
                Text(
                  "Konfirmasi sandi baru",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: confirmNewPasswordController,
                  decoration: InputDecoration(
                    hintText: "Konfirmasi sandi baru",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
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
                SizedBox(height: Dimensions.heightSize),
              ],
            ),
          ),
        ));
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 30,
      right: 30,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Ubah sandi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          if (newPasswordController.text == "" ||
              confirmNewPasswordController.text == "") {
            Fluttertoast.showToast(
              msg: "Lengkapi data",
              backgroundColor: CustomColor.red,
              textColor: CustomColor.white,
              gravity: ToastGravity.CENTER,
            );
          } else {
            if (newPasswordController.text ==
                confirmNewPasswordController.text) {
              changePassword();
            } else {
              Fluttertoast.showToast(
                msg: "Konfirmasi password tidak sama",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            }
          }
        },
      ),
    );
  }
}
