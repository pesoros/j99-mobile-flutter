// ignore_for_file: unused_import, missing_return, unused_field, unused_element, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indonesia/indonesia.dart';
import 'package:juragan99/data/booking.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/food.dart';
import 'package:juragan99/screens/dashboard/search_ticket_screen.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/payment_status_screen.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/bus_ticket_pergi_widget.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:juragan99/screens/invoice_screen.dart';
import 'package:juragan99/widgets/payment_method_widget.dart';

import 'package:juragan99/utils/variables.dart' as variable;
import 'package:url_launcher/url_launcher_string.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameBuyerController = TextEditingController(
      text: variable.first_name + " " + variable.last_name);
  TextEditingController phoneBuyerController =
      TextEditingController(text: variable.phone);
  TextEditingController emailBuyerController =
      TextEditingController(text: variable.email);

  TextEditingController namePassenggerController1 =
      TextEditingController(text: variable.namePassengger1);
  TextEditingController phonePassenggerController1 =
      TextEditingController(text: variable.phonePassengger1);
  TextEditingController foodPergiPassenggerController1 =
      TextEditingController(text: variable.foodPergiPassengger1);
  TextEditingController foodPulangPassenggerController1 =
      TextEditingController(text: variable.foodPulangPassengger1);
  TextEditingController baggagePergiPassenggerController1 =
      TextEditingController();
  TextEditingController baggagePulangPassenggerController1 =
      TextEditingController();

  TextEditingController namePassenggerController2 =
      TextEditingController(text: variable.namePassengger2);
  TextEditingController phonePassenggerController2 =
      TextEditingController(text: variable.phonePassengger2);
  TextEditingController foodPergiPassenggerController2 =
      TextEditingController(text: variable.foodPergiPassengger2);
  TextEditingController foodPulangPassenggerController2 =
      TextEditingController(text: variable.foodPulangPassengger2);
  TextEditingController baggagePergiPassenggerController2 =
      TextEditingController();
  TextEditingController baggagePulangPassenggerController2 =
      TextEditingController();

  TextEditingController namePassenggerController3 =
      TextEditingController(text: variable.namePassengger3);
  TextEditingController phonePassenggerController3 =
      TextEditingController(text: variable.phonePassengger3);
  TextEditingController foodPergiPassenggerController3 =
      TextEditingController(text: variable.foodPergiPassengger3);
  TextEditingController foodPulangPassenggerController3 =
      TextEditingController(text: variable.foodPulangPassengger3);
  TextEditingController baggagePergiPassenggerController3 =
      TextEditingController();
  TextEditingController baggagePulangPassenggerController3 =
      TextEditingController();

  TextEditingController namePassenggerController4 =
      TextEditingController(text: variable.namePassengger4);
  TextEditingController phonePassenggerController4 =
      TextEditingController(text: variable.phonePassengger4);
  TextEditingController foodPergiPassenggerController4 =
      TextEditingController(text: variable.foodPergiPassengger4);
  TextEditingController foodPulangPassenggerController4 =
      TextEditingController(text: variable.foodPulangPassengger4);
  TextEditingController baggagePergiPassenggerController4 =
      TextEditingController();
  TextEditingController baggagePulangPassenggerController4 =
      TextEditingController();

  TextEditingController promoCodeController = TextEditingController();

  double totalPrice = 0;
  double promoValue = 0;
  double grandTotalPrice = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getBaggageStatus();
    getTotalPrice();
    getGrandTotalPrice();
  }

  getBaggageStatus() {
    if (variable.baggagePergiPassengger1 == '0') {
      baggagePergiPassenggerController1.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePergiPassenggerController1.text = 'Bawa Bagasi';
    }
    if (variable.baggagePergiPassengger2 == '0') {
      baggagePergiPassenggerController2.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePergiPassenggerController2.text = 'Bawa Bagasi';
    }
    if (variable.baggagePergiPassengger3 == '0') {
      baggagePergiPassenggerController3.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePergiPassenggerController3.text = 'Bawa Bagasi';
    }
    if (variable.baggagePergiPassengger4 == '0') {
      baggagePergiPassenggerController4.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePergiPassenggerController4.text = 'Bawa Bagasi';
    }
    if (variable.baggagePulangPassengger1 == '0') {
      baggagePulangPassenggerController1.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePulangPassenggerController1.text = 'Bawa Bagasi';
    }
    if (variable.baggagePulangPassengger2 == '0') {
      baggagePulangPassenggerController2.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePulangPassenggerController2.text = 'Bawa Bagasi';
    }
    if (variable.baggagePulangPassengger3 == '0') {
      baggagePulangPassenggerController3.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePulangPassenggerController3.text = 'Bawa Bagasi';
    }
    if (variable.baggagePulangPassengger4 == '0') {
      baggagePulangPassenggerController4.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePulangPassenggerController4.text = 'Bawa Bagasi';
    }
  }

  getTotalPrice() {
    if (variable.checkPulangPergi == true) {
      double total_pergi_price = double.parse(variable.pergi_price) *
          double.parse(variable.selectedJumlahPenumpang);
      double total_pulang_price = double.parse(variable.pulang_price) *
          double.parse(variable.selectedJumlahPenumpang);
      setState(() {
        totalPrice = total_pergi_price + total_pulang_price;
      });
    } else {
      setState(() {
        totalPrice = double.parse(variable.pergi_price) *
            double.parse(variable.selectedJumlahPenumpang);
      });
    }
  }

  getGrandTotalPrice() {
    setState(() {
      grandTotalPrice = totalPrice - promoValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackWidget(
              title: "Pembayaran",
            ),
            bodyWidget(context),
            buttonWidget(context)
          ],
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _dataBuyerWidget(context),
            (variable.selectedJumlahPenumpang == "1")
                ? _dataPassenggerWidget1(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "2")
                ? _dataPassenggerWidget1(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "2")
                ? _dataPassenggerWidget2(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "3")
                ? _dataPassenggerWidget1(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "3")
                ? _dataPassenggerWidget2(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "3")
                ? _dataPassenggerWidget3(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "4")
                ? _dataPassenggerWidget1(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "4")
                ? _dataPassenggerWidget2(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "4")
                ? _dataPassenggerWidget3(context)
                : Container(),
            (variable.selectedJumlahPenumpang == "4")
                ? _dataPassenggerWidget4(context)
                : Container(),
            // _promoCode(context),
            _paymentMethod(context),
            SizedBox(height: 20),
            _detailCost(context),
          ],
        ),
      ),
    );
  }

  _dataBuyerWidget(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Data Pemesan",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: nameBuyerController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: phoneBuyerController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "No. Handphone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: emailBuyerController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataPassenggerWidget1(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Data Penumpang",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      controller: namePassenggerController1,
                      style: CustomStyle.textStyle,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: phonePassenggerController1,
                      decoration: InputDecoration(
                        labelText: "No. Handphone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Makanan, Bagasi, Seat
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: foodPergiPassenggerController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: baggagePergiPassenggerController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: foodPulangPassenggerController1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: baggagePulangPassenggerController1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  (variable.checkPulangPergi == false)
                      ? Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger1 == null)
                                            ? ""
                                            : variable.seatPergiPassengger1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger1 == null)
                                            ? ""
                                            : variable.seatPergiPassengger1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Pulang",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPulangPassengger1 == null)
                                            ? ""
                                            : variable.seatPulangPassengger1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataPassenggerWidget2(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Data Penumpang",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      controller: namePassenggerController2,
                      style: CustomStyle.textStyle,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: phonePassenggerController2,
                      decoration: InputDecoration(
                        labelText: "No. Handphone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Makanan, Bagasi, Seat
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: foodPergiPassenggerController2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: baggagePergiPassenggerController2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: foodPulangPassenggerController2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: baggagePulangPassenggerController2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  (variable.checkPulangPergi == false)
                      ? Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger2 == null)
                                            ? ""
                                            : variable.seatPergiPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger2 == null)
                                            ? ""
                                            : variable.seatPergiPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Pulang",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPulangPassengger2 == null)
                                            ? ""
                                            : variable.seatPulangPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataPassenggerWidget3(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Data Penumpang",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      controller: namePassenggerController3,
                      style: CustomStyle.textStyle,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: phonePassenggerController3,
                      decoration: InputDecoration(
                        labelText: "No. Handphone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Makanan, Bagasi, Seat
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: foodPergiPassenggerController3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: baggagePergiPassenggerController3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: foodPulangPassenggerController3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: baggagePulangPassenggerController3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  (variable.checkPulangPergi == false)
                      ? Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger3 == null)
                                            ? ""
                                            : variable.seatPergiPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger3 == null)
                                            ? ""
                                            : variable.seatPergiPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Pulang",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPulangPassengger3 == null)
                                            ? ""
                                            : variable.seatPulangPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataPassenggerWidget4(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40, top: 20),
            child: Text(
              "Data Penumpang",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      controller: namePassenggerController4,
                      style: CustomStyle.textStyle,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: phonePassenggerController4,
                      decoration: InputDecoration(
                        labelText: "No. Handphone",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Makanan, Bagasi, Seat
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: foodPergiPassenggerController4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Menu Makanan Pergi"
                            : "Menu Makanan",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: baggagePergiPassenggerController4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        hintText: (variable.checkPulangPergi == true)
                            ? "Bagasi Pergi"
                            : "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: foodPulangPassenggerController4,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Menu Makanan Pulang"
                                  : "Menu Makanan",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: TextFormField(
                            readOnly: true,
                            style: CustomStyle.textStyle,
                            controller: baggagePulangPassenggerController4,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              errorBorder: CustomStyle.focusErrorBorder,
                              labelText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              hintText: (variable.checkPulangPergi == true)
                                  ? "Bagasi Pulang"
                                  : "Bagasi",
                              labelStyle: CustomStyle.textStyle,
                              hintStyle: CustomStyle.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  (variable.checkPulangPergi == false)
                      ? Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger4 == null)
                                            ? ""
                                            : variable.seatPergiPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pergi",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPergiPassengger4 == null)
                                            ? ""
                                            : variable.seatPergiPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Pulang",
                                    style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.defaultTextSize),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "No Kursi: ",
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        (variable.seatPulangPassengger4 == null)
                                            ? ""
                                            : variable.seatPulangPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _detailCost(BuildContext context) {
    String prettify(double d) =>
        d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
    String strGrandTotal = prettify(grandTotalPrice);
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: CustomColor.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _data(
                variable.selectedFromCity.toString(),
                " x " +
                    variable.selectedJumlahPenumpang +
                    " " +
                    rupiah(variable.pergi_price),
              ),
              _data(
                variable.selectedToCity.toString(),
                "",
              ),
              (variable.checkPulangPergi == true)
                  ? SizedBox(height: 10)
                  : Padding(padding: EdgeInsets.all(0)),
              (variable.checkPulangPergi == true)
                  ? _data(
                      variable.selectedToCity.toString(),
                      " x " +
                          variable.selectedJumlahPenumpang +
                          " " +
                          rupiah(variable.pergi_price),
                    )
                  : Padding(padding: EdgeInsets.all(0)),
              (variable.checkPulangPergi == true)
                  ? _data(
                      variable.selectedFromCity.toString(),
                      "",
                    )
                  : Padding(padding: EdgeInsets.all(0)),
              // _data("Promo", rupiah(promoValue)),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              _data(
                "Total",
                rupiah(strGrandTotal),
              ),
            ],
          ),
        ));
  }

  _data(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          Text(
            '${price.toString()}',
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
        ],
      ),
    );
  }

  _promoCode(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 40,
            right: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Kode Promo",
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    style: CustomStyle.textStyle,
                    controller: promoCodeController,
                    decoration: InputDecoration(
                      labelText: "Kode Promo",
                      hintText: "Masukkan Kode Promo",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: CustomStyle.textStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
            ],
          )),
        )
      ],
    );
  }

  _paymentMethod(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 40,
            right: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Pilih Pembayaran",
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: (variable.selectedPayment == null)
                          ? Text("Pilih Metode Pembayaran",
                              style: TextStyle(
                                  fontSize: Dimensions.defaultTextSize))
                          : Text(
                              (variable.selectedPaymentCategories == 'EWALLET')
                                  ? variable.selectedPayment
                                      .replaceAll('ID_', '')
                                  : variable.selectedPayment,
                              style: TextStyle(
                                  fontSize: Dimensions.defaultTextSize),
                            )),
                ),
                Container(
                  height: 50.0,
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Icon(Icons.arrow_forward_ios,
                          size: Dimensions.defaultTextSize)),
                ),
              ],
            ),
          ),
          onTap: () {
            _navigatePickPayment(context);
          },
        ),
      ],
    );
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
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
              "Bayar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          if (variable.selectedPayment == null ||
              variable.selectedPayment == "") {
            Fluttertoast.showToast(
              msg: "Pilih Metode Pembayaran terlebih dahulu",
              backgroundColor: CustomColor.red,
              textColor: CustomColor.white,
              gravity: ToastGravity.CENTER,
            );
          } else {
            setState(() {
              isLoading = true;
            });
            isLoading ? _onLoading() : Container();
            await BookingList.list().then((value) {
              if (variable.checkPulangPergi == false &&
                  jsonDecode(value)['pergi']['status'] == true) {
                var payment = jsonDecode(value)['payment'];
                variable.status = payment['status'];
                variable.bank_code = payment['bank_code'];
                variable.merchant_code = payment['merchant_code'];
                variable.name = payment['name'];
                variable.account_number = payment['account_number'];
                variable.external_id = payment['external_id'];
                variable.total_price = payment['total_price'].toString();
                if (variable.selectedPaymentCategories == 'EWALLET') {
                  String payment_link =
                      payment['actions']['mobile_web_checkout_url'];
                  String booking_code = payment['reference_id'];
                  _ewalletUrl(context, payment_link, booking_code);
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  String booking_code = payment['external_id'];
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          InvoiceScreen(booking_code: booking_code)));
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                if (variable.checkPulangPergi == true &&
                    jsonDecode(value)['pergi']['status'] == true &&
                    jsonDecode(value)['pulang']['status'] == true) {
                  var payment = jsonDecode(value)['payment'];
                  variable.status = payment['status'];
                  variable.bank_code = payment['bank_code'];
                  variable.merchant_code = payment['merchant_code'];
                  variable.name = payment['name'];
                  variable.account_number = payment['account_number'];
                  variable.external_id = payment['external_id'];
                  variable.total_price = payment['total_price'].toString();
                  if (variable.selectedPaymentCategories == 'EWALLET') {
                    String payment_link =
                        payment['actions']['mobile_web_checkout_url'];
                    String booking_code = payment['reference_id'];

                    _ewalletUrl(context, payment_link, booking_code);
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    String booking_code = payment['external_id'];

                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            InvoiceScreen(booking_code: booking_code)));
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {
                  Navigator.pop(context);
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Kursi sudah di pesan",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                }
              }
            });
          }
        },
      ),
    );
  }

  _ewalletUrl(
      BuildContext context, String payment_url, String booking_code) async {
    if (await launchUrlString(payment_url)) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaymentStatusScreen(booking_code: booking_code)));
    } else {
      throw 'Could not launch $payment_url';
    }
  }

  void _navigatePickPayment(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethodWidget()),
    );
    setState(() {});
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: CustomColor.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.all(50),
          child: new CircularProgressIndicator(),
        ));
      },
    );
  }
}
