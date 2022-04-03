// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Profile {
  static list(String email) async {
    String url = dotenv.env['BASE_URL'] + "/account/profile";

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
