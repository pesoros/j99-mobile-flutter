// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable

import 'dart:convert';
import 'dart:typed_data';

import 'package:dotted_line/dotted_line.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/data/ticket.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/screens/payment_status_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class PassenggerTicketResultScreen extends StatefulWidget {
  String booking_code;

  PassenggerTicketResultScreen({
    this.booking_code,
  });

  @override
  _PassenggerTicketResultWidgetScreen createState() =>
      _PassenggerTicketResultWidgetScreen();
}

class _PassenggerTicketResultWidgetScreen
    extends State<PassenggerTicketResultScreen> {
  String booking_code = "";
  String name = "";
  String phone = "";
  String ticket_number = "";
  String type = "";
  String seat_number = "";
  String pickup_trip_location = "";
  String drop_trip_location = "";
  String booking_date = "";
  String baggage = "";
  String food_name = "";
  String price = "";
  String code_type = "";
  String qrcode = "";

  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPassenggerDetail();
  }

  getScreenShot() {
    ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer,
        originalSize, "Ticket", "$name-$ticket_number.png", "image/png",
        text: "");
  }

  getPassenggerDetail() async {
    await Ticket.list(widget.booking_code).then((value) {
      setState(() {
        booking_code = value['booking_code'];
        name = value['name'];
        phone = value['phone'];
        ticket_number = value['ticket_number'];
        type = value['type'];
        seat_number = value['seat_number'];
        pickup_trip_location = value['pickup_trip_location'];
        drop_trip_location = value['drop_trip_location'];
        booking_date = value['booking_date'];
        baggage = value['baggage'];
        food_name = value['food_name'];
        price = value['price'];
        code_type = value['code_type'];
        qrcode = value['qrcode'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.darkGrey,
        body: Stack(
          children: [bodyWidget(context), buttonWidget(context)],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 70,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RepaintBoundary(
              key: previewContainer,
              child: (isLoading)
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()))
                  : _invoiceWidget(context),
            )
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Kembali",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 20),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Kirim Tiket",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                getScreenShot();
              },
            ),
          ],
        ));
  }

  _invoiceWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColor.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tiket Penumpang",
                    style: TextStyle(
                        color: CustomColor.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _invoiceDetail(context),
        ],
      ),
    );
  }

  _invoiceDetail(BuildContext context) {
    String new_qrcode = qrcode.substring(22);
    Uint8List bytes = base64Decode(new_qrcode);
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(booking_date);
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: Column(
                children: [
                  _dataHeader("Nama: ", name),
                  _dataHeader("No. Handphone: ", phone),
                  _dataHeader("Kode Booking: ", booking_code),
                  _dataHeader("No. Tiket: ", ticket_number),
                  _dataHeader("Tanggal: ", tanggal(tempDate)),
                  _dataHeader("Harga: ", rupiah(price)),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dataTrip("Asal", pickup_trip_location),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: MediaQuery.of(context).size.width / 3,
                    lineThickness: 1.0,
                    dashLength: 5.0,
                    dashColor: CustomColor.darkGrey,
                    dashGapLength: 5.0,
                    dashGapColor: Colors.transparent,
                  ),
                  _dataTrip("Tujuan", drop_trip_location),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dataBody("No. Kursi", seat_number),
                  _dataBody("Bagasi", baggage),
                  _dataBody("Makanan", food_name),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 20),
            Image.memory(bytes),
            SizedBox(height: 20),
          ],
        ));
  }

  _dataHeader(String title, String price) {
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
            price,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _dataTrip(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          Text(
            price,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _dataBody(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          Text(
            price,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
