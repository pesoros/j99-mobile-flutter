// ignore_for_file: unused_import

import 'dart:convert';

import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/filter_screen.dart';
import 'package:juragan99/screens/sort_by_screen.dart';

import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/bus_ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:http/http.dart' as http;

import 'package:juragan99/data/bus.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter/foundation.dart';

class SearchResultScreen extends StatefulWidget {
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  double bottomPadding = 0;
  List<Bus> _listBus = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await BusList.list().then((value) {
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
          // border: Border.all(color: Colors.black.withOpacity(0.4)),
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
                  height: 40,
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
                              size: 22,
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
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hasil Pencarian",
                                  style: TextStyle(
                                      color: CustomColor.white,
                                      fontSize: 20,
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
                        Text(
                          "JKT",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Jakarta",
                          style:
                              TextStyle(color: CustomColor.grey, fontSize: 16),
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
                        Text(
                          "SUB",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Surabaya",
                          style:
                              TextStyle(color: CustomColor.grey, fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Text(
                      "24 November 2022",
                      style: TextStyle(fontSize: 16, color: CustomColor.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  filterWidget(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
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
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => SortByScreen()));
            //   },
            //   child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [Text("Urut Berdasarkan")]),
            // ),
            // VerticalDivider(
            //   width: 1,
            //   color: Colors.black26,
            //   thickness: 1,
            // ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FilterScreen()));
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.settings,
                  size: 12,
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
            ),
          ],
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
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
            Bus bus = _listBus[index];
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
              child: BusTicketWidget(
                bus: bus,
                trip_id_no: bus.trip_id_no,
                trip_route_id: bus.trip_route_id,
                shedule_id: bus.shedule_id,
                pickup_trip_location: bus.pickup_trip_location,
                drop_trip_location: bus.drop_trip_location,
                type: bus.type,
                fleet_seats: bus.fleet_seats,
                price: bus.price,
                duration: bus.duration,
                start: bus.start,
                end: bus.end,
                seatPicked: bus.seatPicked,
                seatAvail: bus.seatAvail,
              ),
            );
          },
        ),
      ),
    );
  }
}
