// ignore_for_file: unused_import, missing_return, unused_field, unused_element

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:juragan99/data/booking.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/food.dart';
import 'package:juragan99/screens/dashboard/search_ticket_screen.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/bus_ticket_pergi_widget.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/utils/formater.dart';

import 'package:juragan99/screens/invoice_screen.dart';
import 'package:juragan99/widgets/payment_method_widget.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameBuyerController =
      TextEditingController(text: variable.firstName + " " + variable.lastName);
  TextEditingController phoneBuyerController =
      TextEditingController(text: variable.phone);
  TextEditingController emailBuyerController =
      TextEditingController(text: variable.email);

  TextEditingController namePassenggerController1 =
      TextEditingController(text: variable.namePassengger1);
  TextEditingController phonePassenggerController1 =
      TextEditingController(text: variable.phonePassengger1);
  TextEditingController nikPassenggerController1 =
      TextEditingController(text: variable.nikPassengger1);
  TextEditingController foodPassenggerController1 =
      TextEditingController(text: variable.foodPassengger1);
  TextEditingController baggagePassenggerController1 = TextEditingController();

  TextEditingController namePassenggerController2 =
      TextEditingController(text: variable.namePassengger2);
  TextEditingController phonePassenggerController2 =
      TextEditingController(text: variable.phonePassengger2);
  TextEditingController nikPassenggerController2 =
      TextEditingController(text: variable.nikPassengger2);
  TextEditingController foodPassenggerController2 =
      TextEditingController(text: variable.foodPassengger2);
  TextEditingController baggagePassenggerController2 = TextEditingController();

  TextEditingController namePassenggerController3 =
      TextEditingController(text: variable.namePassengger3);
  TextEditingController phonePassenggerController3 =
      TextEditingController(text: variable.phonePassengger3);
  TextEditingController nikPassenggerController3 =
      TextEditingController(text: variable.nikPassengger3);
  TextEditingController foodPassenggerController3 =
      TextEditingController(text: variable.foodPassengger3);
  TextEditingController baggagePassenggerController3 = TextEditingController();

  TextEditingController namePassenggerController4 =
      TextEditingController(text: variable.namePassengger4);
  TextEditingController phonePassenggerController4 =
      TextEditingController(text: variable.phonePassengger4);
  TextEditingController nikPassenggerController4 =
      TextEditingController(text: variable.nikPassengger4);
  TextEditingController foodPassenggerController4 =
      TextEditingController(text: variable.foodPassengger4);
  TextEditingController baggagePassenggerController4 =
      TextEditingController(text: variable.baggagePassengger4);

  TextEditingController promoCodeController = TextEditingController();

  double totalPrice = 0;
  double promoValue = 0;
  double grandTotalPrice = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getBaggageStatus();
    getPromoKodeValue();
    getTotalPrice();
    getGrandTotalPrice();
  }

  getBaggageStatus() {
    if (variable.baggagePassengger1 == '0') {
      baggagePassenggerController1.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePassenggerController1.text = 'Bawa Bagasi';
    }
    if (variable.baggagePassengger2 == '0') {
      baggagePassenggerController2.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePassenggerController2.text = 'Bawa Bagasi';
    }
    if (variable.baggagePassengger3 == '0') {
      baggagePassenggerController3.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePassenggerController3.text = 'Bawa Bagasi';
    }
    if (variable.baggagePassengger4 == '0') {
      baggagePassenggerController4.text = 'Tidak Bawa Bagasi';
    } else {
      baggagePassenggerController4.text = 'Bawa Bagasi';
    }
  }

  getPromoKodeValue() {
    if (promoValue == null) {
      setState(() {});
    }
  }

  getTotalPrice() {
    if (variable.checkPulangPergi == true) {
      setState(() {
        totalPrice = double.parse(variable.pergi_price) +
            double.parse(variable.pulang_price);
      });
    } else {
      setState(() {
        totalPrice = double.parse(variable.pergi_price);
      });
    }
  }

  getGrandTotalPrice() {
    setState(() {
      grandTotalPrice = totalPrice + promoValue;
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
            _promoCode(context),
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
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "NIK",
                        hintText: "NIK",
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
                      controller: foodPassenggerController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Menu Makanan",
                        hintText: "Menu Makanan",
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
                      controller: baggagePassenggerController1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Bagasi",
                        hintText: "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
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
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "NIK",
                        hintText: "NIK",
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
                      controller: foodPassenggerController2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Menu Makanan",
                        hintText: "Menu Makanan",
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
                      controller: baggagePassenggerController2,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Bagasi",
                        hintText: "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger2 == null)
                                            ? ""
                                            : variable.seatPergiPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger2 == null)
                                            ? ""
                                            : variable.seatPergiPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPulangPassengger2 == null)
                                            ? ""
                                            : variable.seatPulangPassengger2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "NIK",
                        hintText: "NIK",
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
                      controller: foodPassenggerController3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Menu Makanan",
                        hintText: "Menu Makanan",
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
                      controller: baggagePassenggerController3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Bagasi",
                        hintText: "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger3 == null)
                                            ? ""
                                            : variable.seatPergiPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger3 == null)
                                            ? ""
                                            : variable.seatPergiPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPulangPassengger3 == null)
                                            ? ""
                                            : variable.seatPulangPassengger3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "NIK",
                        hintText: "NIK",
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
                      controller: foodPassenggerController4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Menu Makanan",
                        hintText: "Menu Makanan",
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
                      controller: baggagePassenggerController4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        labelText: "Bagasi",
                        hintText: "Bagasi",
                        labelStyle: CustomStyle.textStyle,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger4 == null)
                                            ? ""
                                            : variable.seatPergiPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPergiPassengger4 == null)
                                            ? ""
                                            : variable.seatPergiPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text("No Kursi: "),
                                      Text(
                                        (variable.seatPulangPassengger4 == null)
                                            ? ""
                                            : variable.seatPulangPassengger4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: CustomColor.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _data(
                variable.pergi_pickup_trip_location +
                    " - " +
                    variable.pergi_drop_trip_location +
                    " x " +
                    variable.selectedJumlahPenumpang,
                currencyFormatterD.format(double.parse(variable.pergi_price)),
              ),
              (variable.checkPulangPergi == true)
                  ? _data(
                      variable.pulang_pickup_trip_location +
                          " - " +
                          variable.pulang_drop_trip_location +
                          " x " +
                          variable.selectedJumlahPenumpang,
                      currencyFormatter
                          .format(double.parse(variable.pulang_price)),
                    )
                  : Padding(padding: EdgeInsets.all(0)),
              _data("Promo", promoValue.toString()),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              _data(
                "Total",
                currencyFormatter.format(grandTotalPrice),
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
            '\Rp ${price.toString()}',
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
                              variable.selectedPayment,
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
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InvoiceScreen()));
              setState(() {
                isLoading = false;
              });
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
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InvoiceScreen()));
                setState(() {
                  isLoading = false;
                });
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
        },
      ),
    );
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
