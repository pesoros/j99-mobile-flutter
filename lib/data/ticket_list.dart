// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:juragan99/utils/variables.dart' as variable;

class TicketList {
  static list() async {
    String url = "https://api-j99.pesoros.com/account/profile/historyticket";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"email": variable.email});

    List<TicketListModal> list = [];

    var resBody = jsonDecode(response.body);

    if (resBody['status'] == 200) {
      for (var data in jsonDecode(response.body)['data'] as List) {
        list.add(TicketListModal.fromJson(data));
      }
      return list;
    } else {}
  }
}

class TicketListModal {
  String booking_code;
  String round_trip;
  String payment_status;
  String total_price;
  String total_seat;
  String created_at;

  TicketListModal({
    this.booking_code,
    this.round_trip,
    this.payment_status,
    this.total_price,
    this.total_seat,
    this.created_at,
  });

  TicketListModal.fromJson(Map<String, dynamic> json) {
    booking_code = json['booking_code'];
    round_trip = json['round_trip'];
    payment_status = json['payment_status'];
    total_price = json['total_price'];
    total_seat = json['total_seat'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_code'] = this.booking_code;
    data['round_trip'] = this.round_trip;
    data['payment_status'] = this.payment_status;
    data['total_price'] = this.total_price;
    data['total_seat'] = this.total_seat;
    data['created_at'] = this.created_at;

    return data;
  }
}
