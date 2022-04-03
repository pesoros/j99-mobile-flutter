import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CheckRegistration {
  static list(String email) async {
    String url = dotenv.env['BASE_URL'] + "/checkregis";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {"email": email});
    return jsonDecode(response.body);
  }
}
