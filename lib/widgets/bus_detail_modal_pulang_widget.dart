// ignore_for_file: unused_element, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:juragan99/data/bus_pulang.dart';
import 'package:juragan99/data/slot_pulang.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BusDetailModalPulangWidget extends StatefulWidget {
  final BusPulang bus;
  final String trip_id_no;
  final String trip_route_id;
  final String shedule_id;
  final String trip_route_name;
  final String pickup_trip_location;
  final String drop_trip_location;
  final String type;
  final String type_class;
  final String fleet_seats;
  final String fleet_registration_id;
  final String price;
  final String duration;
  final String start;
  final String end;
  final String seatPicked;
  final int seatAvail;

  BusDetailModalPulangWidget({
    this.bus,
    this.trip_id_no,
    this.trip_route_id,
    this.shedule_id,
    this.trip_route_name,
    this.pickup_trip_location,
    this.drop_trip_location,
    this.type,
    this.type_class,
    this.fleet_seats,
    this.fleet_registration_id,
    this.price,
    this.duration,
    this.start,
    this.end,
    this.seatPicked,
    this.seatAvail,
  });

  @override
  _BusDetailModalPulangWidgetState createState() =>
      _BusDetailModalPulangWidgetState();
}

class _BusDetailModalPulangWidgetState
    extends State<BusDetailModalPulangWidget> {
  BusPulang bus;
  List list = [];
  int index = 0;
  List<SlotPulang> _slotList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getSlot();
  }

  getSlot() async {
    await SlotPulangList.list(
      widget.bus.pulang_trip_id_no,
      widget.bus.pulang_trip_route_id,
      widget.bus.pulang_fleet_registration_id,
      widget.bus.pulang_type,
    ).then((value) {
      setState(() {
        _slotList = value;
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [_detailModalBody(context)],
                  ),
                )
              : Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                )
        ],
      ),
    );
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
        child: CachedNetworkImage(
          imageUrl: "http://www.juragan99trans.id/images/executive/TK_hino.jpg",
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: 200,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  _detailsWidget(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.type_class,
              style: TextStyle(fontSize: Dimensions.defaultTextSize)),
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
          SizedBox(height: 10),
          Row(
            children: [
              Text("Harga",
                  style: TextStyle(fontSize: Dimensions.defaultTextSize))
            ],
          ),
          Row(
            children: [
              Text(
                rupiah(widget.price),
                style: TextStyle(
                    color: CustomColor.red,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.defaultTextSize),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("Sisa Kursi",
                  style: TextStyle(fontSize: Dimensions.defaultTextSize))
            ],
          ),
          Row(
            children: [
              Text(
                widget.seatAvail.toString() + " Kursi",
                style: TextStyle(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.defaultTextSize),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(widget.start,
                  style: TextStyle(fontSize: Dimensions.defaultTextSize))
            ],
          ),
          Row(
            children: [
              Text(
                widget.pickup_trip_location,
                style: TextStyle(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.defaultTextSize),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(widget.end,
                  style: TextStyle(fontSize: Dimensions.defaultTextSize))
            ],
          ),
          Row(
            children: [
              Text(
                widget.drop_trip_location,
                style: TextStyle(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.defaultTextSize),
              ),
            ],
          )
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
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  _availableSeatWidget(BuildContext context) {
    return Container(
      child: _allTicketWidget(context),
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
            SlotPulang slot = _slotList[index];
            return slot.pulang_isSeat
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: slot.pulang_isAvailable
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
}
