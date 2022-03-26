// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:indonesia/indonesia.dart';
import 'package:juragan99/data/bus_pergi.dart';
import 'package:juragan99/data/class.dart';
import 'package:juragan99/data/package.dart';
import 'package:juragan99/data/slot_pergi.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
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

class PackageResultScreen extends StatefulWidget {
  final String code;

  PackageResultScreen({this.code});

  @override
  _PackageResultScreen createState() => _PackageResultScreen();
}

class _PackageResultScreen extends State<PackageResultScreen> {
  bool isLoadingPackage = true;
  bool isLoadingTrace = true;

  String packet_code;
  String sender_name;
  String sender_phone;
  String receiver_name;
  String receiver_phone;
  String pool_sender_id;
  String pool_receiver_id;
  String type;
  String description;
  String weight;
  String created_at;

  List<TraceList> _traceList = [];

  @override
  void initState() {
    super.initState();
    getPackage();
    getTrace();
  }

  getPackage() async {
    await Package.list(widget.code).then((value) {
      setState(() {
        packet_code = value['packet_code'];
        sender_name = value['sender_name'];
        sender_phone = value['sender_phone'];
        receiver_name = value['receiver_name'];
        receiver_phone = value['receiver_phone'];
        pool_sender_id = value['pool_sender_id'];
        pool_receiver_id = value['pool_receiver_id'];
        type = value['type'];
        description = value['description'];
        weight = value['weight'];
        created_at = value['created_at'];
        isLoadingPackage = false;
      });
    });
  }

  getTrace() async {
    await Trace.list(widget.code).then((value) {
      setState(() {
        _traceList = value;
        isLoadingTrace = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.darkGrey,
        body: Stack(
          children: [
            (isLoadingPackage == true && isLoadingTrace == true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bodyWidget(context),
            buttonWidget(context),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        // bottom: 70,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _resiWidget(context),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: Dimensions.buttonHeight,
                margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                decoration: BoxDecoration(
                    color: CustomColor.red,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Center(
                  child: Text(
                    "Kembali",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen(3)),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ));
  }

  _resiWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColor.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("#" + packet_code,
                    style: TextStyle(
                        color: CustomColor.white,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          _resiDetail(context),
        ],
      ),
    );
  }

  _resiDetail(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _dataResi("Nama Pengirim: ", sender_name),
              _dataResi("No. Handphone: ", sender_phone),
              _dataResi("Nama Penerima: ", receiver_name),
              _dataResi("No. Handphone: ", receiver_phone),
              _dataResi("Dikirim dari: ", pool_sender_id),
              _dataResi("Diterima di: ", pool_receiver_id),
              _dataResi("Tipe paket: ", type),
              _dataResi("Deskripsi: ", description),
              _dataResi("Berat: ", weight),
              _dataResi("Dikirm tanggal: ", created_at),
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Text("Status",
                  style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: _traceList.length,
                  itemBuilder: (context, index) {
                    TraceList trace = _traceList[index];
                    return _dataTrace(trace.description, trace.created_at);
                  },
                ),
              )
            ],
          ),
        ));
  }

  _dataResi(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
          Text(
            price,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.defaultTextSize),
          ),
        ],
      ),
    );
  }

  _dataTrace(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black, fontSize: Dimensions.defaultTextSize),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
