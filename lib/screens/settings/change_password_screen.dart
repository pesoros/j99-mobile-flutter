import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(
                title: Strings.changePassword,
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
              top: Dimensions.heightSize * 2,
              left: Dimensions.marginSize,
              right: Dimensions.marginSize),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.oldPassword,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: oldPasswordController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return Strings.pleaseFillOutTheField;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: Strings.typePassword,
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
                  Strings.password,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: newPasswordController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return Strings.pleaseFillOutTheField;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: Strings.typePassword,
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
                  Strings.confirmPassword,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: confirmNewPasswordController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return Strings.pleaseFillOutTheField;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: Strings.typePassword,
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
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize,
      right: Dimensions.marginSize,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              gradient: CustomStyle.bgColor,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              Strings.changePassword,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
