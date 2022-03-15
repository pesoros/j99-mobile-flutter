// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:dotted_line/dotted_line.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/formater.dart';

import 'package:juragan99/data/bus.dart';
import 'package:juragan99/data/slot.dart';
import 'package:juragan99/utils/variables.dart' as variable;

import 'package:juragan99/screens/passengger_form_screen.dart';

class BusTicketWidget extends StatefulWidget {
  final Bus bus;
  final String trip_id_no;
  final String trip_route_id;
  final String shedule_id;
  final String trip_route_name;
  final String pickup_trip_location;
  final String drop_trip_location;
  final String type;
  final String fleet_seats;
  final String price;
  final String duration;
  final String start;
  final String end;
  final String seatPicked;
  final int seatAvail;

  final String selectedJumlahPenumpang;
  final bool checkPulangPergi;

  BusTicketWidget({
    this.bus,
    this.trip_id_no,
    this.trip_route_id,
    this.shedule_id,
    this.trip_route_name,
    this.pickup_trip_location,
    this.drop_trip_location,
    this.type,
    this.fleet_seats,
    this.price,
    this.duration,
    this.start,
    this.end,
    this.seatPicked,
    this.seatAvail,
    this.selectedJumlahPenumpang,
    this.checkPulangPergi,
  });

  @override
  _BusTicketWidgetState createState() => _BusTicketWidgetState();
}

class _BusTicketWidgetState extends State<BusTicketWidget> {
  Bus bus;
  List list = [];
  List li = [];
  int index = 0;
  List<Slot> _slotList = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await SlotList.list().then((value) {
      setState(() {
        _slotList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              _ticketBody(context),
            ],
          ),
        ),
      ),
    );
  }

  _ticketBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.type.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.electrical_services,
                  size: 18,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.smoking_rooms,
                  size: 18,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.wc,
                  size: 18,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.coffee,
                  size: 18,
                  color: CustomColor.grey,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Rp. ' +
                      currencyFormatter.format(double.parse(widget.bus.price)),
                  style: TextStyle(
                      color: CustomColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.bus.start,
                    style: TextStyle(color: CustomColor.grey, fontSize: 14)),
                Text(widget.pickup_trip_location,
                    style: TextStyle(color: CustomColor.grey, fontSize: 14)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.duration + "J",
                    style: TextStyle(color: CustomColor.grey, fontSize: 10)),
                SizedBox(height: 5),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 30,
                  lineThickness: 1,
                  dashColor: CustomColor.grey,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.bus.end,
                    style: TextStyle(color: CustomColor.grey, fontSize: 14)),
                Text(widget.drop_trip_location,
                    style: TextStyle(color: CustomColor.grey, fontSize: 14)),
              ],
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: CustomColor.darkGrey,
                    borderRadius: BorderRadius.circular(6)),
                child: Icon(
                  Icons.event_seat,
                  color: CustomColor.white,
                  size: 20,
                ),
              ),
              onTap: () {
                _busDetailModal(context);
              },
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  "Pesan",
                  style: TextStyle(color: CustomColor.white, fontSize: 12),
                ),
              ),
              onTap: () {
                _saveBus(context);
                (variable.token == null)
                    ? Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignInScreen()))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PassenggerFormScreen()));
              },
            )
          ],
        ),
      ],
    );
  }

  _busDetailModal(BuildContext context) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 650,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_detailModalBody(context)],
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        });
  }

  _detailModalBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: <Widget>[
          _busInfoWidget(context),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _detailsWidget(context),
                _availableSeatWidget(context),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _busInfoWidget(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          "http://www.juragan99trans.id/images/executive/TK_hino.jpg",
          fit: BoxFit.cover,
          height: 200,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  _detailsWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.bus.type.toString()),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: Dimensions.buttonHeight,
        decoration: BoxDecoration(
            color: CustomColor.red,
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Center(
          child: Text(
            "Tutup",
            style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {},
    );
  }

  _availableSeatWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius)),
      child: Padding(
        padding: const EdgeInsets.only(
          // top: Dimensions.heightSize,
          bottom: Dimensions.heightSize,
        ),
        child: _allTicketWidget(context),
      ),
    );
  }

  _allTicketWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          _slotList.length,
          (index) {
            Slot slot = _slotList[index];
            return slot.isSeat
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: slot.isAvailable
                              ? CustomColor.white
                              : Colors.grey,
                          border: Border.all(color: CustomColor.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  );
          },
        ),
      ),
    );
  }

  void getSlotList() {
    int data = _slotList.length;
    for (int i = 0; i < data; i++) {
      Slot slot = _slotList[i];
      list.add(slot.isAvailable);

      // print('list: ' + list.toString());
    }
  }

  _saveBus(BuildContext context) {
    setState(() {
      variable.trip_id_no = widget.bus.trip_id_no;
      variable.trip_route_id = widget.bus.trip_route_id;
      variable.shedule_id = widget.bus.shedule_id;
      variable.pickup_trip_location = widget.bus.pickup_trip_location;
      variable.drop_trip_location = widget.bus.drop_trip_location;
      variable.type = widget.bus.type;
      variable.fleet_seats = widget.bus.fleet_seats;
      variable.price = widget.bus.price;
      variable.duration = widget.bus.duration;
      variable.start = widget.bus.start;
      variable.end = widget.bus.end;
      variable.seatPicked = widget.bus.seatPicked;
      variable.seatAvail = widget.bus.seatAvail.toString();
    });
  }
}
