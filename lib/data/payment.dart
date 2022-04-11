// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentList {
  static list() async {
    String url = dotenv.env['BASE_URL'] + "/datapaymentmethod";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.get(parseUrl);
    print(response.body);
    List<Payment> list = [];
    for (var data in jsonDecode(response.body) as List) {
      list.add(Payment.fromJson(data));
    }
    return list;
  }
}

class Payment {
  String channel_code;
  String channel_category;
  bool is_enabled;

  Payment({this.channel_code, this.channel_category, this.is_enabled});

  Payment.fromJson(Map<String, dynamic> json) {
    channel_code = json['channel_code'];
    channel_category = json['channel_category'];
    is_enabled = json['is_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_code'] = this.channel_code;
    data['channel_category'] = this.channel_category;
    data['is_enabled'] = this.is_enabled;
    return data;
  }
}
