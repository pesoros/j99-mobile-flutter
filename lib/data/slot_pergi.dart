// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class SlotPergiList {
  static list() async {
    String url = "https://api-j99.pesoros.com/seatlist";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "trip_id_no": "2",
      "trip_route_id": "11",
      "fleet_registration_id": "1011",
      "fleet_type_id": "1",
      "booking_date": "2022-03-11"
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
