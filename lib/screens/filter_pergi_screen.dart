// ignore_for_file: unused_import

import 'dart:async';

import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';

class FilterPergiScreen extends StatefulWidget {
  @override
  _FilterPergiScreenState createState() => _FilterPergiScreenState();
}

class _FilterPergiScreenState extends State<FilterPergiScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  bodyWidget(context),
                  buttonWidget(context),
                ],
              ),
            )
          ]),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      child: Column(
        children: <Widget>[
          _chooseClassWidget(context),
          SizedBox(height: 30),
          _chooseBusServicesWidget(context),
        ],
      ),
    );
  }

  _chooseClassWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleContainer("Kelas"),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                child: Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              children: <Widget>[
                FilterChipWidget(chipName: 'Executive'),
                FilterChipWidget(chipName: 'Superior'),
              ],
            )),
          ),
        ),
      ],
    );
  }

  _chooseBusServicesWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleContainer("Urutkan berdasarkan"),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                child: Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              children: <Widget>[
                FilterChipWidget(chipName: 'Price'),
                FilterChipWidget(chipName: 'Top Selling'),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _titleContainer(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black,
          fontSize: Dimensions.largeTextSize,
          fontWeight: FontWeight.bold),
    );
  }

  buttonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 30),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Simpan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  openProgressingDialog(BuildContext context) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.white.withOpacity(0.6),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                ),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 2,
                      ),
                      GestureDetector(
                        child: Container(
                          height: Dimensions.buttonHeight,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius)),
                          child: Center(
                            child: Text(
                              Strings.cancel.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.largeTextSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(0)));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        });
  }
}
