// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:juragan99/utils/variables.dart' as variable;

class BusPulangList {
  static list() async {
    String url = "https://api-j99.pesoros.com/listbus";

    Uri parse_url = Uri.parse(
      url,
    );
    final response = await http.post(parse_url, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "berangkat": variable.selectedToCity.toString(),
      "tujuan": variable.selectedFromCity.toString(),
      "tanggal": variable.datePulang,
      "kelas": variable.selectedKelasArmada,
    });
    List<BusPulang> list = [];
    for (var data in jsonDecode(response.body) as List) {
      list.add(BusPulang.fromJson(data));
    }
    return list;
  }
}

class BusPulang {
  String pulang_trip_id_no;
  String pulang_trip_route_id;
  String pulang_shedule_id;
  String pulang_pickup_trip_location;
  String pulang_drop_trip_location;
  String pulang_type;
  String pulang_fleet_seats;
  String pulang_fleet_registration_id;
  String pulang_price;
  String pulang_duration;
  String pulang_start;
  String pulang_end;
  String pulang_seatPicked;
  int pulang_seatAvail;

  BusPulang(
      {this.pulang_trip_id_no,
      this.pulang_trip_route_id,
      this.pulang_shedule_id,
      this.pulang_pickup_trip_location,
      this.pulang_drop_trip_location,
      this.pulang_type,
      this.pulang_fleet_seats,
      this.pulang_fleet_registration_id,
      this.pulang_price,
      this.pulang_duration,
      this.pulang_start,
      this.pulang_end,
      this.pulang_seatPicked,
      this.pulang_seatAvail});

  BusPulang.fromJson(Map<String, dynamic> json) {
    pulang_trip_id_no = json['trip_id_no'];
    pulang_trip_route_id = json['trip_route_id'];
    pulang_shedule_id = json['shedule_id'];
    pulang_pickup_trip_location = json['pickup_trip_location'];
    pulang_drop_trip_location = json['drop_trip_location'];
    pulang_type = json['type'];
    pulang_fleet_seats = json['fleet_seats'];
    pulang_fleet_registration_id = json['fleet_registration_id'];
    pulang_price = json['price'];
    pulang_duration = json['duration'];
    pulang_start = json['start'];
    pulang_end = json['end'];
    pulang_seatPicked = json['seatPicked'];
    pulang_seatAvail = json['seatAvail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id_no'] = this.pulang_trip_id_no;
    data['trip_route_id'] = this.pulang_trip_route_id;
    data['shedule_id'] = this.pulang_shedule_id;
    data['pickup_trip_location'] = this.pulang_pickup_trip_location;
    data['drop_trip_location'] = this.pulang_drop_trip_location;
    data['type'] = this.pulang_type;
    data['fleet_seats'] = this.pulang_fleet_seats;
    data['fleet_registration_id'] = this.pulang_fleet_registration_id;
    data['price'] = this.pulang_price;
    data['duration'] = this.pulang_duration;
    data['start'] = this.pulang_start;
    data['end'] = this.pulang_end;
    data['seatPicked'] = this.pulang_seatPicked;
    data['seatAvail'] = this.pulang_seatAvail;
    data['seatAvail'] = this.pulang_seatAvail;
    return data;
  }
}
