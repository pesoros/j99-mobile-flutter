// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChangePassword {
  static list(
    String email,
    String newPassword,
    String confNewPassword,
  ) async {
    String url = dotenv.env['BASE_URL'] + "/account/password/change";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
      "newPassword": newPassword,
      "confNewPassword": confNewPassword,
    });

    return jsonDecode(response.body);
  }
}
