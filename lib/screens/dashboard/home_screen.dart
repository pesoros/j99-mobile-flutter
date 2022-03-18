// ignore_for_file: unused_import, unused_element, unnecessary_import, non_constant_identifier_names

import 'dart:async';
import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:juragan99/screens/customer_feedback_screen.dart';
import 'package:juragan99/screens/settings/change_password_screen.dart';
import 'package:juragan99/screens/settings/gift_card_screen.dart';
import 'package:juragan99/screens/settings/my_profile_screen.dart';
import 'package:juragan99/screens/settings/support_screen.dart';
import 'package:juragan99/screens/search_result_pergi_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:juragan99/data/city.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageList = [
    "http://www.juragan99trans.id/images/premium/TK_Premium.jpg",
    "http://www.juragan99trans.id/images/executive/TK_hino.jpg",
    "http://www.juragan99trans.id/images/executive/TK_merc.jpg",
    "http://www.juragan99trans.id/images/medium/TK_medium.jpg",
  ];

  List<String> jumlahPenumpang = ["1", "2", "3", "4"];

  DateTime selectedDatePergi = DateTime.now();
  DateTime selectedDatePulang = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeightMinusAppBarMinusStatusBar =
        MediaQuery.of(context).size.height - 150;
    return Scaffold(
        backgroundColor: CustomColor.white,
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
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
    return Column(mainAxisSize: MainAxisSize.min, children: [
      carouselWidget(context),
      Container(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: CustomColor.white,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, right: 40, left: 40),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: DropdownSearch<CityModel>(
                      mode: Mode.DIALOG,
                      showClearButton: false,
                      maxHeight: 250,
                      label: "Kota Asal",
                      showSearchBox: true,
                      searchBoxDecoration:
                          InputDecoration(labelText: "Kota Asal"),
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onFind: (String) async {
                        var response = await Dio().post(
                          "https://api-j99.pesoros.com/datakota",
                        );
                        var dataFromCity =
                            CityModel.fromJsonList(response.data);
                        if (variable.selectedToCity == null)
                          return dataFromCity;
                        dataFromCity.removeWhere((item) =>
                            item.namaKota ==
                            variable.selectedToCity.toString());
                        return dataFromCity;
                      },
                      onChanged: (CityModel data) {
                        setState(() {
                          variable.selectedFromCity = data;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: DropdownSearch<CityModel>(
                        mode: Mode.DIALOG,
                        showClearButton: false,
                        maxHeight: 250,
                        label: "Kota Tujuan",
                        showSearchBox: true,
                        searchBoxDecoration:
                            InputDecoration(labelText: "Kota Tujuan"),
                        dropdownSearchDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          labelStyle: CustomStyle.textStyle,
                          focusedBorder: CustomStyle.focusBorder,
                          enabledBorder: CustomStyle.focusErrorBorder,
                          focusedErrorBorder: CustomStyle.focusErrorBorder,
                          errorBorder: CustomStyle.focusErrorBorder,
                          hintStyle: CustomStyle.textStyle,
                        ),
                        onFind: (String) async {
                          var response = await Dio().post(
                            "https://api-j99.pesoros.com/datakota",
                          );
                          var dataToCity =
                              CityModel.fromJsonList(response.data);
                          if (variable.selectedFromCity == null)
                            return dataToCity;
                          dataToCity.removeWhere((item) =>
                              item.namaKota ==
                              variable.selectedFromCity.toString());
                          return dataToCity;
                        },
                        onChanged: (CityModel data) {
                          setState(() {
                            variable.selectedToCity = data;
                          });
                        }),
                  ),
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Pulang-Pergi?",
                          style: TextStyle(
                              fontSize: Dimensions.extraSmallTextSize),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: CustomColor.red,
                            value: variable.checkPulangPergi,
                            onChanged: (bool value) {
                              setState(() {
                                variable.checkPulangPergi = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        selectDatePergi(context),
                        variable.checkPulangPergi
                            ? SizedBox(width: 10)
                            : Container(),
                        variable.checkPulangPergi
                            ? selectDatePulang(context)
                            : Container(),
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 225,
                      items: jumlahPenumpang,
                      label: "Jumlah Penumpang",
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onChanged: (jumlahPenumpang) {
                        setState(() {
                          variable.selectedJumlahPenumpang = jumlahPenumpang;
                        });
                      },
                      showSearchBox: false,
                      selectedItem: variable.selectedJumlahPenumpang,
                      validator: (String item) {
                        if (item == null)
                          return "Required field";
                        else if (item == variable.selectedJumlahPenumpang)
                          return "Invalid item";
                        else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: DropdownSearch<ClassModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: true,
                      maxHeight: 225,
                      label: "Kelas Armada",
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onFind: (String) async {
                        var response = await Dio().post(
                          "https://api-j99.pesoros.com/datakelas",
                        );
                        var kelasArmada =
                            ClassModel.fromJsonList(response.data);
                        return kelasArmada;
                      },
                      onChanged: (ClassModel data) {
                        if (data == null) {
                          setState(() {
                            variable.selectedKelasArmada = "";
                          });
                        } else {
                          setState(() {
                            variable.selectedKelasArmada = data.id;
                          });
                        }
                      },
                      showSearchBox: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
              child: GestureDetector(
                child: Container(
                  height: Dimensions.buttonHeight,
                  decoration: BoxDecoration(
                      color: CustomColor.red,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      "CARI BUS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.extraSmallTextSize),
                    ),
                  ),
                ),
                onTap: () {
                  if (variable.selectedFromCity == null ||
                      variable.selectedFromCity == null ||
                      // variable.selectedKelasArmada == null ||
                      variable.selectedJumlahPenumpang == null ||
                      variable.datePergi == "Pergi") {
                    Fluttertoast.showToast(
                      msg: "Lengkapi Data",
                      backgroundColor: CustomColor.red,
                      textColor: CustomColor.white,
                      gravity: ToastGravity.CENTER,
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchResultPergiScreen()));
                  }
                },
              ),
            )
          ],
        ),
      ),
    ]);
  }

  carouselWidget(BuildContext context) {
    return Expanded(
      child: Swiper(
        autoplay: true,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: imageList[index],
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          );
        },
        // itemCount: 1,
      ),
    );
  }

  selectDatePergi(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize * 0.5,
              ),
              child: Text(
                variable.datePergi,
                style: TextStyle(
                    color: CustomColor.greyColor,
                    fontSize: Dimensions.extraSmallTextSize),
              ),
            ),
          ),
        ),
        onTap: () {
          _selectDatePergi(context);
        },
      ),
    );
  }

  selectDatePulang(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize * 0.5,
              ),
              child: Text(
                variable.datePulang,
                style: TextStyle(
                    color: CustomColor.greyColor,
                    fontSize: Dimensions.extraSmallTextSize),
              ),
            ),
          ),
        ),
        onTap: () {
          _selectDatePulang(context);
        },
      ),
    );
  }

  Future<void> _selectDatePergi(BuildContext context) async {
    final DateTime pickedPergi = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: selectedDatePulang,
        maxTime: selectedDatePulang.add(Duration(days: 90)),
        currentTime: selectedDatePulang,
        locale: LocaleType.id);
    setState(() {
      selectedDatePergi = pickedPergi;
      variable.datePergi = "${selectedDatePergi.toLocal()}".split(' ')[0];
    });
  }

  Future<void> _selectDatePulang(BuildContext context) async {
    final DateTime pickedPulang = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: selectedDatePergi.add(Duration(days: 1)),
        maxTime: selectedDatePulang.add(Duration(days: 90)),
        currentTime: selectedDatePergi.add(Duration(days: 1)),
        locale: LocaleType.id);
    setState(() {
      selectedDatePulang = pickedPulang;
      variable.datePulang = "${selectedDatePulang.toLocal()}".split(' ')[0];
    });
  }
}
