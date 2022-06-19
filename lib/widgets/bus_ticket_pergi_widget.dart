// ignore_for_file: unused_element, non_constant_identifier_names, unused_field, unrelated_type_equality_checks

import 'package:dotted_line/dotted_line.dart';
import 'package:indonesia/indonesia.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/screens/auth/sign_in_screen.dart';
import 'package:juragan99/screens/search_result_pulang_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/utils/variables.dart' as variable;

import 'package:juragan99/screens/passengger_form_screen.dart';
import 'package:juragan99/widgets/bus_detail_modal_pergi_widget.dart';

class BusTicketPergiWidget extends StatefulWidget {
  final BusPergi bus;
  final String trip_id_no;
  final String trip_route_id;
  final String shedule_id;
  final String trip_route_name;
  final String pickup_trip_location;
  final String drop_trip_location;
  final String type;
  final String type_class;
  final String image;
  final String fleet_seats;
  final String fleet_registration_id;
  final String price;
  final String duration;
  final String start;
  final String end;
  final String seatPicked;
  final int seatAvail;
  final String resto_id;

  BusTicketPergiWidget({
    this.bus,
    this.trip_id_no,
    this.trip_route_id,
    this.shedule_id,
    this.trip_route_name,
    this.pickup_trip_location,
    this.drop_trip_location,
    this.type,
    this.type_class,
    this.image,
    this.fleet_seats,
    this.fleet_registration_id,
    this.price,
    this.duration,
    this.start,
    this.end,
    this.seatPicked,
    this.seatAvail,
    this.resto_id,
  });

  @override
  _BusTicketPergiWidgetState createState() => _BusTicketPergiWidgetState();
}

class _BusTicketPergiWidgetState extends State<BusTicketPergiWidget> {
  BusPergi bus;
  List<ClassList> _classList = [];

  @override
  void initState() {
    super.initState();
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
              widget.bus.pergi_type_class,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.defaultTextSize),
            ),
            Row(
              children: [
                Text(
                  "Sisa Kursi: ",
                  style: TextStyle(
                      color: CustomColor.darkGrey,
                      fontSize: Dimensions.smallTextSize),
                ),
                Text(
                  widget.bus.pergi_seatAvail.toString(),
                  style: TextStyle(
                      color: CustomColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.smallTextSize),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.bus.pergi_start + ": ",
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.defaultTextSize)),
            Text(widget.pickup_trip_location,
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.defaultTextSize)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.duration,
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.smallTextSize)),
            SizedBox(width: 10),
            DottedLine(
              direction: Axis.vertical,
              lineLength: 20,
              lineThickness: 1,
              dashColor: CustomColor.grey,
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(widget.bus.pergi_end + ": ",
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.defaultTextSize)),
            Text(widget.drop_trip_location,
                style: TextStyle(
                    color: CustomColor.grey,
                    fontSize: Dimensions.defaultTextSize)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  rupiah(widget.bus.pergi_price),
                  style: TextStyle(
                      color: CustomColor.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
            Row(
              children: [
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
                      size: Dimensions.defaultTextSize,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 300),
                          opaque: false,
                          pageBuilder: (_, __, ___) =>
                              BusDetailModalPergiWidget(
                                bus: widget.bus,
                                type: widget.bus.pergi_type,
                                type_class: widget.bus.pergi_type_class,
                                image: widget.bus.pergi_image,
                                price: widget.bus.pergi_price,
                                start: widget.bus.pergi_start,
                                end: widget.bus.pergi_end,
                                pickup_trip_location:
                                    widget.bus.pergi_pickup_trip_location,
                                drop_trip_location:
                                    widget.bus.pergi_drop_trip_location,
                                seatAvail: widget.bus.pergi_seatAvail,
                                fleet_registration_id:
                                    widget.bus.pergi_fleet_registration_id,
                                trip_id_no: widget.bus.pergi_trip_id_no,
                                trip_route_id: widget.bus.pergi_trip_route_id,
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
                SizedBox(width: 10),
                (widget.bus.pergi_seatAvail == 0)
                    ? Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: CustomColor.grey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          "Pesan",
                          style: TextStyle(
                              color: CustomColor.white,
                              fontSize: Dimensions.smallTextSize),
                        ),
                      )
                    : GestureDetector(
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
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignInScreen()))
                              : (variable.checkPulangPergi == true)
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchResultPulangScreen()))
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PassenggerFormScreen()));
                        },
                      )
              ],
            )
          ],
        )
      ],
    );
  }

  _saveBus(BuildContext context) {
    setState(() {
      variable.pergi_trip_id_no = widget.bus.pergi_trip_id_no;
      variable.pergi_trip_route_id = widget.bus.pergi_trip_route_id;
      variable.pergi_shedule_id = widget.bus.pergi_shedule_id;
      variable.pergi_pickup_trip_location =
          widget.bus.pergi_pickup_trip_location;
      variable.pergi_drop_trip_location = widget.bus.pergi_drop_trip_location;
      variable.pergi_type = widget.bus.pergi_type;
      variable.pergi_type_class = widget.bus.pergi_type_class;
      variable.pergi_fleet_seats = widget.bus.pergi_fleet_seats;
      variable.pergi_fleet_registration_id =
          widget.bus.pergi_fleet_registration_id;
      variable.pergi_price = widget.bus.pergi_price;
      variable.pergi_duration = widget.bus.pergi_duration;
      variable.pergi_start = widget.bus.pergi_start;
      variable.pergi_end = widget.bus.pergi_end;
      variable.pergi_seatPicked = widget.bus.pergi_seatPicked;
      variable.pergi_seatAvail = widget.bus.pergi_seatAvail.toString();
      variable.pergi_resto_id = widget.bus.pergi_resto_id;
    });
  }
}
