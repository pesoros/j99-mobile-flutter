// ignore_for_file: unused_import

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/data/payment.dart';
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

class PaymentMethodWidget extends StatefulWidget {
  @override
  _PaymentMethodWidgetScreen createState() => _PaymentMethodWidgetScreen();
}

class _PaymentMethodWidgetScreen extends State<PaymentMethodWidget> {
  List list = [];
  List li = [];
  int index = 0;
  List<Payment> _paymentList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await PaymentList.list().then((value) {
      setState(() {
        _paymentList = value;
        isLoading = true;
      });
      getPaymentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BackWidget(
              title: "Pilih Metode Pembayaran",
            ),
            isLoading
                ? bodyWidget(context)
                : Center(child: CircularProgressIndicator()),
            // buttonWidget(context)
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 70,
        bottom: 0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _availableSeatWidget(context),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          margin: EdgeInsets.only(bottom: 20, left: 40, right: 40),
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  _availableSeatWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize,
            bottom: Dimensions.heightSize,
          ),
          child: Column(
            children: [
              _allTicketWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _allTicketWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(_paymentList.length, (index) {
          Payment payment = _paymentList[index];
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: CustomColor.grey.withOpacity(0.5)),
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${payment.channel_code}'.toUpperCase(),
                        style: TextStyle(
                            color: CustomColor.darkGrey,
                            fontSize: Dimensions.defaultTextSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ]),
              ),
              onTap: () async {
                setState(() {
                  variable.selectedPayment = payment.channel_code;
                  variable.selectedPaymentCategories = payment.channel_category;
                });
                Navigator.of(context).pop();
              },
            ),
          );
        }),
      ),
    );
  }

  void getPaymentList() {
    int data = _paymentList.length;
    for (int i = 0; i < data; i++) {
      Payment payment = _paymentList[i];
      list.add(payment.is_enabled);
    }
  }
}
