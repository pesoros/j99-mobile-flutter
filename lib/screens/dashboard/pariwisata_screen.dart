// ignore_for_file: unused_import

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/data/notifications.dart';

import 'package:juragan99/utils/custom_style.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PariwisataScreen extends StatefulWidget {
  @override
  _PariwisataScreenState createState() => _PariwisataScreenState();
}

class _PariwisataScreenState extends State<PariwisataScreen> {
  final imageList = [
    "http://www.juragan99trans.id/images/premium/TK_Premium.jpg",
    "http://www.juragan99trans.id/images/executive/TK_hino.jpg",
    "http://www.juragan99trans.id/images/executive/TK_merc.jpg",
    "http://www.juragan99trans.id/images/medium/TK_medium.jpg",
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController typeBusController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeightMinusAppBarMinusStatusBar =
        MediaQuery.of(context).size.height - 150;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: screenHeightMinusAppBarMinusStatusBar),
            child: bodyWidget(context),
          )),
        ));
  }

  bodyWidget(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            carouselWidget(context),
            Container(
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: CustomColor.white,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    // Image.asset('assets/images/home_bg.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // height: 300,
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    controller: nameController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Nama",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    controller: phoneController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "No. Handphone",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    controller: emailController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "E-mail",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    controller: typeBusController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Tipe Bus",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 80,
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    style: TextStyle(fontSize: 16),
                                    controller: keteranganController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Keterangan",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 10, left: 20, right: 20),
                      child: GestureDetector(
                        child: Container(
                          height: Dimensions.buttonHeight,
                          decoration: BoxDecoration(
                              color: CustomColor.red,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "KIRIM",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  carouselWidget(BuildContext context) {
    return Expanded(
      child: Swiper(
        autoplay: true,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imageList[index],
            fit: BoxFit.cover,
          );
        },
        // itemCount: 1,
      ),
    );
  }
}
