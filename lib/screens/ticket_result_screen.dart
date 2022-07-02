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
import 'package:juragan99/screens/passengger_ticket_result_screen.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:juragan99/utils/variables.dart' as variable;
import 'package:url_launcher/url_launcher_string.dart';

class TicketResultScreen extends StatefulWidget {
  final String booking_code;

  TicketResultScreen({this.booking_code});

  @override
  _TicketResultScreen createState() => _TicketResultScreen();
}

class _TicketResultScreen extends State<TicketResultScreen> {
  bool isLoadingPackage = true;
  bool isLoadingTrace = true;
  bool isLoadingPayment = true;

  String booking_code;
  String round_trip;
  String payment_status;
  String total_price;
  String total_seat;
  String created_at;
  String expired;

  String payment_method;
  String payment_channel_code;
  String va_number;
  String dekstop_link;
  String mobile_link;

  List<TicketPassanggerListModal> _ticketList = [];

  @override
  void initState() {
    super.initState();
    getTicket();
    getTicketPayment();
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
        expired = value['expired'];
        isLoadingPackage = false;
      });
    });
  }

  getTicketPayment() async {
    await TicketPayment.list(widget.booking_code).then((value) {
      setState(() {
        payment_method = value['payment_method'];
        payment_channel_code = value['payment_channel_code'];
        va_number = value['va_number'];
        dekstop_link = value['dekstop_link'];
        mobile_link = value['mobile_link'];
        isLoadingPayment = false;
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
                    : (isLoadingPayment == true)
                        ? Center(child: CircularProgressIndicator())
                        : bodyWidget(context),
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
            SizedBox(height: 30),
            buttonWidget(context),
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
                  (payment_status == "0")
                      ? "Belum Dibayar"
                      : (payment_status == "1")
                          ? "Sudah Dibayar"
                          : "Gagal",
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
    DateFormat dateFormat = DateFormat("HH:mm - dd-MM-yyy");
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _dataBooking("Metode Pembayaran: ", payment_method),
              _dataBooking("Bank: ", payment_channel_code),
              (payment_method == "EWALLET")
                  ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.heightSize * 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Link Pembayaran: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize),
                          ),
                          InkWell(
                              child: new Text(
                                'Link',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: Dimensions.defaultTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () => launchUrlString(mobile_link)),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.heightSize * 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (payment_method == "VIRTUAL_ACCOUNT")
                                ? "No. Virtual Account:"
                                : "No. Rekening:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                    msg: "Disalin",
                                    backgroundColor: CustomColor.red,
                                    textColor: CustomColor.white,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Clipboard.setData(
                                      new ClipboardData(text: va_number));
                                },
                                child: Text(
                                  "Salin",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: Dimensions.defaultTextSize),
                                ),
                              ),
                              Text(
                                "  " + va_number,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.defaultTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20),
              _dataBooking("Total Harga: ", rupiah(total_price)),
              _dataBooking("Tanggal Pesanan: ",
                  dateFormat.format(DateTime.parse(created_at)).toString()),
              _dataBooking("Bayar sebelum: ",
                  dateFormat.format(DateTime.parse(expired)).toString()),
              SizedBox(height: 20),
              _dataBooking(
                  "Tanggal Pergi:",
                  dateFormat
                      .format(DateTime.parse(_ticketList[0].booking_date))
                      .toString()),
              (round_trip == "1")
                  ? _dataBooking(
                      "Tanggal Pulang:",
                      dateFormat
                          .format(DateTime.parse(
                              _ticketList[_ticketList.length - 1].booking_date))
                          .toString())
                  : SizedBox(),
              _dataBooking(
                  "Pulang Pergi? ", (round_trip == "0") ? "Tidak" : "Ya"),
              _dataBooking("Perjalanan: ", _ticketList[0].pickup_trip_location),
              _dataBooking(" ", _ticketList[0].drop_trip_location),
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
                // height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _ticketList.length,
                  itemBuilder: (context, index) {
                    TicketPassanggerListModal ticket = _ticketList[index];
                    return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // _dataTicketPassangger(
                                //     "No. Tiket: ", ticket.ticket_number),
                                _dataTicketPassangger("Nama: ", ticket.name),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.heightSize * 0.5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ticket.pickup_trip_location,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        " - ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dimensions.defaultTextSize),
                                      ),
                                      Text(
                                        ticket.drop_trip_location,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.defaultTextSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            (payment_status == "1")
                                ? Column()
                                : Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PassenggerTicketResultScreen(
                                                booking_code:
                                                    ticket.ticket_number,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Cek Tiket",
                                          style: TextStyle(
                                            fontSize:
                                                Dimensions.defaultTextSize,
                                            color: CustomColor.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ));
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

  _dataTicketPassangger(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
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
}
