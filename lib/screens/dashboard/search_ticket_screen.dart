// ignore_for_file: unused_import

import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/bus_ticket_pergi_widget.dart';
import 'package:juragan99/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';

class SearchTicketScreen extends StatefulWidget {
  @override
  _SearchTicketScreenState createState() => _SearchTicketScreenState();
}

class _SearchTicketScreenState extends State<SearchTicketScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            bodyWidget(context),
            searchTiketWidget(context),
          ],
        ),
      )),
    );
  }

  bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // _ticketWidget(context),
              // _ticketWidget(context),
              // _ticketWidget(context),
              // _ticketWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  searchTiketWidget(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                color: CustomColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  child: TextFormField(
                                    style: CustomStyle.textStyle,
                                    controller: numberController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return Strings.pleaseFillOutTheField;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Nomor Booking / Tiket",
                                      contentPadding: EdgeInsets.only(left: 10),
                                      labelStyle: CustomStyle.textStyle,
                                      focusedBorder: CustomStyle.focusBorder,
                                      enabledBorder:
                                          CustomStyle.focusErrorBorder,
                                      focusedErrorBorder:
                                          CustomStyle.focusErrorBorder,
                                      errorBorder: CustomStyle.focusErrorBorder,
                                      hintStyle: CustomStyle.textStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 10, left: 20, right: 20),
                      child: GestureDetector(
                        child: Container(
                          height: Dimensions.buttonHeight,
                          decoration: BoxDecoration(
                              color: CustomColor.red,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "CARI PAKET",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => SearchResultScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize,
      right: Dimensions.marginSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Image.asset('assets/images/pdf.png'),
                  Text(
                    Strings.downloadPdf,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Image.asset('assets/images/gdrive.png'),
                  Text(
                    Strings.googleDrive,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Image.asset('assets/images/share.png'),
                  Text(
                    Strings.shareTicket,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // _ticketWidget(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 20),
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //         left: Dimensions.marginSize,
  //         right: Dimensions.marginSize,
  //       ),
  //       child: BusTicketWidget(
  //         image: 'assets/images/qrcode.png',
  //         name: 'Green Wheel',
  //         cityFrom: 'Surabaya',
  //         cityTo: 'Jakarta',
  //         agentFrom: 'Agen Darmo',
  //         agentTo: 'Agen Sunter',
  //         hourFrom: '08:00',
  //         hourTo: '23:00',
  //         rating: 5,
  //         environment: 'AC',
  //         journeyStart: 'Gabtoli Bus Stand (8:30)',
  //         price: 95,
  //       ),
  //     ),
  //   );
  // }
}
