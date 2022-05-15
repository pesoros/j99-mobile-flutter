// ignore_for_file: unused_import, must_be_immutable, unused_element, unused_field, non_constant_identifier_names, missing_required_param

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:juragan99/data/city.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/unit_type.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/search_result_pulang_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FilterPulangScreen extends StatefulWidget {
  @override
  _FilterPulangScreenState createState() => _FilterPulangScreenState();
}

class _FilterPulangScreenState extends State<FilterPulangScreen> {
  String _valSortBy;
  List sortBy = [
    "Harga Terendah",
    "Harga Tertinggi",
    "Keberangkatan Awal",
    "Keberangkatan Akhir",
    "Kedatangan Awal",
    "Kedatangan Akhir",
  ];

  String _valUnitType;
  List unitType = [];

  String _valFromCity;
  String _valToCity;
  List city = [];

  DateTime selectedDatePulang = DateTime.now();

  String _valJumlahPenumpang;
  List<String> jumlahPenumpang = ["1", "2", "3", "4"];

  String _valClassList;
  List classList = [];

  @override
  void initState() {
    super.initState();
    getUnitType();
    getCity();
    getClassList();
  }

  getUnitType() async {
    var response = await Dio().post(dotenv.env['BASE_URL'] + "/dataunit");
    var data = UnitTypeModel.fromJsonList(response.data);
    setState(() {
      unitType = data;
    });
  }

  getCity() async {
    var response = await Dio().post(dotenv.env['BASE_URL'] + "/datakota");
    var data = CityModel.fromJsonList(response.data);
    setState(() {
      city = data;
    });
  }

  getClassList() async {
    var response = await Dio().post(dotenv.env['BASE_URL'] + "/datakelas");
    var data = ClassModel.fromJsonList(response.data);
    setState(() {
      classList = data;
    });
  }

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
          Center(
              child: Text(
            "Filter",
            style: TextStyle(fontSize: Dimensions.defaultTextSize),
          )),
          // SizedBox(height: 10),
          // _unitType(context),
          // SizedBox(height: 10),
          // _datePulang(context),
          // SizedBox(height: 10),
          // _jumlahPenumpang(context),
          // SizedBox(height: 10),
          // _cityFrom(context),
          // SizedBox(height: 10),
          // _cityTo(context),
          SizedBox(height: 10),
          _classList(context),
          SizedBox(height: 10),
          _sortBy(context),
        ],
      ),
    );
  }

  _unitType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Tipe Unit"),
                value: _valUnitType,
                items: unitType.map((value) {
                  return DropdownMenuItem(
                    child: Text(value.toString()),
                    value: value.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valUnitType = value.toString();
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _cityFrom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Kota Keberangkatan"),
                value: _valFromCity,
                items: city.map((value) {
                  return DropdownMenuItem(
                    child: Text(value.toString()),
                    value: value.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valFromCity = value.toString();
                    variable.selectedFromCity = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _cityTo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Kota Tujuan"),
                value: _valToCity,
                items: city.map((value) {
                  return DropdownMenuItem(
                    child: Text(value.toString()),
                    value: value.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valToCity = value.toString();
                    variable.selectedToCity = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _sortBy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Urut Berdasarkan"),
                value: _valSortBy,
                items: sortBy.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valSortBy = value;
                    variable.pulang_sort_by = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _datePulang(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1), width: 1))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(),
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
            __datePulang(context);
          },
        ),
      ],
    );
  }

  __datePulang(BuildContext context) async {
    final DateTime pickedPulang = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: selectedDatePulang,
        maxTime: selectedDatePulang.add(Duration(days: 90)),
        currentTime: selectedDatePulang,
        locale: LocaleType.id);
    setState(() {
      selectedDatePulang = pickedPulang;
      variable.datePulang = "${selectedDatePulang.toLocal()}".split(' ')[0];
    });
  }

  _jumlahPenumpang(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Jumlah Penumpang"),
                value: _valJumlahPenumpang,
                items: jumlahPenumpang.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valJumlahPenumpang = value;
                    variable.selectedJumlahPenumpang = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _classList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Kelas"),
                value: _valClassList,
                items: classList.map((value) {
                  var id = value.id;
                  var kelas = value.kelas;
                  return DropdownMenuItem(
                    child: Text(kelas.toString()),
                    value: id.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valClassList = value.toString();
                    variable.selectedKelasArmada = value.toString();
                  });
                },
              ),
            ),
          ),
        ),
      ],
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
          if (_valClassList == null) {
            variable.selectedKelasArmada = "";
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
