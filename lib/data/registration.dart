// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Registration {
  static list(
    String email,
    String password,
    String confpassword,
    String firstName,
    String lastName,
    String phone,
  ) async {
    String url = dotenv.env['BASE_URL'] + "/register";

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
        "address": "",
        "phone": phone,
        "identity": "",
        "identityNumber": "",
      },
    );
    return jsonDecode(response.body)['messages'];
  }
}
