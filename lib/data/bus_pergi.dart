// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:juragan99/utils/variables.dart' as variable;

class BusPergiList {
  static list() async {
    String url = "https://api-j99.pesoros.com/listbus";

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
    List<BusPergi> list = [];
    for (var data in jsonDecode(response.body) as List) {
      list.add(BusPergi.fromJson(data));
    }
    return list;
  }
}

class BusPergi {
  String pergi_trip_id_no;
  String pergi_trip_route_id;
  String pergi_shedule_id;
  String pergi_pickup_trip_location;
  String pergi_drop_trip_location;
  String pergi_type;
  String pergi_fleet_seats;
  String pergi_fleet_registration_id;
  String pergi_price;
  String pergi_duration;
  String pergi_start;
  String pergi_end;
  String pergi_seatPicked;
  int pergi_seatAvail;

  BusPergi(
      {this.pergi_trip_id_no,
      this.pergi_trip_route_id,
      this.pergi_shedule_id,
      this.pergi_pickup_trip_location,
      this.pergi_drop_trip_location,
      this.pergi_type,
      this.pergi_fleet_seats,
      this.pergi_fleet_registration_id,
      this.pergi_price,
      this.pergi_duration,
      this.pergi_start,
      this.pergi_end,
      this.pergi_seatPicked,
      this.pergi_seatAvail});

  BusPergi.fromJson(Map<String, dynamic> json) {
    pergi_trip_id_no = json['trip_id_no'];
    pergi_trip_route_id = json['trip_route_id'];
    pergi_shedule_id = json['shedule_id'];
    pergi_pickup_trip_location = json['pickup_trip_location'];
    pergi_drop_trip_location = json['drop_trip_location'];
    pergi_type = json['type'];
    pergi_fleet_seats = json['fleet_seats'];
    pergi_fleet_registration_id = json['fleet_registration_id'];
    pergi_price = json['price'];
    pergi_duration = json['duration'];
    pergi_start = json['start'];
    pergi_end = json['end'];
    pergi_seatPicked = json['seatPicked'];
    pergi_seatAvail = json['seatAvail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id_no'] = this.pergi_trip_id_no;
    data['trip_route_id'] = this.pergi_trip_route_id;
    data['shedule_id'] = this.pergi_shedule_id;
    data['pickup_trip_location'] = this.pergi_pickup_trip_location;
    data['drop_trip_location'] = this.pergi_drop_trip_location;
    data['type'] = this.pergi_type;
    data['fleet_seats'] = this.pergi_fleet_seats;
    data['fleet_registration_id'] = this.pergi_fleet_registration_id;
    data['price'] = this.pergi_price;
    data['duration'] = this.pergi_duration;
    data['start'] = this.pergi_start;
    data['end'] = this.pergi_end;
    data['seatPicked'] = this.pergi_seatPicked;
    data['seatAvail'] = this.pergi_seatAvail;
    data['seatAvail'] = this.pergi_seatAvail;
    return data;
  }
}
