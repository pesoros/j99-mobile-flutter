import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckRegistration {
  static list(String email) async {
    String url = "https://api-j99.pesoros.com/checkregis";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {"email": email});
    return jsonDecode(response.body);
  }
}
