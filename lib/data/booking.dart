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
              "offer_code": "",
              "booker_id": "",
              "booker_name": variable.first_name + " " + variable.last_name,
              "booker_email": variable.email,
              "booker_phone": variable.phone,
              "payment_method": variable.selectedPaymentCategories,
              "payment_channel_code": variable.selectedPayment,
              "pergi[trip_id_no]": variable.pergi_trip_id_no,
              "pergi[trip_route_id]": variable.pergi_trip_route_id,
              "pergi[pickup_location]": variable.pergi_pickup_trip_location,
              "pergi[drop_location]": variable.pergi_drop_trip_location,
              "pergi[pricePerSeat]": variable.pergi_price,
              "pergi[booking_date]": variable.datePergi,
              "pergi[fleet_type_id]": variable.pergi_type,
              "pergi[seatPicked][0][name]": variable.namePassengger1,
              "pergi[seatPicked][0][seat]": variable.seatPergiPassengger1,
              "pergi[seatPicked][0][food]": variable.foodIdPergiPassengger1,
              "pergi[seatPicked][0][baggage]": variable.baggagePergiPassengger1,
              "pergi[seatPicked][0][phone]": variable.phonePassengger1,
            }
          : (variable.checkPulangPergi == true &&
                  int.parse(variable.selectedJumlahPenumpang) == 1)
              ? {
                  "offer_code": "",
                  "booker_id": "",
                  "booker_name": variable.first_name + " " + variable.last_name,
                  "booker_email": variable.email,
                  "booker_phone": variable.phone,
                  "payment_method": variable.selectedPaymentCategories,
                  "payment_channel_code": variable.selectedPayment,
                  "pergi[trip_id_no]": variable.pergi_trip_id_no,
                  "pergi[trip_route_id]": variable.pergi_trip_route_id,
                  "pergi[pickup_location]": variable.pergi_pickup_trip_location,
                  "pergi[drop_location]": variable.pergi_drop_trip_location,
                  "pergi[pricePerSeat]": variable.pergi_price,
                  "pergi[booking_date]": variable.datePergi,
                  "pergi[fleet_type_id]": variable.pergi_type,
                  "pergi[seatPicked][0][name]": variable.namePassengger1,
                  "pergi[seatPicked][0][seat]": variable.seatPergiPassengger1,
                  "pergi[seatPicked][0][food]": variable.foodIdPergiPassengger1,
                  "pergi[seatPicked][0][baggage]":
                      variable.baggagePergiPassengger1,
                  "pergi[seatPicked][0][phone]": variable.phonePassengger1,
                  "pulang[trip_id_no]": variable.pulang_trip_id_no,
                  "pulang[trip_route_id]": variable.pulang_trip_route_id,
                  "pulang[pickup_location]":
                      variable.pulang_pickup_trip_location,
                  "pulang[drop_location]": variable.pulang_drop_trip_location,
                  "pulang[pricePerSeat]": variable.pulang_price,
                  "pulang[booking_date]": variable.datePulang,
                  "pulang[fleet_type_id]": variable.pulang_type,
                  "pulang[seatPicked][0][name]": variable.namePassengger1,
                  "pulang[seatPicked][0][seat]": variable.seatPulangPassengger1,
                  "pulang[seatPicked][0][food]":
                      variable.foodIdPulangPassengger1,
                  "pulang[seatPicked][0][baggage]":
                      variable.baggagePulangPassengger1,
                  "pulang[seatPicked][0][phone]": variable.phonePassengger1,
                }
              : (variable.checkPulangPergi == false &&
                      int.parse(variable.selectedJumlahPenumpang) == 2)
                  ? {
                      "offer_code": "",
                      "booker_id": "",
                      "booker_name":
                          variable.first_name + " " + variable.last_name,
                      "booker_email": variable.email,
                      "booker_phone": variable.phone,
                      "payment_method": variable.selectedPaymentCategories,
                      "payment_channel_code": variable.selectedPayment,
                      "pergi[trip_id_no]": variable.pergi_trip_id_no,
                      "pergi[trip_route_id]": variable.pergi_trip_route_id,
                      "pergi[pickup_location]":
                          variable.pergi_pickup_trip_location,
                      "pergi[drop_location]": variable.pergi_drop_trip_location,
                      "pergi[pricePerSeat]": variable.pergi_price,
                      "pergi[booking_date]": variable.datePergi,
                      "pergi[fleet_type_id]": variable.pergi_type,
                      "pergi[seatPicked][0][name]": variable.namePassengger1,
                      "pergi[seatPicked][0][seat]":
                          variable.seatPergiPassengger1,
                      "pergi[seatPicked][0][food]":
                          variable.foodIdPergiPassengger1,
                      "pergi[seatPicked][0][baggage]":
                          variable.baggagePergiPassengger1,
                      "pergi[seatPicked][0][phone]": variable.phonePassengger1,
                      "pergi[seatPicked][1][name]": variable.namePassengger2,
                      "pergi[seatPicked][1][seat]":
                          variable.seatPergiPassengger2,
                      "pergi[seatPicked][1][food]":
                          variable.foodIdPergiPassengger2,
                      "pergi[seatPicked][1][baggage]":
                          variable.baggagePergiPassengger2,
                      "pergi[seatPicked][1][phone]": variable.phonePassengger2,
                    }
                  : (variable.checkPulangPergi == true &&
                          int.parse(variable.selectedJumlahPenumpang) == 2)
                      ? {
                          "offer_code": "",
                          "booker_id": "",
                          "booker_name":
                              variable.first_name + " " + variable.last_name,
                          "booker_email": variable.email,
                          "booker_phone": variable.phone,
                          "payment_method": variable.selectedPaymentCategories,
                          "payment_channel_code": variable.selectedPayment,
                          "pergi[trip_id_no]": variable.pergi_trip_id_no,
                          "pergi[trip_route_id]": variable.pergi_trip_route_id,
                          "pergi[pickup_location]":
                              variable.pergi_pickup_trip_location,
                          "pergi[drop_location]":
                              variable.pergi_drop_trip_location,
                          "pergi[pricePerSeat]": variable.pergi_price,
                          "pergi[booking_date]": variable.datePergi,
                          "pergi[fleet_type_id]": variable.pergi_type,
                          "pergi[seatPicked][0][name]":
                              variable.namePassengger1,
                          "pergi[seatPicked][0][seat]":
                              variable.seatPergiPassengger1,
                          "pergi[seatPicked][0][food]":
                              variable.foodIdPergiPassengger1,
                          "pergi[seatPicked][0][baggage]":
                              variable.baggagePergiPassengger1,
                          "pergi[seatPicked][0][phone]":
                              variable.phonePassengger1,
                          "pergi[seatPicked][1][name]":
                              variable.namePassengger2,
                          "pergi[seatPicked][1][seat]":
                              variable.seatPergiPassengger2,
                          "pergi[seatPicked][1][food]":
                              variable.foodIdPergiPassengger2,
                          "pergi[seatPicked][1][baggage]":
                              variable.baggagePergiPassengger2,
                          "pergi[seatPicked][1][phone]":
                              variable.phonePassengger2,
                          "pulang[trip_id_no]": variable.pulang_trip_id_no,
                          "pulang[trip_route_id]":
                              variable.pulang_trip_route_id,
                          "pulang[pickup_location]":
                              variable.pulang_pickup_trip_location,
                          "pulang[drop_location]":
                              variable.pulang_drop_trip_location,
                          "pulang[pricePerSeat]": variable.pulang_price,
                          "pulang[booking_date]": variable.datePulang,
                          "pulang[fleet_type_id]": variable.pulang_type,
                          "pulang[seatPicked][0][name]":
                              variable.namePassengger1,
                          "pulang[seatPicked][0][seat]":
                              variable.seatPulangPassengger1,
                          "pulang[seatPicked][0][food]":
                              variable.foodIdPulangPassengger1,
                          "pulang[seatPicked][0][baggage]":
                              variable.baggagePulangPassengger1,
                          "pulang[seatPicked][0][phone]":
                              variable.phonePassengger1,
                          "pulang[seatPicked][1][name]":
                              variable.namePassengger2,
                          "pulang[seatPicked][1][seat]":
                              variable.seatPulangPassengger2,
                          "pulang[seatPicked][1][food]":
                              variable.foodIdPulangPassengger2,
                          "pulang[seatPicked][1][baggage]":
                              variable.baggagePulangPassengger2,
                          "pulang[seatPicked][1][phone]":
                              variable.phonePassengger2,
                        }
                      : (variable.checkPulangPergi == false &&
                              int.parse(variable.selectedJumlahPenumpang) == 3)
                          ? {
                              "offer_code": "",
                              "booker_id": "",
                              "booker_name": variable.first_name +
                                  " " +
                                  variable.last_name,
                              "booker_email": variable.email,
                              "booker_phone": variable.phone,
                              "payment_method":
                                  variable.selectedPaymentCategories,
                              "payment_channel_code": variable.selectedPayment,
                              "pergi[trip_id_no]": variable.pergi_trip_id_no,
                              "pergi[trip_route_id]":
                                  variable.pergi_trip_route_id,
                              "pergi[pickup_location]":
                                  variable.pergi_pickup_trip_location,
                              "pergi[drop_location]":
                                  variable.pergi_drop_trip_location,
                              "pergi[pricePerSeat]": variable.pergi_price,
                              "pergi[booking_date]": variable.datePergi,
                              "pergi[fleet_type_id]": variable.pergi_type,
                              "pergi[seatPicked][0][name]":
                                  variable.namePassengger1,
                              "pergi[seatPicked][0][seat]":
                                  variable.seatPergiPassengger1,
                              "pergi[seatPicked][0][food]":
                                  variable.foodIdPergiPassengger1,
                              "pergi[seatPicked][0][baggage]":
                                  variable.baggagePergiPassengger1,
                              "pergi[seatPicked][0][phone]":
                                  variable.phonePassengger1,
                              "pergi[seatPicked][1][name]":
                                  variable.namePassengger2,
                              "pergi[seatPicked][1][seat]":
                                  variable.seatPergiPassengger2,
                              "pergi[seatPicked][1][food]":
                                  variable.foodIdPergiPassengger2,
                              "pergi[seatPicked][1][baggage]":
                                  variable.baggagePergiPassengger2,
                              "pergi[seatPicked][1][phone]":
                                  variable.phonePassengger2,
                              "pergi[seatPicked][2][name]":
                                  variable.namePassengger3,
                              "pergi[seatPicked][2][seat]":
                                  variable.seatPergiPassengger3,
                              "pergi[seatPicked][2][food]":
                                  variable.foodIdPergiPassengger3,
                              "pergi[seatPicked][2][baggage]":
                                  variable.baggagePergiPassengger3,
                              "pergi[seatPicked][2][phone]":
                                  variable.phonePassengger3,
                            }
                          : (variable.checkPulangPergi == true &&
                                  int.parse(variable.selectedJumlahPenumpang) ==
                                      3)
                              ? {
                                  "offer_code": "",
                                  "booker_id": "",
                                  "booker_name": variable.first_name +
                                      " " +
                                      variable.last_name,
                                  "booker_email": variable.email,
                                  "booker_phone": variable.phone,
                                  "payment_method":
                                      variable.selectedPaymentCategories,
                                  "payment_channel_code":
                                      variable.selectedPayment,
                                  "pergi[trip_id_no]":
                                      variable.pergi_trip_id_no,
                                  "pergi[trip_route_id]":
                                      variable.pergi_trip_route_id,
                                  "pergi[pickup_location]":
                                      variable.pergi_pickup_trip_location,
                                  "pergi[drop_location]":
                                      variable.pergi_drop_trip_location,
                                  "pergi[pricePerSeat]": variable.pergi_price,
                                  "pergi[booking_date]": variable.datePergi,
                                  "pergi[fleet_type_id]": variable.pergi_type,
                                  "pergi[seatPicked][0][name]":
                                      variable.namePassengger1,
                                  "pergi[seatPicked][0][seat]":
                                      variable.seatPergiPassengger1,
                                  "pergi[seatPicked][0][food]":
                                      variable.foodIdPergiPassengger1,
                                  "pergi[seatPicked][0][baggage]":
                                      variable.baggagePergiPassengger1,
                                  "pergi[seatPicked][0][phone]":
                                      variable.phonePassengger1,
                                  "pergi[seatPicked][1][name]":
                                      variable.namePassengger2,
                                  "pergi[seatPicked][1][seat]":
                                      variable.seatPergiPassengger2,
                                  "pergi[seatPicked][1][food]":
                                      variable.foodIdPergiPassengger2,
                                  "pergi[seatPicked][1][baggage]":
                                      variable.baggagePergiPassengger2,
                                  "pergi[seatPicked][1][phone]":
                                      variable.phonePassengger2,
                                  "pergi[seatPicked][2][name]":
                                      variable.namePassengger3,
                                  "pergi[seatPicked][2][seat]":
                                      variable.seatPergiPassengger3,
                                  "pergi[seatPicked][2][food]":
                                      variable.foodIdPergiPassengger3,
                                  "pergi[seatPicked][2][baggage]":
                                      variable.baggagePergiPassengger3,
                                  "pergi[seatPicked][2][phone]":
                                      variable.phonePassengger3,
                                  "pulang[trip_id_no]":
                                      variable.pulang_trip_id_no,
                                  "pulang[trip_route_id]":
                                      variable.pulang_trip_route_id,
                                  "pulang[pickup_location]":
                                      variable.pulang_pickup_trip_location,
                                  "pulang[drop_location]":
                                      variable.pulang_drop_trip_location,
                                  "pulang[pricePerSeat]": variable.pulang_price,
                                  "pulang[booking_date]": variable.datePulang,
                                  "pulang[fleet_type_id]": variable.pulang_type,
                                  "pulang[seatPicked][0][name]":
                                      variable.namePassengger1,
                                  "pulang[seatPicked][0][seat]":
                                      variable.seatPulangPassengger1,
                                  "pulang[seatPicked][0][food]":
                                      variable.foodIdPulangPassengger1,
                                  "pulang[seatPicked][0][baggage]":
                                      variable.baggagePulangPassengger1,
                                  "pulang[seatPicked][0][phone]":
                                      variable.phonePassengger1,
                                  "pulang[seatPicked][1][name]":
                                      variable.namePassengger2,
                                  "pulang[seatPicked][1][seat]":
                                      variable.seatPulangPassengger2,
                                  "pulang[seatPicked][1][food]":
                                      variable.foodIdPulangPassengger2,
                                  "pulang[seatPicked][1][baggage]":
                                      variable.baggagePulangPassengger2,
                                  "pulang[seatPicked][1][phone]":
                                      variable.phonePassengger2,
                                  "pulang[seatPicked][2][name]":
                                      variable.namePassengger3,
                                  "pulang[seatPicked][2][seat]":
                                      variable.seatPulangPassengger3,
                                  "pulang[seatPicked][2][food]":
                                      variable.foodIdPulangPassengger3,
                                  "pulang[seatPicked][2][baggage]":
                                      variable.baggagePulangPassengger3,
                                  "pulang[seatPicked][2][phone]":
                                      variable.phonePassengger3,
                                }
                              : (variable.checkPulangPergi == false &&
                                      int.parse(variable
                                              .selectedJumlahPenumpang) ==
                                          4)
                                  ? {
                                      "offer_code": "",
                                      "booker_id": "",
                                      "booker_name": variable.first_name +
                                          " " +
                                          variable.last_name,
                                      "booker_email": variable.email,
                                      "booker_phone": variable.phone,
                                      "payment_method":
                                          variable.selectedPaymentCategories,
                                      "payment_channel_code":
                                          variable.selectedPayment,
                                      "pergi[trip_id_no]":
                                          variable.pergi_trip_id_no,
                                      "pergi[trip_route_id]":
                                          variable.pergi_trip_route_id,
                                      "pergi[pickup_location]":
                                          variable.pergi_pickup_trip_location,
                                      "pergi[drop_location]":
                                          variable.pergi_drop_trip_location,
                                      "pergi[pricePerSeat]":
                                          variable.pergi_price,
                                      "pergi[booking_date]": variable.datePergi,
                                      "pergi[fleet_type_id]":
                                          variable.pergi_type,
                                      "pergi[seatPicked][0][name]":
                                          variable.namePassengger1,
                                      "pergi[seatPicked][0][seat]":
                                          variable.seatPergiPassengger1,
                                      "pergi[seatPicked][0][food]":
                                          variable.foodIdPergiPassengger1,
                                      "pergi[seatPicked][0][baggage]":
                                          variable.baggagePergiPassengger1,
                                      "pergi[seatPicked][0][phone]":
                                          variable.phonePassengger1,
                                      "pergi[seatPicked][1][name]":
                                          variable.namePassengger2,
                                      "pergi[seatPicked][1][seat]":
                                          variable.seatPergiPassengger2,
                                      "pergi[seatPicked][1][food]":
                                          variable.foodIdPergiPassengger2,
                                      "pergi[seatPicked][1][baggage]":
                                          variable.baggagePergiPassengger2,
                                      "pergi[seatPicked][1][phone]":
                                          variable.phonePassengger2,
                                      "pergi[seatPicked][2][name]":
                                          variable.namePassengger3,
                                      "pergi[seatPicked][2][seat]":
                                          variable.seatPergiPassengger3,
                                      "pergi[seatPicked][2][food]":
                                          variable.foodIdPergiPassengger3,
                                      "pergi[seatPicked][2][baggage]":
                                          variable.baggagePergiPassengger3,
                                      "pergi[seatPicked][2][phone]":
                                          variable.phonePassengger3,
                                      "pergi[seatPicked][3][name]":
                                          variable.namePassengger4,
                                      "pergi[seatPicked][3][seat]":
                                          variable.seatPergiPassengger4,
                                      "pergi[seatPicked][3][food]":
                                          variable.foodIdPergiPassengger4,
                                      "pergi[seatPicked][3][baggage]":
                                          variable.baggagePergiPassengger4,
                                      "pergi[seatPicked][3][phone]":
                                          variable.phonePassengger4,
                                    }
                                  : (variable.checkPulangPergi == true &&
                                          int.parse(variable
                                                  .selectedJumlahPenumpang) ==
                                              4)
                                      ? {
                                          "offer_code": "",
                                          "booker_id": "",
                                          "booker_name": variable.first_name +
                                              " " +
                                              variable.last_name,
                                          "booker_email": variable.email,
                                          "booker_phone": variable.phone,
                                          "payment_method": variable
                                              .selectedPaymentCategories,
                                          "payment_channel_code":
                                              variable.selectedPayment,
                                          "pergi[trip_id_no]":
                                              variable.pergi_trip_id_no,
                                          "pergi[trip_route_id]":
                                              variable.pergi_trip_route_id,
                                          "pergi[pickup_location]": variable
                                              .pergi_pickup_trip_location,
                                          "pergi[drop_location]":
                                              variable.pergi_drop_trip_location,
                                          "pergi[pricePerSeat]":
                                              variable.pergi_price,
                                          "pergi[booking_date]":
                                              variable.datePergi,
                                          "pergi[fleet_type_id]":
                                              variable.pergi_type,
                                          "pergi[seatPicked][0][name]":
                                              variable.namePassengger1,
                                          "pergi[seatPicked][0][seat]":
                                              variable.seatPergiPassengger1,
                                          "pergi[seatPicked][0][food]":
                                              variable.foodIdPergiPassengger1,
                                          "pergi[seatPicked][0][baggage]":
                                              variable.baggagePergiPassengger1,
                                          "pergi[seatPicked][0][phone]":
                                              variable.phonePassengger1,
                                          "pergi[seatPicked][1][name]":
                                              variable.namePassengger2,
                                          "pergi[seatPicked][1][seat]":
                                              variable.seatPergiPassengger2,
                                          "pergi[seatPicked][1][food]":
                                              variable.foodIdPergiPassengger2,
                                          "pergi[seatPicked][1][baggage]":
                                              variable.baggagePergiPassengger2,
                                          "pergi[seatPicked][1][phone]":
                                              variable.phonePassengger2,
                                          "pergi[seatPicked][2][name]":
                                              variable.namePassengger3,
                                          "pergi[seatPicked][2][seat]":
                                              variable.seatPergiPassengger3,
                                          "pergi[seatPicked][2][food]":
                                              variable.foodIdPergiPassengger3,
                                          "pergi[seatPicked][2][baggage]":
                                              variable.baggagePergiPassengger3,
                                          "pergi[seatPicked][2][phone]":
                                              variable.phonePassengger3,
                                          "pergi[seatPicked][3][name]":
                                              variable.namePassengger4,
                                          "pergi[seatPicked][3][seat]":
                                              variable.seatPergiPassengger4,
                                          "pergi[seatPicked][3][food]":
                                              variable.foodIdPergiPassengger4,
                                          "pergi[seatPicked][3][baggage]":
                                              variable.baggagePergiPassengger4,
                                          "pergi[seatPicked][3][phone]":
                                              variable.phonePassengger4,
                                          "pulang[trip_id_no]":
                                              variable.pulang_trip_id_no,
                                          "pulang[trip_route_id]":
                                              variable.pulang_trip_route_id,
                                          "pulang[pickup_location]": variable
                                              .pulang_pickup_trip_location,
                                          "pulang[drop_location]": variable
                                              .pulang_drop_trip_location,
                                          "pulang[pricePerSeat]":
                                              variable.pulang_price,
                                          "pulang[booking_date]":
                                              variable.datePulang,
                                          "pulang[fleet_type_id]":
                                              variable.pulang_type,
                                          "pulang[seatPicked][0][name]":
                                              variable.namePassengger1,
                                          "pulang[seatPicked][0][seat]":
                                              variable.seatPulangPassengger1,
                                          "pulang[seatPicked][0][food]":
                                              variable.foodIdPulangPassengger1,
                                          "pulang[seatPicked][0][baggage]":
                                              variable.baggagePulangPassengger1,
                                          "pulang[seatPicked][0][phone]":
                                              variable.phonePassengger1,
                                          "pulang[seatPicked][1][name]":
                                              variable.namePassengger2,
                                          "pulang[seatPicked][1][seat]":
                                              variable.seatPulangPassengger2,
                                          "pulang[seatPicked][1][food]":
                                              variable.foodIdPulangPassengger2,
                                          "pulang[seatPicked][1][baggage]":
                                              variable.baggagePulangPassengger2,
                                          "pulang[seatPicked][1][phone]":
                                              variable.phonePassengger2,
                                          "pulang[seatPicked][2][name]":
                                              variable.namePassengger3,
                                          "pulang[seatPicked][2][seat]":
                                              variable.seatPulangPassengger3,
                                          "pulang[seatPicked][2][food]":
                                              variable.foodIdPulangPassengger3,
                                          "pulang[seatPicked][2][baggage]":
                                              variable.baggagePulangPassengger3,
                                          "pulang[seatPicked][2][phone]":
                                              variable.phonePassengger3,
                                          "pulang[seatPicked][3][name]":
                                              variable.namePassengger4,
                                          "pulang[seatPicked][3][seat]":
                                              variable.seatPulangPassengger4,
                                          "pulang[seatPicked][3][food]":
                                              variable.foodIdPulangPassengger4,
                                          "pulang[seatPicked][3][baggage]":
                                              variable.baggagePulangPassengger4,
                                          "pulang[seatPicked][3][phone]":
                                              variable.phonePassengger4,
                                        }
                                      : '',
    );
    return response.body;
  }
}
