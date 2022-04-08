// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Ticket {
  static list(String booking_code) async {
    String url = dotenv.env['BASE_URL'] + "/ticket/cek";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {
      "code": booking_code,
    });
    return jsonDecode(response.body);
  }
}

class TicketPassanggerList {
  static list(String code) async {
    String url = dotenv.env['BASE_URL'] + "/ticket/cek";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {
      "code": code,
    });

    List<TicketPassanggerListModal> list = [];

    for (var data in jsonDecode(response.body)['ticket'] as List) {
      list.add(TicketPassanggerListModal.fromJson(data));
    }

    return list;
  }
}

class TicketPassanggerListModal {
  String name;
  String ticket_number;
  String type;
  String seat_number;
  String pickup_trip_location;
  String drop_trip_location;
  String baggage;
  String food_name;

  TicketPassanggerListModal({
    this.name,
    this.ticket_number,
    this.type,
    this.seat_number,
    this.pickup_trip_location,
    this.drop_trip_location,
    this.baggage,
    this.food_name,
  });

  TicketPassanggerListModal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ticket_number = json['ticket_number'];
    type = json['type'];
    seat_number = json['seat_number'];
    pickup_trip_location = json['pickup_trip_location'];
    drop_trip_location = json['drop_trip_location'];
    baggage = json['baggage'];
    food_name = json['food_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ticket_number'] = this.ticket_number;
    data['type'] = this.type;
    data['seat_number'] = this.seat_number;
    data['pickup_trip_location'] = this.pickup_trip_location;
    data['drop_trip_location'] = this.drop_trip_location;
    data['baggage'] = this.baggage;
    data['food_name'] = this.food_name;

    return data;
  }
}
