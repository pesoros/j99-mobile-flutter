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
        "identity": identity,
        "identityNumber": identityNumber,
      },
    );
    return jsonDecode(response.body)['messages'];
  }
}
