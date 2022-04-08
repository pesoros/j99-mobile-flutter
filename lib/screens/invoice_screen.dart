// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable

import 'package:indonesia/indonesia.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/slot_pergi.dart';
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
import 'package:flutter/services.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class InvoiceScreen extends StatefulWidget {
  String booking_code;

  InvoiceScreen({
    this.booking_code,
  });
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
        child: Center(
          child: _invoiceWidget(context),
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
                width: MediaQuery.of(context).size.width / 1.5,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Cek Status Pembayaran",
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
                  MaterialPageRoute(
                      builder: (context) => PaymentStatusScreen(
                          booking_code: widget.booking_code)),
                  (Route<dynamic> route) => false,
                );
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
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              _data(
                  variable.pergi_type_class +
                      ": " +
                      variable.selectedToCity.toString() +
                      " - " +
                      variable.selectedFromCity.toString(),
                  "x " + variable.selectedJumlahPenumpang + " Tiket"),
              (variable.checkPulangPergi == true)
                  ? _data(
                      variable.pulang_type_class +
                          ": " +
                          variable.selectedToCity.toString() +
                          " - " +
                          variable.selectedFromCity.toString(),
                      "x " + variable.selectedJumlahPenumpang + " Tiket")
                  : Padding(padding: EdgeInsets.only()),
              // Divider(
              //   color: Colors.grey,
              // ),
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Total Pembayaran: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                          ),
                        ),
                        Text(
                          rupiah(variable.total_price),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.defaultTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "Disalin",
                              backgroundColor: CustomColor.red,
                              textColor: CustomColor.white,
                              gravity: ToastGravity.CENTER,
                            );
                            Clipboard.setData(
                                new ClipboardData(text: variable.total_price));
                          },
                          child: Text(
                            "Salin",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: Dimensions.defaultTextSize),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              _dataPembayaran("Bank:", variable.bank_code),
              _dataPembayaran("Kode Bank:", variable.merchant_code),
              _dataPembayaran("Nomor Rekening:", ""),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    variable.account_number,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "Disalin",
                        backgroundColor: CustomColor.red,
                        textColor: CustomColor.white,
                        gravity: ToastGravity.CENTER,
                      );
                      Clipboard.setData(
                          new ClipboardData(text: variable.account_number));
                    },
                    child: Text(
                      "Salin",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: Dimensions.defaultTextSize),
                    ),
                  )
                ],
              ),
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
                color: Colors.black,
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
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
