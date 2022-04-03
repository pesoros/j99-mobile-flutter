import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Pariwisata {
  static list(
    String nama,
    String handphone,
    String email,
    String busType,
    String description,
  ) async {
    String url = dotenv.env['BASE_URL'] + "/contact/pariwisata";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "name": nama,
      "handphone": handphone,
      "email": email,
      "busType": busType,
      "description": description,
    });

    return jsonDecode(response.body);
  }
}
