import 'package:http/http.dart' as http;
import 'dart:convert';

class SlotList {
  static list() async {
    String url = "http://api-j99.pesoros.com/seatlist";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "trip_id_no": "2",
      "trip_route_id": "11",
      "fleet_registration_id": "1011",
      "fleet_type_id": "1",
      "booking_date": "2022-03-11"
    });
    List<Slot> list = [];
    print(jsonDecode(response.body)["seats"]);

    for (var data in jsonDecode(response.body)["seats"] as List) {
      list.add(Slot.fromJson(data));
    }
    return list;
  }
}

class Slot {
  int id;
  String name;
  bool isAvailable;
  bool isSeat;

  Slot({this.id, this.name, this.isAvailable, this.isSeat});

  Slot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAvailable = json['isAvailable'];
    isSeat = json['isSeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isAvailable'] = this.isAvailable;
    data['isSeat'] = this.isSeat;

    return data;
  }
}
