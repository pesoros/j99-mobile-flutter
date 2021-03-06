// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:dotted_line/dotted_line.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:juragan99/data/ticket_list.dart';
import 'package:juragan99/screens/payment_status_screen.dart';
import 'package:juragan99/screens/ticket_result_screen.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/bus_ticket_pergi_widget.dart';
import 'package:juragan99/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class SearchTicketScreen extends StatefulWidget {
  @override
  _SearchTicketScreenState createState() => _SearchTicketScreenState();
}

class _SearchTicketScreenState extends State<SearchTicketScreen> {
  List<TicketListModal> _ticketList = [];
  String keteranganText = "Login terlebih dahulu";
  bool emptyList = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    if (variable.email == null || variable.email == "") {
    } else {
      getTicketList();
    }
  }

  getTicketList() async {
    await TicketList.list().then(
      (value) {
        if (value == null) {
          setState(() {
            emptyList = true;
          });
          return "false";
        } else {
          setState(() {
            _ticketList = value;
            emptyList = false;
          });
          return "false";
        }
      },
    );
  }

  void _onRefresh() {
    getTicketList();
    Future.delayed(const Duration(milliseconds: 1000), () {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    _ticketList.sort((min, max) => max.created_at.compareTo(min.created_at));
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: (variable.email == "" || variable.email == null)
            ? Center(
                child: Text("Login terlebih dahulu"),
              )
            : (emptyList)
                ? Center(
                    child: Text("Buat pesanan terlebih dahulu"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _ticketList.length,
                    itemBuilder: (context, index) {
                      TicketListModal ticket = _ticketList[index];
                      return Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Center(
                            child: _listTicketBody(
                          ticket.booking_code,
                          ticket.round_trip,
                          ticket.payment_status,
                          ticket.total_price,
                          ticket.total_seat,
                          ticket.created_at,
                          ticket.from,
                          ticket.to,
                        )),
                      );
                    }),
      ),
    );
  }

  _listTicketBody(
    String booking_code,
    String round_trip,
    String payment_status,
    String total_price,
    String total_seat,
    String created_at,
    String from,
    String to,
  ) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black12, width: 1)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              __listTicketBody(
                context,
                booking_code,
                round_trip,
                payment_status,
                total_price,
                total_seat,
                created_at,
                from,
                to,
              ),
            ],
          ),
        ),
      ),
    );
  }

  __listTicketBody(
    BuildContext context,
    String booking_code,
    String round_trip,
    String payment_status,
    String total_price,
    String total_seat,
    String created_at,
    String from,
    String to,
  ) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(created_at);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              from,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.defaultTextSize),
            ),
            Row(
              children: [
                Text(
                  "Status: ",
                  style: TextStyle(
                      color: CustomColor.darkGrey,
                      fontSize: Dimensions.smallTextSize),
                ),
                Text(
                  (payment_status == "0")
                      ? "Belum Dibayar"
                      : (payment_status == "1")
                          ? "Sudah Dibayar"
                          : (payment_status == "2")
                              ? "Gagal"
                              : "",
                  style: TextStyle(
                      color: (payment_status == "0")
                          ? CustomColor.darkGrey
                          : (payment_status == "1")
                              ? CustomColor.red
                              : CustomColor.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.smallTextSize),
                ),
              ],
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            to,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.defaultTextSize),
          ),
        ]),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("No. Booking: ",
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.smallTextSize)),
                Text(booking_code,
                    style: TextStyle(
                        color: CustomColor.darkGrey,
                        fontSize: Dimensions.smallTextSize)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(tanggal(tempDate),
                    style: TextStyle(
                        color: CustomColor.darkGrey,
                        fontSize: Dimensions.smallTextSize)),
              ],
            ),
          ],
        ),
        SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total Kursi: ",
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.smallTextSize)),
            Text(total_seat,
                style: TextStyle(
                    color: CustomColor.darkGrey,
                    fontSize: Dimensions.smallTextSize)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  rupiah(total_price),
                  style: TextStyle(
                      color: CustomColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
            Row(
              children: [
                (payment_status == "2")
                    ? Container(width: 60, height: 30)
                    : GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: CustomColor.red,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            "Cek Tiket",
                            style: TextStyle(
                                color: CustomColor.white,
                                fontSize: Dimensions.smallTextSize),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentStatusScreen(
                                booking_code: booking_code,
                              ),
                            ),
                          );
                        },
                      )
              ],
            )
          ],
        )
      ],
    );
  }
}
