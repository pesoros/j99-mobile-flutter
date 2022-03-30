// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile {
  static list(String email) async {
    String url = "https://api-j99.pesoros.com/account/profile";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
    });

    final data = jsonDecode(response.body);

    return data;
  }
}
