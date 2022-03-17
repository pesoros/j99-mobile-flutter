// ignore_for_file: unused_import

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/slot_pergi.dart';
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

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceWidgetScreen createState() => _InvoiceWidgetScreen();
}

class _InvoiceWidgetScreen extends State<InvoiceScreen> {
  @override
  void initState() {
    super.initState();
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
                        fontSize: Dimensions.largeTextSize,
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
                        fontSize: Dimensions.largeTextSize,
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
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      // height: 400,
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
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("#" + variable.payment_id,
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
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _data(
                  variable.pergi_pickup_trip_location +
                      " - " +
                      variable.pergi_drop_trip_location +
                      " x " +
                      variable.selectedJumlahPenumpang,
                  double.parse(variable.pergi_price)),
              _data("Promo", 0),
              Divider(
                color: Colors.grey,
              ),
              _data(Strings.total.toUpperCase(), 600000),
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

  _data(String title, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.largeTextSize),
          ),
          Text(
            '\Rp ${price.toString()}',
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.largeTextSize),
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
                color: Colors.black, fontSize: Dimensions.largeTextSize),
          ),
          SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
