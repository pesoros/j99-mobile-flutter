// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class SlotPulangList {
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
    List<SlotPulang> list = [];

    for (var data in jsonDecode(response.body)["seats"] as List) {
      list.add(SlotPulang.fromJson(data));
    }
    return list;
  }
}

class SlotPulang {
  int pulang_id;
  String pulang_name;
  bool pulang_isAvailable;
  bool pulang_isSeat;

  SlotPulang(
      {this.pulang_id,
      this.pulang_name,
      this.pulang_isAvailable,
      this.pulang_isSeat});

  SlotPulang.fromJson(Map<String, dynamic> json) {
    pulang_id = json['id'];
    pulang_name = json['name'];
    pulang_isAvailable = json['isAvailable'];
    pulang_isSeat = json['isSeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.pulang_id;
    data['name'] = this.pulang_name;
    data['isAvailable'] = this.pulang_isAvailable;
    data['isSeat'] = this.pulang_isSeat;

    return data;
  }
}
