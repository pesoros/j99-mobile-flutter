// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:juragan99/utils/variables.dart' as variable;

class Registration {
  static list(
    String email,
    String password,
    String confpassword,
    String firstName,
    String lastName,
    String address,
    String phone,
    String identity,
    String identityNumber,
  ) async {
    String url = "https://api-j99.pesoros.com/register";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(
      parseUrl,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "email": email,
        "password": password,
        "confpassword": confpassword,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
        "phone": phone,
        "identitiy": identity,
        "identityNumber": identityNumber,
      },
    );
    return jsonDecode(response.body)['messages'];
  }
}

// class RegistrationModal {
//   String channel_code;
//   String channel_category;
//   bool is_enabled;

//   RegistrationModal(
//       {this.channel_code, this.channel_category, this.is_enabled});

//   RegistrationModal.fromJson(Map<String, dynamic> json) {
//     channel_code = json['channel_code'];
//     channel_category = json['channel_category'];
//     is_enabled = json['is_enabled'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['channel_code'] = this.channel_code;
//     data['channel_category'] = this.channel_category;
//     data['is_enabled'] = this.is_enabled;
//     return data;
//   }
// }
