// ignore_for_file: unused_import, must_be_immutable, unused_element

import 'dart:async';

import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/filter_pulang_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class FilterPergiScreen extends StatefulWidget {
  @override
  _FilterPergiScreenState createState() => _FilterPergiScreenState();
}

class _FilterPergiScreenState extends State<FilterPergiScreen> {
  String _valSortBy;
  List sortBy = [
    "Harga Terendah",
    "Harga Tertinggi",
    "Keberangkatan Awal",
    "Keberangkatan Akhir",
    "Kedatangan Awal",
    "Kedatangan Akhir",
  ];
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
          // _chooseClassWidget(context),
          SizedBox(height: 30),
          _sortBy(context),
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

  _sortBy(BuildContext context) {
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
                    variable.pergi_sort_by = value;
                  });
                },
              ),
            ),
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
}
