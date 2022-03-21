// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:dotted_line/dotted_line.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/bus_pulang.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/formater.dart';
import 'package:shimmer/shimmer.dart';

import 'package:juragan99/utils/variables.dart' as variable;

import 'package:juragan99/screens/passengger_form_screen.dart';
import 'package:juragan99/widgets/bus_detail_modal_pulang_widget.dart';

class BusTicketPulangWidget extends StatefulWidget {
  final BusPulang bus;
  final String trip_id_no;
  final String trip_route_id;
  final String shedule_id;
  final String trip_route_name;
  final String pickup_trip_location;
  final String drop_trip_location;
  final String type;
  final String fleet_seats;
  final String fleet_registration_id;
  final String price;
  final String duration;
  final String start;
  final String end;
  final String seatPicked;
  final int seatAvail;

  final String selectedJumlahPenumpang;
  final bool checkPulangPergi;

  BusTicketPulangWidget({
    this.bus,
    this.trip_id_no,
    this.trip_route_id,
    this.shedule_id,
    this.trip_route_name,
    this.pickup_trip_location,
    this.drop_trip_location,
    this.type,
    this.fleet_seats,
    this.fleet_registration_id,
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
  _BusTicketPulangWidgetState createState() => _BusTicketPulangWidgetState();
}

class _BusTicketPulangWidgetState extends State<BusTicketPulangWidget> {
  BusPulang bus;
  List<ClassList> _classList = [];

  @override
  void initState() {
    super.initState();
    getClass();
  }

  getClass() async {
    await GetClassList.list(
      widget.type,
    ).then((value) {
      setState(() {
        _classList = value;
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
            (_classList.length == 0)
                ? Shimmer.fromColors(
                    child: Text("Kelas Bus"),
                    baseColor: CustomColor.white,
                    highlightColor: CustomColor.red)
                : Text(
                    _classList[0].kelas,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.defaultTextSize),
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
                  size: Dimensions.defaultTextSize,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.smoking_rooms,
                  size: Dimensions.defaultTextSize,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.wc,
                  size: Dimensions.defaultTextSize,
                  color: CustomColor.grey,
                ),
                Icon(
                  Icons.coffee,
                  size: Dimensions.defaultTextSize,
                  color: CustomColor.grey,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Rp. ' +
                      currencyFormatter
                          .format(double.parse(widget.bus.pulang_price)),
                  style: TextStyle(
                      color: CustomColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
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
                Text(widget.bus.pulang_start,
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.extraSmallTextSize)),
                Text(widget.pickup_trip_location,
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.extraSmallTextSize)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.duration,
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.extraSmallTextSize)),
                SizedBox(height: 5),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 20,
                  lineThickness: 1,
                  dashColor: CustomColor.grey,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.bus.pulang_end,
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.extraSmallTextSize)),
                Text(widget.drop_trip_location,
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: Dimensions.extraSmallTextSize)),
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
                child: Icon(Icons.event_seat,
                    color: CustomColor.white, size: Dimensions.defaultTextSize),
              ),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 300),
                      opaque: false,
                      pageBuilder: (_, __, ___) => BusDetailModalPulangWidget(
                            bus: widget.bus,
                            type: widget.bus.pulang_type,
                            price: widget.bus.pulang_price,
                            start: widget.bus.pulang_start,
                            end: widget.bus.pulang_end,
                            pickup_trip_location:
                                widget.bus.pulang_pickup_trip_location,
                            drop_trip_location:
                                widget.bus.pulang_drop_trip_location,
                            seatAvail: widget.bus.pulang_seatAvail,
                            fleet_registration_id:
                                widget.bus.pulang_fleet_registration_id,
                            trip_id_no: widget.bus.pulang_trip_id_no,
                            trip_route_id: widget.bus.pulang_trip_route_id,
                          ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        final tween = Tween(begin: begin, end: end);
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      }),
                );
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
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: Dimensions.smallTextSize),
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

  _saveBus(BuildContext context) {
    setState(() {
      variable.pulang_trip_id_no = widget.bus.pulang_trip_id_no;
      variable.pulang_trip_route_id = widget.bus.pulang_trip_route_id;
      variable.pulang_shedule_id = widget.bus.pulang_shedule_id;
      variable.pulang_pickup_trip_location =
          widget.bus.pulang_pickup_trip_location;
      variable.pulang_drop_trip_location = widget.bus.pulang_drop_trip_location;
      variable.pulang_type = widget.bus.pulang_type;
      variable.pulang_fleet_seats = widget.bus.pulang_fleet_seats;
      variable.pulang_fleet_registration_id =
          widget.bus.pulang_fleet_registration_id;
      variable.pulang_price = widget.bus.pulang_price;
      variable.pulang_duration = widget.bus.pulang_duration;
      variable.pulang_start = widget.bus.pulang_start;
      variable.pulang_end = widget.bus.pulang_end;
      variable.pulang_seatPicked = widget.bus.pulang_seatPicked;
      variable.pulang_seatAvail = widget.bus.pulang_seatAvail.toString();
    });
  }
}
