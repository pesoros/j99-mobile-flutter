import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SetOtp {
  static list(String email, String phone) async {
    String url = dotenv.env['BASE_URL'] + "/otp/set";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(
      parseUrl,
      body: (variable.isEmail)
          ? {"sendBy": "email", "email": email}
          : {"sendBy": "wa", "phone": phone},
    );
    return jsonDecode(response.body);
  }
}

class CheckOtp {
  static list(String otpCode, String email, String phone) async {
    String url = dotenv.env['BASE_URL'] + "/otp/check";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(
      parseUrl,
      body: (variable.isEmail)
          ? {"otp": otpCode, "email": email}
          : {"otp": otpCode, "phone": phone},
    );
    return jsonDecode(response.body);
  }
}
