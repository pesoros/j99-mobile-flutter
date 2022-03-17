// ignore_for_file: non_constant_identifier_names, unused_import, unused_element, unused_local_variable

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:juragan99/utils/variables.dart' as variable;

class BookingList {
  static list() async {
    String url = "https://api-j99.pesoros.com/booking/add";

    Uri parseUrl = Uri.parse(url);

    final response = await http.post(
      parseUrl,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: (variable.checkPulangPergi == false &&
              int.parse(variable.selectedJumlahPenumpang) == 1)
          ? {
              "trip_id_no": variable.pergi_trip_id_no,
              "trip_route_id": variable.pergi_trip_route_id,
              "pickup_location": variable.pergi_pickup_trip_location,
              "drop_location": variable.pergi_drop_trip_location,
              "pricePerSeat": variable.totalPrice,
              "booking_date": variable.datePergi,
              "fleet_type_id": variable.pergi_type,
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
            }
          : (variable.checkPulangPergi == true &&
                  int.parse(variable.selectedJumlahPenumpang) == 1)
              ? {
                  "trip_id_no": variable.pergi_trip_id_no,
                  "trip_route_id": variable.pergi_trip_route_id,
                  "pickup_location": variable.pergi_pickup_trip_location,
                  "drop_location": variable.pergi_drop_trip_location,
                  "pricePerSeat": variable.totalPrice,
                  "booking_date": variable.datePergi,
                  "fleet_type_id": variable.pergi_type,
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
                }
              : (variable.checkPulangPergi == false &&
                      int.parse(variable.selectedJumlahPenumpang) == 2)
                  ? {
                      "trip_id_no": variable.pergi_trip_id_no,
                      "trip_route_id": variable.pergi_trip_route_id,
                      "pickup_location": variable.pergi_pickup_trip_location,
                      "drop_location": variable.pergi_drop_trip_location,
                      "pricePerSeat": variable.totalPrice,
                      "booking_date": variable.datePergi,
                      "fleet_type_id": variable.pergi_type,
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
                      "seatPicked[1][name]": variable.namePassengger2,
                      "seatPicked[1][seat]": variable.seatPergiPassengger2,
                      "seatPicked[1][food]": variable.foodIdPassengger2,
                      "seatPicked[1][baggage]": variable.baggagePassengger2,
                      "seatPicked[1][identity]": variable.nikTypePassengger2,
                      "seatPicked[1][identity_number]": variable.nikPassengger2,
                      "seatPicked[1][phone]": variable.phonePassengger2,
                    }
                  : (variable.checkPulangPergi == true &&
                          int.parse(variable.selectedJumlahPenumpang) == 2)
                      ? {
                          "trip_id_no": variable.pergi_trip_id_no,
                          "trip_route_id": variable.pergi_trip_route_id,
                          "pickup_location":
                              variable.pergi_pickup_trip_location,
                          "drop_location": variable.pergi_drop_trip_location,
                          "pricePerSeat": variable.totalPrice,
                          "booking_date": variable.datePergi,
                          "fleet_type_id": variable.pergi_type,
                          "offer_code": variable.kodePromo,
                          "payment_method": variable.selectedPaymentCategories,
                          "payment_channel_code": variable.selectedPayment,
                          "seatPicked[0][name]": variable.namePassengger1,
                          "seatPicked[0][seat]": variable.seatPergiPassengger1,
                          "seatPicked[0][food]": variable.foodIdPassengger1,
                          "seatPicked[0][baggage]": variable.baggagePassengger1,
                          "seatPicked[0][identity]":
                              variable.nikTypePassengger1,
                          "seatPicked[0][identity_number]":
                              variable.nikPassengger1,
                          "seatPicked[0][phone]": variable.phonePassengger1,
                          "seatPicked[1][name]": variable.namePassengger2,
                          "seatPicked[1][seat]": variable.seatPergiPassengger2,
                          "seatPicked[1][food]": variable.foodIdPassengger2,
                          "seatPicked[1][baggage]": variable.baggagePassengger2,
                          "seatPicked[1][identity]":
                              variable.nikTypePassengger2,
                          "seatPicked[1][identity_number]":
                              variable.nikPassengger2,
                          "seatPicked[1][phone]": variable.phonePassengger2,
                        }
                      : (variable.checkPulangPergi == false &&
                              int.parse(variable.selectedJumlahPenumpang) == 3)
                          ? {
                              "trip_id_no": variable.pergi_trip_id_no,
                              "trip_route_id": variable.pergi_trip_route_id,
                              "pickup_location":
                                  variable.pergi_pickup_trip_location,
                              "drop_location":
                                  variable.pergi_drop_trip_location,
                              "pricePerSeat": variable.totalPrice,
                              "booking_date": variable.datePergi,
                              "fleet_type_id": variable.pergi_type,
                              "offer_code": variable.kodePromo,
                              "payment_method":
                                  variable.selectedPaymentCategories,
                              "payment_channel_code": variable.selectedPayment,
                              "seatPicked[0][name]": variable.namePassengger1,
                              "seatPicked[0][seat]":
                                  variable.seatPergiPassengger1,
                              "seatPicked[0][food]": variable.foodIdPassengger1,
                              "seatPicked[0][baggage]":
                                  variable.baggagePassengger1,
                              "seatPicked[0][identity]":
                                  variable.nikTypePassengger1,
                              "seatPicked[0][identity_number]":
                                  variable.nikPassengger1,
                              "seatPicked[0][phone]": variable.phonePassengger1,
                              "seatPicked[1][name]": variable.namePassengger2,
                              "seatPicked[1][seat]":
                                  variable.seatPergiPassengger2,
                              "seatPicked[1][food]": variable.foodIdPassengger2,
                              "seatPicked[1][baggage]":
                                  variable.baggagePassengger2,
                              "seatPicked[1][identity]":
                                  variable.nikTypePassengger2,
                              "seatPicked[1][identity_number]":
                                  variable.nikPassengger2,
                              "seatPicked[1][phone]": variable.phonePassengger2,
                              "seatPicked[2][name]": variable.namePassengger3,
                              "seatPicked[2][seat]":
                                  variable.seatPergiPassengger3,
                              "seatPicked[2][food]": variable.foodIdPassengger3,
                              "seatPicked[2][baggage]":
                                  variable.baggagePassengger3,
                              "seatPicked[2][identity]":
                                  variable.nikTypePassengger3,
                              "seatPicked[2][identity_number]":
                                  variable.nikPassengger3,
                              "seatPicked[2][phone]": variable.phonePassengger3,
                            }
                          : (variable.checkPulangPergi == true &&
                                  int.parse(variable.selectedJumlahPenumpang) ==
                                      3)
                              ? {
                                  "trip_id_no": variable.pergi_trip_id_no,
                                  "trip_route_id": variable.pergi_trip_route_id,
                                  "pickup_location":
                                      variable.pergi_pickup_trip_location,
                                  "drop_location":
                                      variable.pergi_drop_trip_location,
                                  "pricePerSeat": variable.totalPrice,
                                  "booking_date": variable.datePergi,
                                  "fleet_type_id": variable.pergi_type,
                                  "offer_code": variable.kodePromo,
                                  "payment_method":
                                      variable.selectedPaymentCategories,
                                  "payment_channel_code":
                                      variable.selectedPayment,
                                  "seatPicked[0][name]":
                                      variable.namePassengger1,
                                  "seatPicked[0][seat]":
                                      variable.seatPergiPassengger1,
                                  "seatPicked[0][food]":
                                      variable.foodIdPassengger1,
                                  "seatPicked[0][baggage]":
                                      variable.baggagePassengger1,
                                  "seatPicked[0][identity]":
                                      variable.nikTypePassengger1,
                                  "seatPicked[0][identity_number]":
                                      variable.nikPassengger1,
                                  "seatPicked[0][phone]":
                                      variable.phonePassengger1,
                                  "seatPicked[1][name]":
                                      variable.namePassengger2,
                                  "seatPicked[1][seat]":
                                      variable.seatPergiPassengger2,
                                  "seatPicked[1][food]":
                                      variable.foodIdPassengger2,
                                  "seatPicked[1][baggage]":
                                      variable.baggagePassengger2,
                                  "seatPicked[1][identity]":
                                      variable.nikTypePassengger2,
                                  "seatPicked[1][identity_number]":
                                      variable.nikPassengger2,
                                  "seatPicked[1][phone]":
                                      variable.phonePassengger2,
                                  "seatPicked[2][name]":
                                      variable.namePassengger3,
                                  "seatPicked[2][seat]":
                                      variable.seatPergiPassengger3,
                                  "seatPicked[2][food]":
                                      variable.foodIdPassengger3,
                                  "seatPicked[2][baggage]":
                                      variable.baggagePassengger3,
                                  "seatPicked[2][identity]":
                                      variable.nikTypePassengger3,
                                  "seatPicked[2][identity_number]":
                                      variable.nikPassengger3,
                                  "seatPicked[2][phone]":
                                      variable.phonePassengger3,
                                }
                              : (variable.checkPulangPergi == false &&
                                      int.parse(variable
                                              .selectedJumlahPenumpang) ==
                                          4)
                                  ? {
                                      "trip_id_no": variable.pergi_trip_id_no,
                                      "trip_route_id":
                                          variable.pergi_trip_route_id,
                                      "pickup_location":
                                          variable.pergi_pickup_trip_location,
                                      "drop_location":
                                          variable.pergi_drop_trip_location,
                                      "pricePerSeat": variable.totalPrice,
                                      "booking_date": variable.datePergi,
                                      "fleet_type_id": variable.pergi_type,
                                      "offer_code": variable.kodePromo,
                                      "payment_method":
                                          variable.selectedPaymentCategories,
                                      "payment_channel_code":
                                          variable.selectedPayment,
                                      "seatPicked[0][name]":
                                          variable.namePassengger1,
                                      "seatPicked[0][seat]":
                                          variable.seatPergiPassengger1,
                                      "seatPicked[0][food]":
                                          variable.foodIdPassengger1,
                                      "seatPicked[0][baggage]":
                                          variable.baggagePassengger1,
                                      "seatPicked[0][identity]":
                                          variable.nikTypePassengger1,
                                      "seatPicked[0][identity_number]":
                                          variable.nikPassengger1,
                                      "seatPicked[0][phone]":
                                          variable.phonePassengger1,
                                      "seatPicked[1][name]":
                                          variable.namePassengger2,
                                      "seatPicked[1][seat]":
                                          variable.seatPergiPassengger2,
                                      "seatPicked[1][food]":
                                          variable.foodIdPassengger2,
                                      "seatPicked[1][baggage]":
                                          variable.baggagePassengger2,
                                      "seatPicked[1][identity]":
                                          variable.nikTypePassengger2,
                                      "seatPicked[1][identity_number]":
                                          variable.nikPassengger2,
                                      "seatPicked[1][phone]":
                                          variable.phonePassengger2,
                                      "seatPicked[2][name]":
                                          variable.namePassengger3,
                                      "seatPicked[2][seat]":
                                          variable.seatPergiPassengger3,
                                      "seatPicked[2][food]":
                                          variable.foodIdPassengger3,
                                      "seatPicked[2][baggage]":
                                          variable.baggagePassengger3,
                                      "seatPicked[2][identity]":
                                          variable.nikTypePassengger3,
                                      "seatPicked[2][identity_number]":
                                          variable.nikPassengger3,
                                      "seatPicked[2][phone]":
                                          variable.phonePassengger3,
                                      "seatPicked[3][name]":
                                          variable.namePassengger4,
                                      "seatPicked[3][seat]":
                                          variable.seatPergiPassengger4,
                                      "seatPicked[3][food]":
                                          variable.foodIdPassengger4,
                                      "seatPicked[3][baggage]":
                                          variable.baggagePassengger4,
                                      "seatPicked[3][identity]":
                                          variable.nikTypePassengger4,
                                      "seatPicked[3][identity_number]":
                                          variable.nikPassengger4,
                                      "seatPicked[3][phone]":
                                          variable.phonePassengger4,
                                    }
                                  : (variable.checkPulangPergi == true &&
                                          int.parse(variable
                                                  .selectedJumlahPenumpang) ==
                                              4)
                                      ? {
                                          "trip_id_no":
                                              variable.pergi_trip_id_no,
                                          "trip_route_id":
                                              variable.pergi_trip_route_id,
                                          "pickup_location": variable
                                              .pergi_pickup_trip_location,
                                          "drop_location":
                                              variable.pergi_drop_trip_location,
                                          "pricePerSeat": variable.totalPrice,
                                          "booking_date": variable.datePergi,
                                          "fleet_type_id": variable.pergi_type,
                                          "offer_code": variable.kodePromo,
                                          "payment_method": variable
                                              .selectedPaymentCategories,
                                          "payment_channel_code":
                                              variable.selectedPayment,
                                          "seatPicked[0][name]":
                                              variable.namePassengger1,
                                          "seatPicked[0][seat]":
                                              variable.seatPergiPassengger1,
                                          "seatPicked[0][food]":
                                              variable.foodIdPassengger1,
                                          "seatPicked[0][baggage]":
                                              variable.baggagePassengger1,
                                          "seatPicked[0][identity]":
                                              variable.nikTypePassengger1,
                                          "seatPicked[0][identity_number]":
                                              variable.nikPassengger1,
                                          "seatPicked[0][phone]":
                                              variable.phonePassengger1,
                                          "seatPicked[1][name]":
                                              variable.namePassengger2,
                                          "seatPicked[1][seat]":
                                              variable.seatPergiPassengger2,
                                          "seatPicked[1][food]":
                                              variable.foodIdPassengger2,
                                          "seatPicked[1][baggage]":
                                              variable.baggagePassengger2,
                                          "seatPicked[1][identity]":
                                              variable.nikTypePassengger2,
                                          "seatPicked[1][identity_number]":
                                              variable.nikPassengger2,
                                          "seatPicked[1][phone]":
                                              variable.phonePassengger2,
                                          "seatPicked[2][name]":
                                              variable.namePassengger3,
                                          "seatPicked[2][seat]":
                                              variable.seatPergiPassengger3,
                                          "seatPicked[2][food]":
                                              variable.foodIdPassengger3,
                                          "seatPicked[2][baggage]":
                                              variable.baggagePassengger3,
                                          "seatPicked[2][identity]":
                                              variable.nikTypePassengger3,
                                          "seatPicked[2][identity_number]":
                                              variable.nikPassengger3,
                                          "seatPicked[2][phone]":
                                              variable.phonePassengger3,
                                          "seatPicked[3][name]":
                                              variable.namePassengger4,
                                          "seatPicked[3][seat]":
                                              variable.seatPergiPassengger4,
                                          "seatPicked[3][food]":
                                              variable.foodIdPassengger4,
                                          "seatPicked[3][baggage]":
                                              variable.baggagePassengger4,
                                          "seatPicked[3][identity]":
                                              variable.nikTypePassengger4,
                                          "seatPicked[3][identity_number]":
                                              variable.nikPassengger4,
                                          "seatPicked[3][phone]":
                                              variable.phonePassengger4,
                                        }
                                      : '',
    );

    return response.body;
  }
}

// class BookingList {
//   static list() async {

//     String url = "https://api-j99.pesoros.com/booking/add";

//     Uri parseUrl = Uri.parse(
//       url,
//     );
//     final response = await http.post(
//       parseUrl,
//       headers: {"Content-Type": "application/x-www-form-urlencoded"},
//       body: {
//         "trip_id_no": variable.pergi_trip_id_no,
//         "trip_route_id": variable.pergi_trip_route_id,
//         "pickup_location": variable.pergi_pickup_trip_location,
//         "drop_location": variable.pergi_drop_trip_location,
//         "pricePerSeat": variable.totalPrice,
//         "booking_date": variable.datePergi,
//         "fleet_type_id": variable.pergi_type,
//         "offer_code": variable.kodePromo,
//         "payment_method": variable.selectedPaymentCategories,
//         "payment_channel_code": variable.selectedPayment,
//         "seatPicked[0][name]": variable.namePassengger1,
//         "seatPicked[0][seat]": variable.seatPergiPassengger1,
//         "seatPicked[0][food]": variable.foodIdPassengger1,
//         "seatPicked[0][baggage]": variable.baggagePassengger1,
//         "seatPicked[0][identity]": variable.nikTypePassengger1,
//         "seatPicked[0][identity_number]": variable.nikPassengger1,
//         "seatPicked[0][phone]": variable.phonePassengger1,
//       },
//     );

//     if (jsonDecode(response.body)['status'] == true) {
//       var payment = jsonDecode(response.body)['payment'];
//       variable.status = payment['status'];
//       variable.bank_code = payment['bank_code'];
//       variable.merchant_code = payment['merchant_code'];
//       variable.name = payment['name'];
//       variable.account_number = payment['account_number'];
//       variable.expiration_date = payment['expiration_date'];
//       variable.payment_id = payment['id'];
//       print(response.body);
//     } else {
//       print(response.body);
//     }
//   }
// }