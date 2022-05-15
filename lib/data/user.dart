import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserList {
  static list(String email, String password) async {
    String url = dotenv.env['BASE_URL'] + "/login";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    final list = User.fromJson(data);
    return list;
  }
}

class User {
  String token;
  String email;
  String firstName;
  String lastName;
  String address;
  String phone;

  User({
    this.token,
    this.email,
    this.firstName,
    this.lastName,
    this.address,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String;
    final email = json['email'] as String;
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final address = json['address'] as String;
    final phone = json['phone'] as String;

    return User(
      token: token,
      email: email,
      firstName: firstName,
      lastName: lastName,
      address: address,
      phone: phone,
    );
  }
}
