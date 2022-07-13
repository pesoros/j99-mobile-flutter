// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable

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
import 'package:flutter/services.dart';
import 'package:html2md/html2md.dart' as html2md;

import 'package:juragan99/utils/variables.dart' as variable;
import 'package:url_launcher/url_launcher_string.dart';

class InvoiceScreen extends StatefulWidget {
  String booking_code;

  InvoiceScreen({
    this.booking_code,
  });
  @override
  _InvoiceWidgetScreen createState() => _InvoiceWidgetScreen();
}

class _InvoiceWidgetScreen extends State<InvoiceScreen> {
  bool isLoadingPackage = true;
  bool isLoadingTrace = true;
  bool isLoadingPayment = true;
  bool _expanded = false;

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

  List<PayemntTutorial> listPaymentTutorial = [];

  @override
  void initState() {
    super.initState();
    getTicket();
    getTicketPayment();
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
        List<PayemntTutorial> temp = [];
        for (var data in value['payment_tutorial'] as List) {
          temp.add(PayemntTutorial(
            channel: data['channel'],
            gate: data['gate'],
            title: data['title'],
            context: data['context'],
          ));
        }
        listPaymentTutorial = temp;
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
      child: (isLoadingPackage && isLoadingPayment)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
    DateFormat dateFormat = DateFormat("HH:mm - dd-MM-yyy");
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              _data(variable.pergi_type_class, ""),
              _data(variable.selectedFromCity.toString(),
                  "x " + variable.selectedJumlahPenumpang + " Tiket"),
              _data(variable.selectedToCity.toString(), ""),
              (variable.checkPulangPergi == true)
                  ? SizedBox(height: 10)
                  : Padding(padding: EdgeInsets.only()),
              (variable.checkPulangPergi == true)
                  ? _data(variable.pulang_type_class, "")
                  : Padding(padding: EdgeInsets.only()),
              (variable.checkPulangPergi == true)
                  ? _data(variable.selectedToCity.toString(),
                      "x " + variable.selectedJumlahPenumpang + " Tiket")
                  : Padding(padding: EdgeInsets.only()),
              (variable.checkPulangPergi == true)
                  ? _data(variable.selectedFromCity.toString(), "")
                  : Padding(padding: EdgeInsets.only()),
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 10),
              _tutorialPembayaran(),
              // SizedBox(height: 20),
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

  _tutorialPembayaran() {
    return ExpansionPanelList(
      elevation: 0,
      animationDuration: Duration(milliseconds: 300),
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(
                'Tata Cara Pembayaran',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            );
          },
          body: Column(
            children: [
              for (int i = 0; i < listPaymentTutorial.length; i++) ...[
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      listPaymentTutorial[i].channel +
                          " - " +
                          listPaymentTutorial[i].gate,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      html2md.convert(listPaymentTutorial[i].context),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ],
          ),
          isExpanded: _expanded,
          canTapOnHeader: true,
        ),
      ],
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {});
      },
    );
  }
}
