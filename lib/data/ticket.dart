// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class Ticket {
  static list(String booking_code) async {
    String url = "https://api-j99.pesoros.com/ticket/cek";

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
    String url = "https://api-j99.pesoros.com/ticket/cek";

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
  String description;
  String created_at;

  TicketPassanggerListModal({
    this.description,
    this.created_at,
  });

  TicketPassanggerListModal.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['description'] = this.description;
    return data;
  }
}
