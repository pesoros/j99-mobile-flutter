// ignore_for_file: unused_import, missing_return, unnecessary_statements, non_constant_identifier_names

import 'dart:convert';

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
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:juragan99/widgets/seat_plan_pergi_widget.dart';
import 'package:juragan99/widgets/seat_plan_pulang_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PassenggerFormScreen extends StatefulWidget {
  @override
  _PassenggerFormScreenState createState() => _PassenggerFormScreenState();
}

class _PassenggerFormScreenState extends State<PassenggerFormScreen> {
  bool acceptAttention = false;
  bool attentionContentBool = true;
  String attentionContent;

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

  List<FoodModel> listFoodPergi;
  List<FoodModel> listFoodPulang;

  getAttention() async {
    String url = dotenv.env['BASE_URL'] + "/content/disclaimer";
    var uri = Uri.parse(url);

    var response = await http.get(uri);
    setState(() {
      String data = html2md.convert(jsonDecode(response.body)["content"]);
      attentionContent = data;
      attentionContentBool = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAttention();
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
          SizedBox(height: 20),
          _attentionWidget(context),
          // SizedBox(height: 20),
          _acceptAttention(context),
          SizedBox(height: 20),
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
                      keyboardType: TextInputType.phone,
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
              (variable.selectedJumlahPenumpang == "1")
                  ? "Data Penumpang"
                  : "Data Penumpang 1",
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
                      keyboardType: TextInputType.phone,
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
                      popupItemBuilder: _customDropdown,
                      onFind: (String) async {
                        var response = await Dio().post(
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {
                            'idResto': variable.pergi_resto_id,
                            'class': variable.pergi_type
                          },
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
                            popupItemBuilder: _customDropdown,
                            onFind: (String) async {
                              var response = await Dio().post(
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {
                                  'idResto': variable.pulang_resto_id,
                                  'class': variable.pulang_type
                                },
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
              "Data Penumpang 2",
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
                      keyboardType: TextInputType.phone,
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
                      popupItemBuilder: _customDropdown,
                      onFind: (String) async {
                        var response = await Dio().post(
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {
                            'idResto': variable.pergi_resto_id,
                            'class': variable.pergi_type,
                          },
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
                            popupItemBuilder: _customDropdown,
                            onFind: (String) async {
                              var response = await Dio().post(
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {
                                  'idResto': variable.pulang_resto_id,
                                  'class': variable.pulang_type
                                },
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
              "Data Penumpang 3",
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
                      keyboardType: TextInputType.phone,
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
                      popupItemBuilder: _customDropdown,
                      onFind: (String) async {
                        var response = await Dio().post(
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {
                            'idResto': variable.pergi_resto_id,
                            'class': variable.pergi_type,
                          },
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
                            popupItemBuilder: _customDropdown,
                            onFind: (String) async {
                              var response = await Dio().post(
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {
                                  'idResto': variable.pulang_resto_id,
                                  'class': variable.pulang_type
                                },
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
              "Data Penumpang 4",
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
                      keyboardType: TextInputType.phone,
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
                      popupItemBuilder: _customDropdown,
                      onFind: (String) async {
                        var response = await Dio().post(
                          dotenv.env['BASE_URL'] + "/datarestomenu",
                          options: Options(
                              contentType: Headers.formUrlEncodedContentType),
                          data: {
                            'idResto': variable.pergi_resto_id,
                            'class': variable.pergi_type
                          },
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
                            popupItemBuilder: _customDropdown,
                            onFind: (String) async {
                              var response = await Dio().post(
                                dotenv.env['BASE_URL'] + "/datarestomenu",
                                options: Options(
                                    contentType:
                                        Headers.formUrlEncodedContentType),
                                data: {
                                  'idResto': variable.pulang_resto_id,
                                  'class': variable.pulang_type
                                },
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
            _validasiPenumpang1();
          }
          //2
          if (variable.selectedJumlahPenumpang == "2") {
            _validasiPenumpang2().then((value) {
              if (value) {
                _validasiPenumpang1();
              }
            });
          }
          //3
          if (variable.selectedJumlahPenumpang == "3") {
            _validasiPenumpang3().then((value) {
              if (value) {
                _validasiPenumpang2().then((value) {
                  if (value) {
                    _validasiPenumpang1();
                  }
                });
              }
            });
          }
          //4
          if (variable.selectedJumlahPenumpang == "4") {
            _validasiPenumpang4().then((value) {
              if (value) {
                _validasiPenumpang3().then((value) {
                  if (value) {
                    _validasiPenumpang2().then((value) {
                      if (value) {
                        _validasiPenumpang1();
                      }
                    });
                  }
                });
              }
            });
          }
        },
      ),
    );
  }

  Widget _customDropdown(
      BuildContext context, FoodModel item, bool isSelected) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.7, color: Colors.grey),
        ),
      ),
      padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.food_name,
            style: TextStyle(
                fontSize: Dimensions.extraLargeTextSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
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

  _attentionWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Column(
          children: [
            (attentionContentBool)
                ? SizedBox()
                : MarkdownBody(
                    data: attentionContent,
                  ),
          ],
        ),
      ),
    );
  }

  _acceptAttention(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Ya, Saya mengerti"),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: CustomColor.red,
              value: acceptAttention,
              onChanged: (bool value) {
                setState(() {
                  acceptAttention = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _notif(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: CustomColor.red,
      textColor: CustomColor.white,
      gravity: ToastGravity.CENTER,
    );
  }

  _goToPaymentScreen(BuildContext context) {
    if (acceptAttention) {
      setState(() {
        variable.namePassengger1 = namePassenggerController1.text ?? "";
        variable.phonePassengger1 = phonePassenggerController1.text;
        variable.namePassengger2 = namePassenggerController2.text;
        variable.phonePassengger2 = phonePassenggerController2.text;
        variable.namePassengger3 = namePassenggerController3.text;
        variable.phonePassengger3 = phonePassenggerController3.text;
        variable.namePassengger4 = namePassenggerController4.text;
        variable.phonePassengger4 = phonePassenggerController4.text;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
    } else {
      _notif("Setujui Disclaimer dahulu");
    }
  }

  _validasiPenumpang1() {
    if (namePassenggerController1.text == null ||
        namePassenggerController1.text.isEmpty) {
      _notif("Isi nama terlebih dahulu");
    } else {
      if (phonePassenggerController1.text == null ||
          phonePassenggerController1.text.isEmpty) {
        _notif("Isi nomor telepon terlebih dahulu");
      } else {
        if (variable.foodPergiPassengger1 == null) {
          _notif("Pilih makanan terlebih dahulu");
        } else {
          if (variable.baggagePergiPassengger1 == null) {
            _notif("Pilih bagasi terlebih dahulu");
          } else {
            if (variable.seatPergiPassengger1 == null) {
              _notif("Pilih kursi terlebih dahulu");
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger1 == null) {
                  _notif("Pilih makanan pulang terlebih dahulu");
                } else {
                  if (variable.baggagePulangPassengger1 == null) {
                    _notif("Pilih bagasi pulang terlebih dahulu");
                  } else {
                    if (variable.seatPulangPassengger1 == null) {
                      _notif("Pilih kursi pulang terlebih dahulu");
                    } else {
                      _goToPaymentScreen(context);
                    }
                  }
                }
              } else {
                _goToPaymentScreen(context);
              }
            }
          }
        }
      }
    }
  }

  _validasiPenumpang2() async {
    var val = true;
    if (namePassenggerController2.text == null ||
        namePassenggerController2.text.isEmpty) {
      _notif("Isi nama terlebih dahulu");
    } else {
      if (phonePassenggerController2.text == null ||
          phonePassenggerController2.text.isEmpty) {
        _notif("Isi nomor telepon terlebih dahulu");
      } else {
        if (variable.foodPergiPassengger2 == null) {
          _notif("Pilih makanan terlebih dahulu");
        } else {
          if (variable.baggagePergiPassengger2 == null) {
            _notif("Pilih bagasi terlebih dahulu");
          } else {
            if (variable.seatPergiPassengger2 == null) {
              _notif("Pilih kursi terlebih dahulu");
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger2 == null) {
                  _notif("Pilih makanan pulang terlebih dahulu");
                } else {
                  if (variable.baggagePulangPassengger2 == null) {
                    _notif("Pilih bagasi pulang terlebih dahulu");
                  } else {
                    if (variable.seatPulangPassengger2 == null) {
                      _notif("Pilih kursi pulang terlebih dahulu");
                    } else {
                      return val;
                    }
                  }
                }
              } else {
                return val;
              }
            }
          }
        }
      }
    }
  }

  _validasiPenumpang3() async {
    var val = true;
    if (namePassenggerController3.text == null ||
        namePassenggerController3.text.isEmpty) {
      _notif("Isi nama terlebih dahulu");
    } else {
      if (phonePassenggerController3.text == null ||
          phonePassenggerController3.text.isEmpty) {
        _notif("Isi nomor telepon terlebih dahulu");
      } else {
        if (variable.foodPergiPassengger3 == null) {
          _notif("Pilih makanan terlebih dahulu");
        } else {
          if (variable.baggagePergiPassengger3 == null) {
            _notif("Pilih bagasi terlebih dahulu");
          } else {
            if (variable.seatPergiPassengger3 == null) {
              _notif("Pilih kursi terlebih dahulu");
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger3 == null) {
                  _notif("Pilih makanan pulang terlebih dahulu");
                } else {
                  if (variable.baggagePulangPassengger3 == null) {
                    _notif("Pilih bagasi pulang terlebih dahulu");
                  } else {
                    if (variable.seatPulangPassengger3 == null) {
                      _notif("Pilih kursi pulang terlebih dahulu");
                    } else {
                      return val;
                    }
                  }
                }
              } else {
                return val;
              }
            }
          }
        }
      }
    }
  }

  _validasiPenumpang4() async {
    var val = true;
    if (namePassenggerController4.text == null ||
        namePassenggerController4.text.isEmpty) {
      _notif("Isi nama terlebih dahulu");
    } else {
      if (phonePassenggerController4.text == null ||
          phonePassenggerController4.text.isEmpty) {
        _notif("Isi nomor telepon terlebih dahulu");
      } else {
        if (variable.foodPergiPassengger4 == null) {
          _notif("Pilih makanan terlebih dahulu");
        } else {
          if (variable.baggagePergiPassengger4 == null) {
            _notif("Pilih bagasi terlebih dahulu");
          } else {
            if (variable.seatPergiPassengger4 == null) {
              _notif("Pilih kursi terlebih dahulu");
            } else {
              if (variable.checkPulangPergi == true) {
                if (variable.foodPulangPassengger4 == null) {
                  _notif("Pilih makanan pulang terlebih dahulu");
                } else {
                  if (variable.baggagePulangPassengger4 == null) {
                    _notif("Pilih bagasi pulang terlebih dahulu");
                  } else {
                    if (variable.seatPulangPassengger4 == null) {
                      _notif("Pilih kursi pulang terlebih dahulu");
                    } else {
                      return val;
                    }
                  }
                }
              } else {
                return val;
              }
            }
          }
        }
      }
    }
  }
}
