import 'package:flutter/material.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/screens/auth/otp/email_verification_screen.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

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
                  title: Strings.createAnAccount,
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
        termsConditionWidget(context),
        SizedBox(height: Dimensions.heightSize * 2),
        buttonWidget(context),
        SizedBox(height: Dimensions.heightSize * 2),
        orSignUpWithWidget(context),
        SizedBox(height: Dimensions.heightSize * 2),
        alreadyHaveAccountWidget(context)
      ],
    );
  }

  Future<bool> _showTermsConditions() async {
    return (await showDialog(
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: CustomColor.primaryColor,
            child: Stack(
              children: [
                Positioned(
                    top: -35.0,
                    left: -50.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Positioned(
                    right: -35.0,
                    bottom: -20.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.defaultPaddingSize * 2,
                      bottom: Dimensions.defaultPaddingSize * 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AlertDialog(
                        content: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 45,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  Strings.ourPolicyTerms,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'simply random text. It has roots in a piece of classical Latin literature ',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Distracted by the readable content of a page when looking at its layout.',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Available, but the majority have suffered alteration',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  'When do we contact information ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  'Do we use cookies ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.secondaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Center(
                                        child: Text(
                                          Strings.decline,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.defaultTextSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Center(
                                        child: Text(
                                          Strings.agree,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.defaultTextSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: Dimensions.heightSize * 2,
              left: Dimensions.marginSize,
              right: Dimensions.marginSize),
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
                decoration: InputDecoration(
                    hintText: Strings.demoEmail,
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
                height: Dimensions.heightSize,
              ),
              Text(
                Strings.password,
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
              Text(
                Strings.confirmPassword,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: Dimensions.heightSize * 0.5,
              ),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: confirmPasswordController,
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
              SizedBox(height: Dimensions.heightSize),
            ],
          ),
        ));
  }

  termsConditionWidget(BuildContext context) {
    return CheckboxListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "By clicking sign up you agree to the following ",
            style: CustomStyle.textStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.blueColor,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  print('go to privacy url');
                  _showTermsConditions();
                },
              ),
              Text(
                " with out reservation",
                style: CustomStyle.textStyle,
              ),
            ],
          )
        ],
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: GestureDetector(
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: CustomStyle.bgColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius))),
          child: Center(
            child: Text(
              Strings.createAnAccount.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(
                    emailAddress: emailController.text,
                  )));
        },
      ),
    );
  }

  orSignUpWithWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.orSignUpWith,
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimensions.largeTextSize,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)),
                child: Image.asset('assets/images/google.png'),
              ),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)),
                child: Image.asset('assets/images/facebook.png'),
              ),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)),
                child: Image.asset('assets/images/twitter.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  alreadyHaveAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.alreadyHaveAnAccount,
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            Strings.signIn.toUpperCase(),
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
