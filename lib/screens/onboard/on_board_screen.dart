import 'package:juragan99/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/utils/colors.dart';
import 'data.dart';
import 'package:juragan99/screens/intro_screen.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int totalPages = OnBoardingItems.loadOnboardItem().length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: CustomStyle.bgColor),
        child: PageView.builder(
            itemCount: totalPages,
            itemBuilder: (context, index) {
              OnBoardingItem oi = OnBoardingItems.loadOnboardItem()[index];
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.heightSize * 6,
                            bottom: Dimensions.heightSize),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  oi.image,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.marginSize * 2.5,
                                      right: Dimensions.marginSize * 2.5),
                                  child: Text(
                                    oi.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            Dimensions.extraLargeTextSize * 1.2,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.marginSize * 2,
                                      right: Dimensions.marginSize * 2),
                                  child: Text(
                                    oi.subTitle,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.largeTextSize),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.center,
                                child: index != (totalPages - 1)
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Container(
                                          width: 100.0,
                                          height: 15.0,
                                          child: ListView.builder(
                                            itemCount: totalPages,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Container(
                                                  width: index == i ? 15 : 15.0,
                                                  decoration: BoxDecoration(
                                                      color: index == i
                                                          ? CustomColor
                                                              .accentColor
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  7.5))),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: Dimensions.buttonHeight,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                color: CustomColor.accentColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Dimensions.radius *
                                                            0.5))),
                                            child: Center(
                                              child: Text(
                                                Strings.getStarted
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Dimensions
                                                        .largeTextSize,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      IntroScreen()));
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }),
      ),
    );
  }
}
