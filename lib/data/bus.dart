// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:juragan99/utils/variables.dart' as variable;

class BusList {
  static list() async {
    String url = "http://api-j99.pesoros.com/listbus";

    Uri parse_url = Uri.parse(
      url,
    );
    final response = await http.post(parse_url, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "berangkat": variable.selectedFromCity.toString(),
      "tujuan": variable.selectedToCity.toString(),
      "tanggal": variable.datePergi,
      "kelas": variable.selectedKelasArmada,
    });
    List<Bus> list = [];
    for (var data in jsonDecode(response.body) as List) {
      list.add(Bus.fromJson(data));
    }
    return list;
  }
}

class Bus {
  String trip_id_no;
  String trip_route_id;
  String shedule_id;
  String pickup_trip_location;
  String drop_trip_location;
  String type;
  String fleet_seats;
  String price;
  String duration;
  String start;
  String end;
  String seatPicked;
  int seatAvail;

  Bus(
      {this.trip_id_no,
      this.trip_route_id,
      this.shedule_id,
      this.pickup_trip_location,
      this.drop_trip_location,
      this.type,
      this.fleet_seats,
      this.price,
      this.duration,
      this.start,
      this.end,
      this.seatPicked,
      this.seatAvail});

  Bus.fromJson(Map<String, dynamic> json) {
    trip_id_no = json['trip_id_no'];
    trip_route_id = json['trip_route_id'];
    shedule_id = json['shedule_id'];
    pickup_trip_location = json['pickup_trip_location'];
    drop_trip_location = json['drop_trip_location'];
    type = json['type'];
    fleet_seats = json['fleet_seats'];
    price = json['price'];
    duration = json['duration'];
    start = json['start'];
    end = json['end'];
    seatPicked = json['seatPicked'];
    seatAvail = json['seatAvail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id_no'] = this.trip_id_no;
    data['trip_route_id'] = this.trip_route_id;
    data['shedule_id'] = this.shedule_id;
    data['pickup_trip_location'] = this.pickup_trip_location;
    data['drop_trip_location'] = this.drop_trip_location;
    data['type'] = this.type;
    data['fleet_seats'] = this.fleet_seats;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['start'] = this.start;
    data['end'] = this.end;
    data['seatPicked'] = this.seatPicked;
    data['seatAvail'] = this.seatAvail;
    data['seatAvail'] = this.seatAvail;
    return data;
  }
}
