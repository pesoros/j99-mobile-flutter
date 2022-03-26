// ignore_for_file: unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/filter_pergi_screen.dart';
import 'package:juragan99/screens/sort_by_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/bus_ticket_pergi_widget.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter/foundation.dart';

class SearchResultPergiScreen extends StatefulWidget {
  @override
  _SearchResultPergiScreenState createState() =>
      _SearchResultPergiScreenState();
}

class _SearchResultPergiScreenState extends State<SearchResultPergiScreen> {
  double bottomPadding = 0;
  List<BusPergi> _listBus = [];
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(variable.datePergi);

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getBusList();
  }

  getBusList() async {
    await BusPergiList.list().then((value) {
      setState(() {
        _listBus = value;
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              headerWidget(context),
              isLoading
                  ? bodyWidget(context)
                  : Center(child: CircularProgressIndicator()),
              filterWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)),
          color: CustomColor.darkGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColor.white,
                              size: Dimensions.defaultTextSize,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(0)),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hasil Pencarian",
                                  style: TextStyle(
                                      color: CustomColor.white,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "JKT",
                        //   style: TextStyle(
                        //       color: CustomColor.white,
                        //       fontSize: Dimensions.largeTextSize,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        Text(
                          variable.selectedFromCity.toString(),
                          style: TextStyle(
                              color: CustomColor.grey,
                              fontSize: Dimensions.largeTextSize),
                        ),
                      ],
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: MediaQuery.of(context).size.width / 3,
                      lineThickness: 1.0,
                      dashLength: 5.0,
                      dashColor: CustomColor.white,
                      dashGapLength: 5.0,
                      dashGapColor: Colors.transparent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(
                        //   "SUB",
                        //   style: TextStyle(
                        //       color: CustomColor.white,
                        //       fontSize: Dimensions.largeTextSize,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        Text(
                          variable.selectedToCity.toString(),
                          style: TextStyle(
                              color: CustomColor.grey,
                              fontSize: Dimensions.largeTextSize),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Text(
                      tanggal(tempDate, shortMonth: true),
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: CustomColor.white),
                    ),
                  ),
                  (variable.checkPulangPergi == true)
                      ? Container(
                          margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: Text(
                            "Tiket Pergi",
                            style: TextStyle(
                                fontSize: Dimensions.defaultTextSize,
                                color: CustomColor.white),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ));
  }

  filterWidget(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: GestureDetector(
        child: Container(
          height: 40,
          width: 100,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: CustomColor.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.settings,
                  size: Dimensions.defaultTextSize,
                  color: CustomColor.grey,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Filter",
                  style: TextStyle(color: CustomColor.grey),
                ),
              ]),
            ],
          ),
        ),
        onTap: () {
          _navigateFilterScreen(context);
        },
      ),
    );
  }

  bodyWidget(BuildContext context) {
    if (variable.pergi_sort_by == "Harga Terendah") {
      _listBus.sort((min, max) => min.pergi_price.compareTo(max.pergi_price));
    }
    if (variable.pergi_sort_by == "Harga Tertinggi") {
      _listBus.sort((min, max) => max.pergi_price.compareTo(min.pergi_price));
    }
    if (variable.pergi_sort_by == "Keberangkatan Awal") {
      _listBus.sort((min, max) => min.pergi_start.compareTo(max.pergi_start));
    }
    if (variable.pergi_sort_by == "Keberangkatan Akhir") {
      _listBus.sort((min, max) => max.pergi_start.compareTo(min.pergi_start));
    }
    if (variable.pergi_sort_by == "Kedatangan Awal") {
      _listBus.sort((min, max) => min.pergi_end.compareTo(max.pergi_end));
    }
    if (variable.pergi_sort_by == "Kedatangan Akhir") {
      _listBus.sort((min, max) => max.pergi_end.compareTo(min.pergi_end));
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 180,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _listBus.length,
          itemBuilder: (context, index) {
            BusPergi bus = _listBus[index];
            if (index == (_listBus.length - 1)) {
              bottomPadding = 70;
            } else {
              bottomPadding = Dimensions.heightSize * 1;
            }
            return Padding(
              padding: EdgeInsets.only(
                bottom: bottomPadding,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: BusTicketPergiWidget(
                bus: bus,
                trip_id_no: bus.pergi_trip_id_no,
                trip_route_id: bus.pergi_trip_route_id,
                shedule_id: bus.pergi_shedule_id,
                pickup_trip_location: bus.pergi_pickup_trip_location,
                drop_trip_location: bus.pergi_drop_trip_location,
                type: bus.pergi_type,
                type_class: bus.pergi_type_class,
                fleet_seats: bus.pergi_fleet_seats,
                fleet_registration_id: bus.pergi_fleet_seats,
                price: bus.pergi_price,
                duration: bus.pergi_duration,
                start: bus.pergi_start,
                end: bus.pergi_end,
                seatPicked: bus.pergi_seatPicked,
                seatAvail: bus.pergi_seatAvail,
              ),
            );
          },
        ),
      ),
    );
  }

  _navigateFilterScreen(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 300),
          opaque: false,
          pageBuilder: (_, __, ___) => FilterPergiScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          }),
    );
    getBusList();
    setState(() {});
  }
}
