// ignore_for_file: unused_import, non_constant_identifier_names, unused_field, unused_element

import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/package.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/data/ticket.dart';
import 'package:juragan99/data/ticket_list.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class TicketResultScreen extends StatefulWidget {
  final String booking_code;

  TicketResultScreen({this.booking_code});

  @override
  _TicketResultScreen createState() => _TicketResultScreen();
}

class _TicketResultScreen extends State<TicketResultScreen> {
  bool isLoadingPackage = true;
  bool isLoadingTrace = true;

  String booking_code;
  String round_trip;
  String payment_status;
  String total_price;
  String total_seat;
  String created_at;

  List<TicketPassanggerListModal> _ticketList = [];

  @override
  void initState() {
    super.initState();
    getTicket();
    getTicketList();
  }

  getTicket() async {
    await Ticket.list(widget.booking_code).then((value) {
      setState(() {
        booking_code = value['booking_code'];
        round_trip = value['round_trip'];
        payment_status = value['payment_status'];
        total_price = value['total_price'];
        total_seat = value['total_seat'];
        created_at = value['created_at'];
        isLoadingPackage = false;
      });
    });
  }

  getTicketList() async {
    await TicketPassanggerList.list(widget.booking_code).then((value) {
      setState(() {
        _ticketList = value;
        isLoadingTrace = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.darkGrey,
        body: Stack(
          children: [
            (isLoadingPackage == true)
                ? Center(child: CircularProgressIndicator())
                : (isLoadingTrace == true)
                    ? Center(child: CircularProgressIndicator())
                    : bodyWidget(context),
            buttonWidget(context),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        // bottom: 70,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _resiWidget(context),
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
                width: MediaQuery.of(context).size.width / 2,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen(1)),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ));
  }

  _resiWidget(BuildContext context) {
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
                Text(
                  booking_code,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  payment_status,
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          _resiDetail(context),
        ],
      ),
    );
  }

  _resiDetail(BuildContext context) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(created_at);
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // _dataBooking("Kode Booking: ", booking_code),
              // _dataBooking("Status Pembayaran: ", payment_status),
              // _dataBooking("Perjalanan: ", round_trip),
              // _dataBooking("Total Penumpang: ", total_seat),
              _dataBooking("Total Harga: ", rupiah(total_price)),
              _dataBooking("Tanggal: ", tanggal(tempDate)),
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Text("Penumpang",
                  style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: _ticketList.length,
                  itemBuilder: (context, index) {
                    TicketPassanggerListModal ticket = _ticketList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _dataTicketPassanggerLeft(
                                  "No. Tiket: ", ticket.ticket_number),
                              _dataTicketPassanggerLeft("Nama: ", ticket.name),
                              _dataTicketPassanggerLeft("Kelas: ", ticket.type),
                              _dataTicketPassanggerLeft(
                                  "Keberangkatan: ", ticket.drop_trip_location),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _dataTicketPassanggerRight(
                                  "No. Kursi: ", ticket.seat_number),
                              _dataTicketPassanggerRight(
                                  "Bagasi: ", ticket.baggage),
                              _dataTicketPassanggerRight(
                                  "Makanan: ", ticket.food_name),
                              _dataTicketPassanggerRight(
                                  "Tujuan", ticket.drop_trip_location),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  _dataBooking(String title, String subTitle) {
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
            subTitle,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _dataTicketPassanggerLeft(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _dataTicketPassanggerRight(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.defaultTextSize,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
