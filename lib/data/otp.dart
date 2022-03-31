import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:juragan99/utils/variables.dart' as variable;

class SetOtp {
  static list(String email, String phone) async {
    String url = "https://api-j99.pesoros.com/otp/set";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(
      parseUrl,
      body: (variable.isEmail)
          ? {"sendBy": "email", "email": email}
          : {"sendBy": "wa", "phone": phone},
    );
    print(response.body);
    return jsonDecode(response.body);
  }
}

class CheckOtp {
  static list(String otpCode, String email, String phone) async {
    String url = "https://api-j99.pesoros.com/otp/check";

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
