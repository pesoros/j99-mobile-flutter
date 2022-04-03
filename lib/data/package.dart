// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Package {
  static list(String code) async {
    String url = dotenv.env['BASE_URL'] + "/paket/cek";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {
      "code": code,
    });
    return jsonDecode(response.body);
  }
}

class Trace {
  static list(String code) async {
    String url = dotenv.env['BASE_URL'] + "/paket/cek";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, body: {
      "code": code,
    });
    List<TraceList> list = [];
    for (var data in jsonDecode(response.body)['trace'] as List) {
      list.add(TraceList.fromJson(data));
    }
    return list;
  }
}

class TraceList {
  String description;
  String created_at;

  TraceList({
    this.description,
    this.created_at,
  });

  TraceList.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['description'] = this.description;
    return data;
  }
}
