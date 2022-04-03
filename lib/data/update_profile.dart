// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpdateProfile {
  static list(
    String email,
    String first_name,
    String last_name,
    String address,
    String phone,
    String identity_number,
    String identity,
  ) async {
    String url = dotenv.env['BASE_URL'] + "/account/profile/update";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "address": address,
      "phone": phone,
      "identity": identity,
      "identity_number": identity_number,
    });

    return jsonDecode(response.body);
  }
}
