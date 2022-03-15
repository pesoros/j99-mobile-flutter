// ignore_for_file: unused_import, missing_return, unnecessary_statements, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:juragan99/data/bus.dart';
import 'package:juragan99/data/food.dart';
import 'package:juragan99/data/slot.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juragan99/utils/variables.dart' as variable;

class PassenggerFormScreen extends StatefulWidget {
  @override
  _PassenggerFormScreenState createState() => _PassenggerFormScreenState();
}

class _PassenggerFormScreenState extends State<PassenggerFormScreen> {
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
  TextEditingController nikPassenggerController1 = TextEditingController();

  TextEditingController namePassenggerController2 = TextEditingController();
  TextEditingController phonePassenggerController2 = TextEditingController();
  TextEditingController nikPassenggerController2 = TextEditingController();

  TextEditingController namePassenggerController3 = TextEditingController();
  TextEditingController phonePassenggerController3 = TextEditingController();
  TextEditingController nikPassenggerController3 = TextEditingController();

  TextEditingController namePassenggerController4 = TextEditingController();
  TextEditingController phonePassenggerController4 = TextEditingController();
  TextEditingController nikPassenggerController4 = TextEditingController();

  int index = 0;
  List _listIdentitityType = ["KTP", "Paspor", "SIM"];

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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 10),
                  Container(
                    height: 20,
                    child: Row(
                      children: [
                        Text("Pembeli sebagai penumpang?"),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: CustomColor.red,
                            value: variable.checkBuyerPassengger,
                            onChanged: (bool value) {
                              if (value == true) {
                                setState(() {
                                  namePassenggerController1.text =
                                      variable.firstName +
                                          " " +
                                          variable.lastName;
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      items: _listIdentitityType,
                      selectedItem: _listIdentitityType[0],
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
                      onChanged: (value) {
                        variable.nikTypePassengger1 = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController1,
                      decoration: InputDecoration(
                        labelText: "NIK",
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
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: "Menu Makanan",
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
                          "https://api-j99.pesoros.com/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': "2"},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPassengger1 = value.food_name;
                          variable.foodIdPassengger1 = value.id;
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
                      label: "Pilih Bagasi",
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
                            variable.baggagePassengger1 = '0';
                          } else {
                            variable.baggagePassengger1 = '1';
                          }
                        });
                      },
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      items: _listIdentitityType,
                      selectedItem: _listIdentitityType[0],
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
                      onChanged: (value) {
                        variable.nikTypePassengger2 = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController2,
                      decoration: InputDecoration(
                        labelText: "NIK",
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
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: "Menu Makanan",
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
                          "https://api-j99.pesoros.com/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': "2"},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPassengger2 = value.food_name;
                          variable.foodIdPassengger2 = value.id;
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
                      label: "Pilih Bagasi",
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
                            variable.baggagePassengger2 = '0';
                          } else {
                            variable.baggagePassengger2 = '1';
                          }
                        });
                      },
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      items: _listIdentitityType,
                      selectedItem: _listIdentitityType[0],
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
                      onChanged: (value) {
                        variable.nikTypePassengger3 = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController3,
                      decoration: InputDecoration(
                        labelText: "NIK",
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
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: "Menu Makanan",
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
                          "https://api-j99.pesoros.com/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': "2"},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPassengger3 = value.food_name;
                          variable.foodIdPassengger3 = value.id;
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
                      label: "Pilih Bagasi",
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
                            variable.baggagePassengger3 = '0';
                          } else {
                            variable.baggagePassengger3 = '1';
                          }
                        });
                      },
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Container(
                    height: 50,
                    child: DropdownSearch(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      items: _listIdentitityType,
                      selectedItem: _listIdentitityType[0],
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
                      onChanged: (value) {
                        variable.nikTypePassengger4 = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: nikPassenggerController4,
                      decoration: InputDecoration(
                        labelText: "NIK",
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
                    child: DropdownSearch<FoodModel>(
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: false,
                      maxHeight: 250,
                      label: "Menu Makanan",
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
                          "https://api-j99.pesoros.com/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {'idResto': "2"},
                        );
                        var foodList = FoodModel.fromJsonList(response.data);
                        return foodList;
                      },
                      onChanged: (FoodModel value) {
                        setState(() {
                          variable.foodPassengger4 = value.food_name;
                          variable.foodIdPassengger4 = value.id;
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
                      label: "Pilih Bagasi",
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
                            variable.baggagePassengger4 = '0';
                          } else {
                            variable.baggagePassengger4 = '1';
                          }
                        });
                      },
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
                            fontSize: Dimensions.largeTextSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    _navigatePickSeat(context);
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
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        _navigatePickSeat(context);
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
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        _navigatePickSeat(context);
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
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          if (variable.selectedJumlahPenumpang == "1") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                nikPassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                nikPassenggerController1.text == "" ||
                variable.foodPassengger1 == null ||
                variable.baggagePassengger1 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              variable.namePassengger1 = namePassenggerController1.text;
              variable.phonePassengger1 = phonePassenggerController1.text;
              variable.nikPassengger1 = nikPassenggerController1.text;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            }
          }
          if (variable.selectedJumlahPenumpang == "2") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                nikPassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                nikPassenggerController1.text == "" ||
                variable.foodPassengger1 == null ||
                variable.baggagePassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                nikPassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                nikPassenggerController2.text == "" ||
                variable.foodPassengger2 == null ||
                variable.baggagePassengger2 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              variable.namePassengger1 = namePassenggerController1.text;
              variable.phonePassengger1 = phonePassenggerController1.text;
              variable.nikPassengger1 = nikPassenggerController1.text;
              variable.namePassengger2 = namePassenggerController2.text;
              variable.phonePassengger2 = phonePassenggerController2.text;
              variable.nikPassengger2 = nikPassenggerController2.text;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            }
          }
          if (variable.selectedJumlahPenumpang == "3") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                nikPassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                nikPassenggerController1.text == "" ||
                variable.foodPassengger1 == null ||
                variable.baggagePassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                nikPassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                nikPassenggerController2.text == "" ||
                variable.foodPassengger2 == null ||
                variable.baggagePassengger2 == null ||
                namePassenggerController3.text == null ||
                phonePassenggerController3.text == null ||
                nikPassenggerController3.text == null ||
                namePassenggerController3.text == "" ||
                phonePassenggerController3.text == "" ||
                nikPassenggerController3.text == "" ||
                variable.foodPassengger3 == null ||
                variable.baggagePassengger3 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              variable.namePassengger1 = namePassenggerController1.text;
              variable.phonePassengger1 = phonePassenggerController1.text;
              variable.nikPassengger1 = nikPassenggerController1.text;
              variable.namePassengger2 = namePassenggerController2.text;
              variable.phonePassengger2 = phonePassenggerController2.text;
              variable.nikPassengger2 = nikPassenggerController2.text;
              variable.namePassengger3 = namePassenggerController3.text;
              variable.phonePassengger3 = phonePassenggerController3.text;
              variable.nikPassengger3 = nikPassenggerController3.text;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            }
          }
          if (variable.selectedJumlahPenumpang == "4") {
            if (namePassenggerController1.text == null ||
                phonePassenggerController1.text == null ||
                nikPassenggerController1.text == null ||
                namePassenggerController1.text == "" ||
                phonePassenggerController1.text == "" ||
                nikPassenggerController1.text == "" ||
                variable.foodPassengger1 == null ||
                variable.baggagePassengger1 == null ||
                namePassenggerController2.text == null ||
                phonePassenggerController2.text == null ||
                nikPassenggerController2.text == null ||
                namePassenggerController2.text == "" ||
                phonePassenggerController2.text == "" ||
                nikPassenggerController2.text == "" ||
                variable.foodPassengger2 == null ||
                variable.baggagePassengger2 == null ||
                namePassenggerController3.text == null ||
                phonePassenggerController3.text == null ||
                nikPassenggerController3.text == null ||
                namePassenggerController3.text == "" ||
                phonePassenggerController3.text == "" ||
                nikPassenggerController3.text == "" ||
                variable.foodPassengger3 == null ||
                variable.baggagePassengger3 == null ||
                namePassenggerController4.text == null ||
                phonePassenggerController4.text == null ||
                nikPassenggerController4.text == null ||
                namePassenggerController4.text == "" ||
                phonePassenggerController4.text == "" ||
                nikPassenggerController4.text == "" ||
                variable.foodPassengger4 == null ||
                variable.baggagePassengger4 == null) {
              Fluttertoast.showToast(
                msg: "Lengkapi data terlebih dahulu",
                backgroundColor: CustomColor.red,
                textColor: CustomColor.white,
                gravity: ToastGravity.CENTER,
              );
            } else {
              variable.namePassengger1 = namePassenggerController1.text;
              variable.phonePassengger1 = phonePassenggerController1.text;
              variable.nikPassengger1 = nikPassenggerController1.text;
              variable.namePassengger2 = namePassenggerController2.text;
              variable.phonePassengger2 = phonePassenggerController2.text;
              variable.nikPassengger2 = nikPassenggerController2.text;
              variable.namePassengger3 = namePassenggerController3.text;
              variable.phonePassengger3 = phonePassenggerController3.text;
              variable.nikPassengger3 = nikPassenggerController3.text;
              variable.namePassengger4 = namePassenggerController4.text;
              variable.phonePassengger4 = phonePassenggerController4.text;
              variable.nikPassengger4 = nikPassenggerController4.text;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentScreen()));
            }
          }
        },
      ),
    );
  }

  void _navigatePickSeat(BuildContext context) async {
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
}
