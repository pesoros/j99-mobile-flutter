import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:juragan99/utils/variables.dart' as variable;

class BookingList {
  static list() async {
    print(variable.trip_id_no);
    print(variable.trip_route_id);
    print(variable.pickup_trip_location);
    print(variable.drop_trip_location);
    print(variable.totalPrice);
    print(variable.datePergi);
    print(variable.type);
    print(variable.kodePromo);
    print(variable.selectedPaymentCategories);
    print(variable.selectedPayment);
    print(variable.namePassengger1);
    print(variable.seatPergiPassengger1);
    print(variable.foodIdPassengger1);
    print(variable.baggagePassengger1);
    print(variable.nikTypePassengger1);
    print(variable.nikPassengger1);
    print(variable.phonePassengger1);

    String url = "http://api-j99.pesoros.com/booking/add";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "trip_id_no": variable.trip_id_no,
      "trip_route_id": variable.trip_route_id,
      "pickup_location": variable.pickup_trip_location,
      "drop_location": variable.drop_trip_location,
      "pricePerSeat": variable.totalPrice,
      "booking_date": variable.datePergi,
      "fleet_type_id": variable.type,
      "offer_code": variable.kodePromo,
      "payment_method": variable.selectedPaymentCategories,
      "payment_channel_code": variable.selectedPayment,
      "seatPicked[0][name]": variable.namePassengger1,
      "seatPicked[0][seat]": variable.seatPergiPassengger1,
      "seatPicked[0][food]": variable.foodIdPassengger1,
      "seatPicked[0][baggage]": variable.baggagePassengger1,
      "seatPicked[0][identity]": variable.nikTypePassengger1,
      "seatPicked[0][identity_number]": variable.nikPassengger1,
      "seatPicked[0][phone]": variable.phonePassengger1,
    });
    if (jsonDecode(response.body)['status'] == true) {
      var payment = jsonDecode(response.body)['payment'];
      print(payment);
      variable.status = payment['status'];
      variable.bank_code = payment['bank_code'];
      variable.merchant_code = payment['merchant_code'];
      variable.name = payment['name'];
      variable.account_number = payment['account_number'];
      variable.expiration_date = payment['expiration_date'];
      variable.payment_id = payment['id'];
    } else {
      print("Error");
    }
  }
}

// class Booking {
//   String token;
//   String email;
//   String firstName;
//   String lastName;
//   String address;
//   String phone;

//   Booking({
//     this.token,
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.address,
//     this.phone,
//   });

//   factory Booking.fromJson(Map<String, dynamic> json) {
//     final token = json['token'] as String;
//     final email = json['email'] as String;
//     final firstName = json['firstName'] as String;
//     final lastName = json['lastName'] as String;
//     final address = json['address'] as String;
//     final phone = json['phone'] as String;

//     return Booking(
//       token: token,
//       email: email,
//       firstName: firstName,
//       lastName: lastName,
//       address: address,
//       phone: phone,
//     );
//   }
// }
