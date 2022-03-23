// ignore_for_file: unused_import

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/formater.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceWidgetScreen createState() => _InvoiceWidgetScreen();
}

class _InvoiceWidgetScreen extends State<InvoiceScreen> {
  List<ClassList> _classListPergi = [];
  List<ClassList> _classListPulang = [];

  @override
  void initState() {
    super.initState();
    getClassPergi();
    getClassPulang();
  }

  getClassPergi() async {
    await GetClassList.list(
      variable.pergi_type,
    ).then((value) {
      setState(() {
        _classListPergi = value;
      });
    });
  }

  getClassPulang() async {
    await GetClassList.list(
      variable.pergi_type,
    ).then((value) {
      setState(() {
        _classListPulang = value;
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
            // BackWidget(
            //   title: "Invoice Pembayaran",
            //   color: CustomColor.white,
            // ),
            bodyWidget(context),
            buttonWidget(context)
          ],
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
            _invoiceWidget(context),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 20, left: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Cek Tiket",
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
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 20, right: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Download Tiket",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {},
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
                Text("Invoice Pembayaran",
                    style: TextStyle(
                        color: CustomColor.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("#" + variable.external_id,
                    style: TextStyle(
                        color: CustomColor.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          _invoiceDetail(context),
        ],
      ),
    );
  }

  _invoiceDetail(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _data(
                  (_classListPergi.length == 0)
                      ? variable.pergi_type +
                          ": " +
                          variable.pergi_pickup_trip_location +
                          " - " +
                          variable.pergi_drop_trip_location
                      : _classListPergi[0].kelas +
                          ": " +
                          variable.pergi_pickup_trip_location +
                          " - " +
                          variable.pergi_drop_trip_location,
                  "x " + variable.selectedJumlahPenumpang + " Tiket"),
              (variable.checkPulangPergi == true)
                  ? _data(
                      (_classListPulang.length == 0)
                          ? variable.pergi_type +
                              ": " +
                              variable.pulang_pickup_trip_location +
                              " - " +
                              variable.pulang_drop_trip_location
                          : _classListPulang[0].kelas +
                              ": " +
                              variable.pulang_pickup_trip_location +
                              " - " +
                              variable.pulang_drop_trip_location,
                      "x " + variable.selectedJumlahPenumpang + " Tiket")
                  : Padding(padding: EdgeInsets.only()),
              Divider(
                color: Colors.grey,
              ),
              _data(
                  "Total Pembayaran",
                  "Rp. " +
                      currencyFormatter
                          .format(double.parse(variable.total_price))),
              SizedBox(height: 20),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 20),
              _dataPembayaran("Bank:", variable.bank_code),
              _dataPembayaran("Kode Bank:", variable.merchant_code),
              _dataPembayaran("Nomor Rekening:", variable.account_number),
            ],
          ),
        ));
  }

  _data(String title, String price) {
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
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
        ],
      ),
    );
  }

  _dataPembayaran(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          SizedBox(width: 5),
          Text(
            value,
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
