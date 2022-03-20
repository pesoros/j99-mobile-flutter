// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:juragan99/utils/variables.dart' as variable;

class SlotPergiList {
  static list(String trip_id_no, String trip_route_id,
      String fleet_registration_id, String type) async {
    String url = "https://api-j99.pesoros.com/seatlist";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "trip_id_no": trip_id_no,
      "trip_route_id": trip_route_id,
      "fleet_registration_id": fleet_registration_id,
      "fleet_type_id": type,
      "booking_date": variable.datePergi,
    });
    List<SlotPergi> list = [];

    for (var data in jsonDecode(response.body)["seats"] as List) {
      list.add(SlotPergi.fromJson(data));
    }
    return list;
  }
}

class SlotPergi {
  int pergi_id;
  String pergi_name;
  bool pergi_isAvailable;
  bool pergi_isSeat;

  SlotPergi(
      {this.pergi_id,
      this.pergi_name,
      this.pergi_isAvailable,
      this.pergi_isSeat});

  SlotPergi.fromJson(Map<String, dynamic> json) {
    pergi_id = json['id'];
    pergi_name = json['name'];
    pergi_isAvailable = json['isAvailable'];
    pergi_isSeat = json['isSeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.pergi_id;
    data['name'] = this.pergi_name;
    data['isAvailable'] = this.pergi_isAvailable;
    data['isSeat'] = this.pergi_isSeat;

    return data;
  }
}
