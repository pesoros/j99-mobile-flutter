// ignore_for_file: unused_import, unnecessary_statements

import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/screens/passengger_form_screen.dart';
import 'package:juragan99/screens/payment_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:juragan99/utils/variables.dart' as variable;

class SeatPlanPergiWidget extends StatefulWidget {
  @override
  _SeatPlanPergiWidgetScreen createState() => _SeatPlanPergiWidgetScreen();
}

class _SeatPlanPergiWidgetScreen extends State<SeatPlanPergiWidget> {
  List list = [];
  List li = [];
  bool index = false;
  List<SlotPergi> _slotList = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() async {
    await SlotPergiList.list(
            variable.pergi_trip_id_no,
            variable.pergi_trip_route_id,
            variable.pergi_fleet_registration_id,
            variable.pergi_type)
        .then((value) {
      setState(() {
        _slotList = value;
      });
      getSlotList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackWidget(
              title: "Pilih Kursi",
            ),
            bodyWidget(context),
            buttonWidget(context)
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 70,
        bottom: 70,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _passenggerPickedSeat(context),
            SizedBox(height: 10),
            _availableSeatWidget(context),
          ],
        ),
      ),
    );
  }

  _passenggerPickedSeat(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Column(
        children: [
          (variable.selectedJumlahPenumpang == "1")
              ? _passenggerPickedSeatCard1(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "2")
              ? _passenggerPickedSeatCard1(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "2")
              ? _passenggerPickedSeatCard2(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "3")
              ? _passenggerPickedSeatCard1(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "3")
              ? _passenggerPickedSeatCard2(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "3")
              ? _passenggerPickedSeatCard3(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "4")
              ? _passenggerPickedSeatCard1(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "4")
              ? _passenggerPickedSeatCard2(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "4")
              ? _passenggerPickedSeatCard3(context)
              : Container(),
          (variable.selectedJumlahPenumpang == "4")
              ? _passenggerPickedSeatCard4(context)
              : Container(),
        ],
      ),
    );
  }

  _passenggerPickedSeatCard1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (variable.namePassengger1 == null)
                      ? ""
                      : variable.namePassengger1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
                Text(
                  (li.asMap()[0] == null)
                      ? "Nomor Kursi :  "
                      : "Nomor Kursi:  " + li[0],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
          )),
    );
  }

  _passenggerPickedSeatCard2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (variable.namePassengger2 == null)
                      ? ""
                      : variable.namePassengger2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
                Text(
                  (li.asMap()[1] == null)
                      ? "Nomor Kursi :  "
                      : "Nomor Kursi:  " + li[1],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
          )),
    );
  }

  _passenggerPickedSeatCard3(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (variable.namePassengger3 == null)
                      ? ""
                      : variable.namePassengger3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
                Text(
                  (li.asMap()[2] == null)
                      ? "Nomor Kursi :  "
                      : "Nomor Kursi:  " + li[2],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
          )),
    );
  }

  _passenggerPickedSeatCard4(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (variable.namePassengger4 == null)
                      ? ""
                      : variable.namePassengger4,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
                Text(
                  (li.asMap()[3] == null)
                      ? "Nomor Kursi :  "
                      : "Nomor Kursi:  " + li[3],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.defaultTextSize),
                ),
              ],
            ),
          )),
    );
  }

  _availableSeatWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize,
            bottom: Dimensions.heightSize,
          ),
          child: Column(
            children: [
              _allTicketWidget(context),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _seatHintWidget(CustomColor.white, "Tersedia"),
                    _seatHintWidget(CustomColor.grey, "Dipesan"),
                    _seatHintWidget(CustomColor.red, "Dipilih"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _allTicketWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(_slotList.length, (index) {
          SlotPergi slot = _slotList[index];
          return slot.pergi_isSeat
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: slot.pergi_isAvailable
                              ? list[index]
                                  ? Colors.white
                                  : CustomColor.red
                              : CustomColor.grey,
                          border: Border.all(
                              color: CustomColor.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          '${slot.pergi_name}',
                          style: TextStyle(
                              color: slot.pergi_isAvailable
                                  ? list[index]
                                      ? CustomColor.darkGrey
                                      : CustomColor.white
                                  : CustomColor.white,
                              fontSize: Dimensions.defaultTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (li.length >=
                              int.parse(variable.selectedJumlahPenumpang) &&
                          !li.contains(slot.pergi_name)) {
                      } else {
                        if (!slot.pergi_isAvailable) {
                          Fluttertoast.showToast(
                            msg: "Kursi sudah dipesan",
                            backgroundColor: CustomColor.red,
                            textColor: CustomColor.white,
                            gravity: ToastGravity.CENTER,
                          );
                        } else {
                          if (li.contains(slot.pergi_name)) {
                            setState(() {
                              li.removeWhere(
                                  (element) => element == slot.pergi_name);
                              list[index] = !list[index];
                            });
                          } else {
                            setState(() {
                              list[index] = !list[index];
                              li.add(slot.pergi_name);
                            });
                          }
                        }
                      }
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                );
        }),
      ),
    );
  }

  _seatHintWidget(Color hintColor, String title) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: hintColor,
                border: Border.all(color: CustomColor.grey.withOpacity(0.5))),
          ),
          SizedBox(
            width: Dimensions.widthSize * 0.5,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.defaultTextSize),
          )
        ],
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Pilih Kursi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          var selectedJumlahPenumpang =
              int.parse(variable.selectedJumlahPenumpang);

          if (li.length != selectedJumlahPenumpang) {
            Fluttertoast.showToast(
              msg: "Lengkapi kursi dahulu",
              backgroundColor: CustomColor.red,
              textColor: CustomColor.white,
              gravity: ToastGravity.CENTER,
            );
          } else {
            if (selectedJumlahPenumpang == 1) {
              variable.seatPergiPassengger1 = li[0].toString();
              Navigator.pop(context);
            }
            if (selectedJumlahPenumpang == 2) {
              variable.seatPergiPassengger1 = li[0].toString();
              variable.seatPergiPassengger2 = li[1].toString();
              Navigator.pop(context);
            }
            if (selectedJumlahPenumpang == 3) {
              variable.seatPergiPassengger1 = li[0].toString();
              variable.seatPergiPassengger2 = li[1].toString();
              variable.seatPergiPassengger3 = li[2].toString();
              Navigator.pop(context);
            }
            if (selectedJumlahPenumpang == 4) {
              variable.seatPergiPassengger1 = li[0].toString();
              variable.seatPergiPassengger2 = li[1].toString();
              variable.seatPergiPassengger3 = li[2].toString();
              variable.seatPergiPassengger4 = li[3].toString();
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }

  void getSlotList() {
    int data = _slotList.length;
    for (int i = 0; i < data; i++) {
      SlotPergi slot = _slotList[i];
      list.add(slot.pergi_isAvailable);
    }
  }
}
