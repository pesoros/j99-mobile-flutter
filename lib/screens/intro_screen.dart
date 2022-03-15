import 'package:juragan99/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/screens/auth/sign_up_screen.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: Text(
                  Strings.startByCreatingAnAccount,
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2,
                    top: Dimensions.marginSize),
                child: Text(
                  Strings.iAmAnEarlyBird,
                  style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: GestureDetector(
                  child: Container(
                    height: Dimensions.buttonHeight,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: CustomStyle.bgColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius)),
                    child: Center(
                      child: Text(
                        Strings.createAnAccount.toUpperCase(),
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2),
                child: GestureDetector(
                  child: Container(
                    height: Dimensions.buttonHeight,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(Dimensions.radius)),
                    child: Center(
                      child: Text(
                        Strings.signIn.toUpperCase(),
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: CustomColor.primaryColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignInScreen()));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
