// ignore_for_file: unused_import

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:juragan99/data/bus_pulang.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/filter_pergi_screen.dart';
import 'package:juragan99/screens/filter_pulang_screen.dart';
import 'package:juragan99/screens/sort_by_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/bus_ticket_pulang_widget.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:http/http.dart' as http;
import 'package:indonesia/indonesia.dart';

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter/foundation.dart';

class SearchResultPulangScreen extends StatefulWidget {
  @override
  _SearchResultPulangScreenState createState() =>
      _SearchResultPulangScreenState();
}

class _SearchResultPulangScreenState extends State<SearchResultPulangScreen> {
  double bottomPadding = 0;
  List<BusPulang> _listBus = [];
  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(variable.datePulang);

  bool isLoading = true;

  bool busNotAvailable = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await BusPulangList.list().then((value) {
      if (value != null) {
        setState(() {
          _listBus = value;
          isLoading = false;
          busNotAvailable = false;
          tempDate = new DateFormat("yyyy-MM-dd").parse(variable.datePulang);
        });
      } else {
        setState(() {
          isLoading = false;
          busNotAvailable = true;
          tempDate = new DateFormat("yyyy-MM-dd").parse(variable.datePulang);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: [
              headerWidget(context),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : busNotAvailable
                      ? Center(child: Text("Bus tidak tersedia."))
                      : bodyWidget(context),
              filterWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
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
                  padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
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
                          Navigator.pop(context);
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
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      variable.selectedToCity.toString(),
                      style: TextStyle(
                          color: CustomColor.grey,
                          fontSize: Dimensions.defaultTextSize),
                    ),
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
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      variable.selectedFromCity.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: CustomColor.grey,
                          fontSize: Dimensions.defaultTextSize),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Text(
                    tanggal(tempDate),
                    style: TextStyle(
                        fontSize: Dimensions.defaultTextSize,
                        color: CustomColor.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Text(
                    "Tiket Pulang",
                    style: TextStyle(
                        fontSize: Dimensions.defaultTextSize,
                        color: CustomColor.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
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
    if (variable.pulang_sort_by == "Harga Terendah") {
      _listBus.sort((min, max) => min.pulang_price.compareTo(max.pulang_price));
    }
    if (variable.pulang_sort_by == "Harga Tertinggi") {
      _listBus.sort((min, max) => max.pulang_price.compareTo(min.pulang_price));
    }
    if (variable.pulang_sort_by == "Keberangkatan Awal") {
      _listBus.sort((min, max) => min.pulang_start.compareTo(max.pulang_start));
    }
    if (variable.pulang_sort_by == "Keberangkatan Akhir") {
      _listBus.sort((min, max) => max.pulang_start.compareTo(min.pulang_start));
    }
    if (variable.pulang_sort_by == "Kedatangan Awal") {
      _listBus.sort((min, max) => min.pulang_end.compareTo(max.pulang_end));
    }
    if (variable.pulang_sort_by == "Kedatangan Akhir") {
      _listBus.sort((min, max) => max.pulang_end.compareTo(min.pulang_end));
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 180,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: _listBus.length,
          itemBuilder: (context, index) {
            BusPulang bus = _listBus[index];
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
              child: BusTicketPulangWidget(
                bus: bus,
                trip_id_no: bus.pulang_trip_id_no,
                trip_route_id: bus.pulang_trip_route_id,
                shedule_id: bus.pulang_shedule_id,
                pickup_trip_location: bus.pulang_pickup_trip_location,
                drop_trip_location: bus.pulang_drop_trip_location,
                type: bus.pulang_type,
                type_class: bus.pulang_type_class,
                image: bus.pulang_image,
                fleet_seats: bus.pulang_fleet_seats,
                fleet_registration_id: bus.pulang_fleet_registration_id,
                price: bus.pulang_price,
                duration: bus.pulang_duration,
                start: bus.pulang_start,
                end: bus.pulang_end,
                seatPicked: bus.pulang_seatPicked,
                seatAvail: bus.pulang_seatAvail,
                resto_id: bus.pulang_resto_id,
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateFilterScreen(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 300),
          opaque: false,
          pageBuilder: (_, __, ___) => FilterPulangScreen(),
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
    initializeData();
    setState(() {});
  }
}
