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
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  DateTime dateNow = DateTime.now();
  DateTime selectedDatePergi = DateTime.now();
  DateTime selectedDatePulang = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    resetVariable();
  }

  resetVariable() {
//Login
    variable.email_login = null;
    variable.password_login = null;

//Registration

//OTP
    variable.isEmail = true;

//HomeScreen
    variable.selectedFromCity = null;
    variable.selectedToCity = null;
    variable.selectedKelasArmada = "";
    variable.selectedUnitType = "1";
    variable.selectedJumlahPenumpang = null;
    variable.datePergi = 'Pergi';
    variable.datePulang = 'Pulang';
    variable.checkPulangPergi = false;

//FilterSearch
    variable.pergi_sort_by = "Harga Terendah";
    variable.pulang_sort_by = "Harga Terendah";

//Bus
    variable.pergi_trip_id_no = null;
    variable.pergi_trip_route_id = null;
    variable.pergi_shedule_id = null;
    variable.pergi_pickup_trip_location = null;
    variable.pergi_drop_trip_location = null;
    variable.pergi_type = null;
    variable.pergi_type_class = null;
    variable.pergi_fleet_seats = null;
    variable.pergi_fleet_registration_id = null;
    variable.pergi_price = null;
    variable.pergi_duration = null;
    variable.pergi_start = null;
    variable.pergi_end = null;
    variable.pergi_seatPicked = null;
    variable.pergi_seatAvail = null;
    variable.pergi_resto_id = null;

    variable.pulang_trip_id_no = null;
    variable.pulang_trip_route_id = null;
    variable.pulang_shedule_id = null;
    variable.pulang_pickup_trip_location = null;
    variable.pulang_drop_trip_location = null;
    variable.pulang_type = null;
    variable.pulang_type_class = null;
    variable.pulang_fleet_seats = null;
    variable.pulang_fleet_registration_id = null;
    variable.pulang_price = null;
    variable.pulang_duration = null;
    variable.pulang_start = null;
    variable.pulang_end = null;
    variable.pulang_seatPicked = null;
    variable.pulang_seatAvail = null;
    variable.pulang_resto_id = null;

//PassanggerForm
    variable.checkBuyerPassengger = false;
    variable.checkBuyerPassenggerName = "";
    variable.checkBuyerPassenggerPhone = "";

//Passangger1
    variable.namePassengger1 = null;
    variable.phonePassengger1 = null;
    variable.foodPergiPassengger1 = null;
    variable.foodIdPergiPassengger1 = null;
    variable.baggagePergiPassengger1 = "0";
    variable.foodPulangPassengger1 = null;
    variable.foodIdPulangPassengger1 = null;
    variable.baggagePulangPassengger1 = "0";
    variable.seatPergiPassengger1 = null;
    variable.seatPulangPassengger1 = null;

//Passangger2
    variable.namePassengger2 = null;
    variable.phonePassengger2 = null;
    variable.foodPergiPassengger2 = null;
    variable.foodIdPergiPassengger2 = null;
    variable.baggagePergiPassengger2 = "0";
    variable.foodPulangPassengger2 = null;
    variable.foodIdPulangPassengger2 = null;
    variable.baggagePulangPassengger2 = "0";
    variable.seatPergiPassengger2 = null;
    variable.seatPulangPassengger2 = null;

//Passangger3
    variable.namePassengger3 = null;
    variable.phonePassengger3 = null;
    variable.foodPergiPassengger3 = null;
    variable.foodIdPergiPassengger3 = null;
    variable.baggagePergiPassengger3 = "0";
    variable.foodPulangPassengger3 = null;
    variable.foodIdPulangPassengger3 = null;
    variable.baggagePulangPassengger3 = "0";
    variable.seatPergiPassengger3 = null;
    variable.seatPulangPassengger3 = null;

//Passangger4
    variable.namePassengger4 = null;
    variable.phonePassengger4 = null;
    variable.foodPergiPassengger4 = null;
    variable.foodIdPergiPassengger4 = null;
    variable.baggagePergiPassengger4 = "0";
    variable.foodPulangPassengger4 = null;
    variable.foodIdPulangPassengger4 = null;
    variable.baggagePulangPassengger4 = "0";
    variable.seatPergiPassengger4 = null;
    variable.seatPulangPassengger4 = null;

//Payment
    variable.selectedPayment = null;
    variable.selectedPaymentCategories = null;
    variable.kodePromo = "";
    variable.totalPrice = "";

//Response Payment
    variable.status = null;
    variable.bank_code = null;
    variable.merchant_code = null;
    variable.name = null;
    variable.account_number = null;
    variable.expiration_date = null;
    variable.external_id = null;
    variable.total_price = null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeightMinusAppBarMinusStatusBar =
        MediaQuery.of(context).size.height - 150;
    return Scaffold(
        backgroundColor: CustomColor.white,
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
                      selectedItem: variable.selectedFromCity,
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
                          dotenv.env['BASE_URL'] + "/datakota",
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
                      onChanged: (data) {
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
                        selectedItem: variable.selectedToCity,
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
                            dotenv.env['BASE_URL'] + "/datakota",
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
                        onChanged: (data) {
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
                          style:
                              TextStyle(fontSize: Dimensions.defaultTextSize),
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
                          dotenv.env['BASE_URL'] + "/datakelas",
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
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
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
                          fontSize: Dimensions.defaultTextSize),
                    ),
                  ),
                ),
                onTap: () {
                  if (variable.selectedFromCity == null ||
                      variable.selectedFromCity == null ||
                      variable.selectedJumlahPenumpang == null ||
                      variable.datePergi == "Pergi") {
                    Fluttertoast.showToast(
                      msg: "Lengkapi Data",
                      backgroundColor: CustomColor.red,
                      textColor: CustomColor.white,
                      gravity: ToastGravity.CENTER,
                    );
                  } else {
                    if (variable.checkPulangPergi == true &&
                        variable.datePulang == "Pulang") {
                      Fluttertoast.showToast(
                        msg: "Lengkapi Data",
                        backgroundColor: CustomColor.red,
                        textColor: CustomColor.white,
                        gravity: ToastGravity.CENTER,
                      );
                    } else {
                      _navigateSearchResult(context);
                    }
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
                    fontSize: Dimensions.defaultTextSize),
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
                    fontSize: Dimensions.defaultTextSize),
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
        minTime: dateNow,
        maxTime: dateNow.add(Duration(days: 90)),
        currentTime: dateNow,
        locale: LocaleType.id);
    setState(() {
      if (pickedPergi != null) {
        selectedDatePergi = pickedPergi;
        variable.datePergi = "${selectedDatePergi.toLocal()}".split(' ')[0];
      }
    });
  }

  Future<void> _selectDatePulang(BuildContext context) async {
    final DateTime pickedPulang = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: selectedDatePergi.add(Duration(days: 1)),
        maxTime: selectedDatePergi.add(Duration(days: 90)),
        currentTime: dateNow.add(Duration(days: 1)),
        locale: LocaleType.id);
    setState(() {
      if (pickedPulang != null) {
        selectedDatePulang = pickedPulang;
        variable.datePulang = "${selectedDatePulang.toLocal()}".split(' ')[0];
      }
    });
  }

  void _navigateSearchResult(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchResultPergiScreen()),
    );
    resetVariable();
  }
}
