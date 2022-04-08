// ignore_for_file: unused_import, missing_return, unnecessary_statements, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/food.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import 'package:juragan99/widgets/seat_plan_pergi_widget.dart';
import 'package:juragan99/widgets/seat_plan_pulang_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PassenggerFormScreen extends StatefulWidget {
  @override
  _PassenggerFormScreenState createState() => _PassenggerFormScreenState();
}

class _PassenggerFormScreenState extends State<PassenggerFormScreen> {
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

  TextEditingController namePassenggerController2 = TextEditingController();
  TextEditingController phonePassenggerController2 = TextEditingController();

  TextEditingController namePassenggerController3 = TextEditingController();
  TextEditingController phonePassenggerController3 = TextEditingController();

  TextEditingController namePassenggerController4 = TextEditingController();
  TextEditingController phonePassenggerController4 = TextEditingController();

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackWidget(
              title: "Form Penumpang",
              color: CustomColor.darkGrey,
            ),
            _bodyWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 70,
        bottom: 0,
      ),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          _pickSeatButton(context),
          SizedBox(height: 10),
          _buttonWidget(context),
        ]),
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
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
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
                      style: CustomStyle.textStyle,
                      controller: nameBuyerController,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        fillColor: Colors.black,
                        hintStyle: CustomStyle.textStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: phoneBuyerController,
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
                      style: CustomStyle.textStyle,
                      controller: emailBuyerController,
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
                  SizedBox(height: 10),
                  Container(
                    height: 20,
                    child: Row(
                      children: [
                        Text(
                          "Sama dengan pemesan",
                          style:
                              TextStyle(fontSize: Dimensions.defaultTextSize),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: CustomColor.red,
                            value: variable.checkBuyerPassengger,
                            onChanged: (bool value) {
                              if (value == true) {
                                setState(() {
                                  namePassenggerController1.text =
                                      variable.first_name +
                                          " " +
                                          variable.last_name;
                                  phonePassenggerController1.text =
                                      variable.phone;
                                  variable.checkBuyerPassengger = true;
                                });
                              } else {
                                setState(() {
                                  namePassenggerController1.text = "";
                                  phonePassenggerController1.text = "";
                                  variable.checkBuyerPassengger = false;
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
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
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
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
                      style: CustomStyle.textStyle,
                      controller: namePassenggerController1,
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
                  //Makanan & Bagasi
                  Container(
                    height: 50,
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: (variable.checkPulangPergi == true)
                          ? "Menu Makanan Pergi"
                          : "Menu Makanan",
                      showSearchBox: false,
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
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': variable.pergi_resto_id},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPergiPassengger1 = value.food_name;
                          variable.foodIdPergiPassengger1 = value.id;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 150,
                      label: (variable.checkPulangPergi == true)
                          ? "Pilih Bagasi Pergi"
                          : "Pilih Bagasi",
                      showSearchBox: false,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        labelStyle: CustomStyle.textStyle,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == 'Tidak Bawa Bagasi') {
                            variable.baggagePergiPassengger1 = '0';
                          } else {
                            variable.baggagePergiPassengger1 = '1';
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch<FoodModel>(
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 250,
                            label: "Menu Makanan Pulang",
                            showSearchBox: false,
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
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {'idResto': variable.pulang_resto_id},
                              );
                              var foodList =
                                  FoodModel.fromJsonList(response.data);
                              return foodList;
                            },
                            onChanged: (FoodModel value) {
                              setState(() {
                                variable.foodPulangPassengger1 =
                                    value.food_name;
                                variable.foodIdPulangPassengger1 = value.id;
                              });
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch(
                            items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 150,
                            label: "Pilih Bagasi Pulang",
                            showSearchBox: false,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              labelStyle: CustomStyle.textStyle,
                              errorBorder: CustomStyle.focusErrorBorder,
                              hintStyle: CustomStyle.textStyle,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == 'Tidak Bawa Bagasi') {
                                  variable.baggagePulangPassengger1 = '0';
                                } else {
                                  variable.baggagePulangPassengger1 = '1';
                                }
                              });
                            },
                          ),
                        )
                      : Container(),
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
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
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
                      style: CustomStyle.textStyle,
                      controller: namePassenggerController2,
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
                  //Makanan & Bagasi
                  Container(
                    height: 50,
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: (variable.checkPulangPergi == true)
                          ? "Menu Makanan Pergi"
                          : "Menu Makanan",
                      showSearchBox: false,
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
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': variable.pergi_resto_id},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPergiPassengger2 = value.food_name;
                          variable.foodIdPergiPassengger2 = value.id;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 150,
                      label: (variable.checkPulangPergi == true)
                          ? "Pilih Bagasi Pergi"
                          : "Pilih Bagasi",
                      showSearchBox: false,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        labelStyle: CustomStyle.textStyle,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == 'Tidak Bawa Bagasi') {
                            variable.baggagePergiPassengger2 = '0';
                          } else {
                            variable.baggagePergiPassengger2 = '1';
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch<FoodModel>(
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 250,
                            label: "Menu Makanan Pulang",
                            showSearchBox: false,
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
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {'idResto': variable.pulang_resto_id},
                              );
                              var foodList =
                                  FoodModel.fromJsonList(response.data);
                              return foodList;
                            },
                            onChanged: (FoodModel value) {
                              setState(() {
                                variable.foodPulangPassengger2 =
                                    value.food_name;
                                variable.foodIdPulangPassengger2 = value.id;
                              });
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch(
                            items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 150,
                            label: "Pilih Bagasi Pulang",
                            showSearchBox: false,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              labelStyle: CustomStyle.textStyle,
                              errorBorder: CustomStyle.focusErrorBorder,
                              hintStyle: CustomStyle.textStyle,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == 'Tidak Bawa Bagasi') {
                                  variable.baggagePulangPassengger2 = '0';
                                } else {
                                  variable.baggagePulangPassengger2 = '1';
                                }
                              });
                            },
                          ),
                        )
                      : Container(),
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
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
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
                      style: CustomStyle.textStyle,
                      controller: namePassenggerController3,
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
                  //Makanan & Bagasi
                  Container(
                    height: 50,
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: (variable.checkPulangPergi == true)
                          ? "Menu Makanan Pergi"
                          : "Menu Makanan",
                      showSearchBox: false,
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
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': variable.pergi_resto_id},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPergiPassengger3 = value.food_name;
                          variable.foodIdPergiPassengger3 = value.id;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 150,
                      label: (variable.checkPulangPergi == true)
                          ? "Pilih Bagasi Pergi"
                          : "Pilih Bagasi",
                      showSearchBox: false,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        labelStyle: CustomStyle.textStyle,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == 'Tidak Bawa Bagasi') {
                            variable.baggagePergiPassengger3 = '0';
                          } else {
                            variable.baggagePergiPassengger3 = '1';
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch<FoodModel>(
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 250,
                            label: "Menu Makanan Pulang",
                            showSearchBox: false,
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
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {'idResto': variable.pulang_resto_id},
                              );
                              var foodList =
                                  FoodModel.fromJsonList(response.data);
                              return foodList;
                            },
                            onChanged: (FoodModel value) {
                              setState(() {
                                variable.foodPulangPassengger3 =
                                    value.food_name;
                                variable.foodIdPulangPassengger3 = value.id;
                              });
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch(
                            items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 150,
                            label: "Pilih Bagasi Pulang",
                            showSearchBox: false,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              labelStyle: CustomStyle.textStyle,
                              errorBorder: CustomStyle.focusErrorBorder,
                              hintStyle: CustomStyle.textStyle,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == 'Tidak Bawa Bagasi') {
                                  variable.baggagePulangPassengger3 = '0';
                                } else {
                                  variable.baggagePulangPassengger3 = '1';
                                }
                              });
                            },
                          ),
                        )
                      : Container(),
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
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
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
                      style: CustomStyle.textStyle,
                      controller: namePassenggerController4,
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
                  //Makanan & Bagasi
                  Container(
                    height: 50,
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: (variable.checkPulangPergi == true)
                          ? "Menu Makanan Pergi"
                          : "Menu Makanan",
                      showSearchBox: false,
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
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': variable.pergi_resto_id},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPergiPassengger4 = value.food_name;
                          variable.foodIdPergiPassengger4 = value.id;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 150,
                      label: (variable.checkPulangPergi == true)
                          ? "Pilih Bagasi Pergi"
                          : "Pilih Bagasi",
                      showSearchBox: false,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        labelStyle: CustomStyle.textStyle,
                        errorBorder: CustomStyle.focusErrorBorder,
                        hintStyle: CustomStyle.textStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == 'Tidak Bawa Bagasi') {
                            variable.baggagePergiPassengger4 = '0';
                          } else {
                            variable.baggagePergiPassengger4 = '1';
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch<FoodModel>(
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 250,
                            label: "Menu Makanan Pulang",
                            showSearchBox: false,
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
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {'idResto': variable.pulang_resto_id},
                              );
                              var foodList =
                                  FoodModel.fromJsonList(response.data);
                              return foodList;
                            },
                            onChanged: (FoodModel value) {
                              setState(() {
                                variable.foodPulangPassengger4 =
                                    value.food_name;
                                variable.foodIdPulangPassengger4 = value.id;
                              });
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          height: 50,
                          child: DropdownSearch(
                            items: ['Tidak Bawa Bagasi', 'Bawa Bagasi'],
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: false,
                            maxHeight: 150,
                            label: "Pilih Bagasi Pulang",
                            showSearchBox: false,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: CustomStyle.focusBorder,
                              enabledBorder: CustomStyle.focusErrorBorder,
                              focusedErrorBorder: CustomStyle.focusErrorBorder,
                              labelStyle: CustomStyle.textStyle,
                              errorBorder: CustomStyle.focusErrorBorder,
                              hintStyle: CustomStyle.textStyle,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == 'Tidak Bawa Bagasi') {
                                  variable.baggagePulangPassengger4 = '0';
                                } else {
                                  variable.baggagePulangPassengger4 = '1';
                                }
                              });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _pickSeatButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: 30,
        right: 30,
      ),
      child: Column(
        children: [
          (variable.checkPulangPergi == false)
              ? GestureDetector(
                  child: Container(
                    height: Dimensions.buttonHeight,
                    decoration: BoxDecoration(
                        color: CustomColor.red,
                        borderRadius: BorderRadius.circular(Dimensions.radius)),
                    child: Center(
                      child: Text(
                        "Pilih Kursi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.defaultTextSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    _navigatePickSeatPergi(context);
                  },
                )
              : Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: Dimensions.buttonHeight,
                        decoration: BoxDecoration(
                            color: CustomColor.red,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius)),
                        child: Center(
                          child: Text(
                            "Pilih Kursi Pergi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        _navigatePickSeatPergi(context);
                      },
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Container(
                        height: Dimensions.buttonHeight,
                        decoration: BoxDecoration(
                            color: CustomColor.red,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius)),
                        child: Center(
                          child: Text(
                            "Pilih Kursi Pulang",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        _navigatePickSeatPulang(context);
                      },
                    )
                  ],
                ),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: 30,
        right: 30,
      ),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Lanjutkan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          //1
          if (variable.selectedJumlahPenumpang == "1") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                variable.foodPergiPassengger1 == null ||
                variable.baggagePergiPassengger1 == null ||
                variable.seatPergiPassengger1 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger1 == null ||
                    variable.baggagePulangPassengger1 == null ||
                    variable.seatPulangPassengger1 == null) {
                  Fluttertoast.showToast(
                    msg: "Lengkapi data terlebih dahulu",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  variable.namePassengger1 = namePassenggerController1.text;
                  variable.phonePassengger1 = phonePassenggerController1.text;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                }
              } else {
                variable.namePassengger1 = namePassenggerController1.text;
                variable.phonePassengger1 = phonePassenggerController1.text;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              }
            }
          }
          //2
          if (variable.selectedJumlahPenumpang == "2") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                variable.foodPergiPassengger1 == null ||
                variable.baggagePergiPassengger1 == null ||
                variable.seatPergiPassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                variable.foodPergiPassengger2 == null ||
                variable.baggagePergiPassengger2 == null ||
                variable.seatPergiPassengger2 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger1 == null ||
                    variable.baggagePulangPassengger1 == null ||
                    variable.seatPulangPassengger1 == null ||
                    variable.foodPulangPassengger2 == null ||
                    variable.baggagePulangPassengger2 == null ||
                    variable.seatPulangPassengger2 == null) {
                  Fluttertoast.showToast(
                    msg: "Lengkapi data terlebih dahulu",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  variable.namePassengger1 = namePassenggerController1.text;
                  variable.phonePassengger1 = phonePassenggerController1.text;
                  variable.namePassengger2 = namePassenggerController2.text;
                  variable.phonePassengger2 = phonePassenggerController2.text;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                }
              } else {
                variable.namePassengger1 = namePassenggerController1.text;
                variable.phonePassengger1 = phonePassenggerController1.text;
                variable.namePassengger2 = namePassenggerController2.text;
                variable.phonePassengger2 = phonePassenggerController2.text;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              }
            }
          }
          //3
          if (variable.selectedJumlahPenumpang == "3") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                variable.foodPergiPassengger1 == null ||
                variable.baggagePergiPassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                variable.foodPergiPassengger2 == null ||
                variable.baggagePergiPassengger2 == null ||
                namePassenggerController3.text == null ||
                phonePassenggerController3.text == null ||
                namePassenggerController3.text == "" ||
                phonePassenggerController3.text == "" ||
                variable.foodPergiPassengger3 == null ||
                variable.baggagePergiPassengger3 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger1 == null ||
                    variable.baggagePulangPassengger1 == null ||
                    variable.seatPulangPassengger1 == null ||
                    variable.foodPulangPassengger2 == null ||
                    variable.baggagePulangPassengger2 == null ||
                    variable.seatPulangPassengger2 == null ||
                    variable.foodPulangPassengger3 == null ||
                    variable.baggagePulangPassengger3 == null ||
                    variable.seatPulangPassengger3 == null) {
                  Fluttertoast.showToast(
                    msg: "Lengkapi data terlebih dahulu",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  variable.namePassengger1 = namePassenggerController1.text;
                  variable.phonePassengger1 = phonePassenggerController1.text;
                  variable.namePassengger2 = namePassenggerController2.text;
                  variable.phonePassengger2 = phonePassenggerController2.text;
                  variable.namePassengger3 = namePassenggerController3.text;
                  variable.phonePassengger3 = phonePassenggerController3.text;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                }
              } else {
                variable.namePassengger1 = namePassenggerController1.text;
                variable.phonePassengger1 = phonePassenggerController1.text;
                variable.namePassengger2 = namePassenggerController2.text;
                variable.phonePassengger2 = phonePassenggerController2.text;
                variable.namePassengger3 = namePassenggerController3.text;
                variable.phonePassengger3 = phonePassenggerController3.text;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              }
            }
          }
          //4
          if (variable.selectedJumlahPenumpang == "4") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                variable.foodPergiPassengger1 == null ||
                variable.baggagePergiPassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                variable.foodPergiPassengger2 == null ||
                variable.baggagePergiPassengger2 == null ||
                namePassenggerController3.text == null ||
                phonePassenggerController3.text == null ||
                namePassenggerController3.text == "" ||
                phonePassenggerController3.text == "" ||
                variable.foodPergiPassengger3 == null ||
                variable.baggagePergiPassengger3 == null ||
                namePassenggerController4.text == null ||
                phonePassenggerController4.text == null ||
                namePassenggerController4.text == "" ||
                phonePassenggerController4.text == "" ||
                variable.foodPergiPassengger4 == null ||
                variable.baggagePergiPassengger4 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger1 == null ||
                    variable.baggagePulangPassengger1 == null ||
                    variable.seatPulangPassengger1 == null ||
                    variable.foodPulangPassengger2 == null ||
                    variable.baggagePulangPassengger2 == null ||
                    variable.seatPulangPassengger2 == null ||
                    variable.foodPulangPassengger3 == null ||
                    variable.baggagePulangPassengger3 == null ||
                    variable.seatPulangPassengger3 == null) {
                  Fluttertoast.showToast(
                    msg: "Lengkapi data terlebih dahulu",
                    backgroundColor: CustomColor.red,
                    textColor: CustomColor.white,
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  variable.namePassengger1 = namePassenggerController1.text;
                  variable.phonePassengger1 = phonePassenggerController1.text;
                  variable.namePassengger2 = namePassenggerController2.text;
                  variable.phonePassengger2 = phonePassenggerController2.text;
                  variable.namePassengger3 = namePassenggerController3.text;
                  variable.phonePassengger3 = phonePassenggerController3.text;
                  variable.namePassengger4 = namePassenggerController4.text;
                  variable.phonePassengger4 = phonePassenggerController4.text;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                }
              } else {
                variable.namePassengger1 = namePassenggerController1.text;
                variable.phonePassengger1 = phonePassenggerController1.text;
                variable.namePassengger2 = namePassenggerController2.text;
                variable.phonePassengger2 = phonePassenggerController2.text;
                variable.namePassengger3 = namePassenggerController3.text;
                variable.phonePassengger3 = phonePassenggerController3.text;
                variable.namePassengger4 = namePassenggerController4.text;
                variable.phonePassengger4 = phonePassenggerController4.text;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              }
            }
          }
        },
      ),
    );
  }

  void _navigatePickSeatPergi(BuildContext context) async {
    if (variable.selectedJumlahPenumpang == "1") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPergiWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "2") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPergiWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "3") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "" ||
          namePassenggerController3.text == null ||
          namePassenggerController3.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
          variable.namePassengger3 = namePassenggerController3.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPergiWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "4") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "" ||
          namePassenggerController3.text == null ||
          namePassenggerController3.text == "" ||
          namePassenggerController4.text == null ||
          namePassenggerController4.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
          variable.namePassengger3 = namePassenggerController3.text;
          variable.namePassengger4 = namePassenggerController4.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPergiWidget()));
      }
    }
  }

  void _navigatePickSeatPulang(BuildContext context) async {
    if (variable.selectedJumlahPenumpang == "1") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPulangWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "2") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPulangWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "3") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "" ||
          namePassenggerController3.text == null ||
          namePassenggerController3.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
          variable.namePassengger3 = namePassenggerController3.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPulangWidget()));
      }
    }
    if (variable.selectedJumlahPenumpang == "4") {
      if (namePassenggerController1.text == null ||
          namePassenggerController1.text == "" ||
          namePassenggerController2.text == null ||
          namePassenggerController2.text == "" ||
          namePassenggerController3.text == null ||
          namePassenggerController3.text == "" ||
          namePassenggerController4.text == null ||
          namePassenggerController4.text == "") {
        Fluttertoast.showToast(
          msg: "Isi nama terlebih dahulu",
          backgroundColor: CustomColor.red,
          textColor: CustomColor.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        setState(() {
          variable.namePassengger1 = namePassenggerController1.text;
          variable.namePassengger2 = namePassenggerController2.text;
          variable.namePassengger3 = namePassenggerController3.text;
          variable.namePassengger4 = namePassenggerController4.text;
        });
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeatPlanPulangWidget()));
      }
    }
  }
}
