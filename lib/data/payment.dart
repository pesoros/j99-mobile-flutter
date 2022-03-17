// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentList {
  static list() async {
    String url = "https://api-j99.pesoros.com/datapaymentmethod";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.get(parseUrl);
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

// class Payment {
//   final int id;
//   final String name;
//   final bool isAvailable;

//   const Payment({this.id, this.name, this.isAvailable});
// }

// class PaymentList {
//   static List<Payment> list() {
//     const data = <Payment>[
//       Payment(id: 1, name: 'BCA', isAvailable: true),
//       Payment(id: 2, name: 'BRI', isAvailable: true),
//       Payment(id: 3, name: 'Mandiri', isAvailable: true),
//     ];
//     return data;
//   }
// }
