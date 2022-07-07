// ignore_for_file: must_be_immutable, unused_import, unused_element, unused_local_variable

import 'package:juragan99/data/profile.dart';
import 'package:juragan99/data/user.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/screens/settings/change_password_screen.dart';
import 'package:juragan99/screens/settings/update_profile_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:juragan99/utils/variables.dart' as variable;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String email = prefs.getString('email');
    setState(() {
      variable.token = token;
      variable.email = email;
    });
    getUser(email);
  }

  getUser(email) async {
    await Profile.list(email).then((value) {
      setState(() {
        variable.first_name = value['first_name'];
        variable.last_name = value['last_name'];
        variable.address = value['address'];
        variable.phone = value['phone'];
        variable.identity = value['identity'];
        variable.identity_number = value['identity_number'];
        isLoading = false;
      });
    });
  }

  removeUser() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('email');
    variable.token = null;
    variable.email = null;
    variable.first_name = null;
    variable.last_name = null;
    variable.address = null;
    variable.phone = null;
  }

  deleteUser() async {
    String url = dotenv.env['BASE_URL'] + "/account/delete";

    Uri parseUrl = Uri.parse(url);
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": variable.email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(context),
              (isLoading)
                  ? Container(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()))
                  : bodyWidget(context),
              updateProfileButtonWidget(context),
              changePasswordButtonWidget(context),
              // historyButtonWidget(context),
              deleteButtonWidget(context),
              logoutButtonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: CustomColor.white,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColor.darkGrey,
                              size: Dimensions.defaultTextSize,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(0)),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Profil",
                                  style: TextStyle(
                                      color: CustomColor.darkGrey,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5.0,
                offset: Offset(0.0, 0.0))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.marginSize),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _typeData("Nama Lengkap",
                    variable.first_name + " " + variable.last_name),
                _typeData("Email", variable.email),
                _typeData("No. Handphone", variable.phone),
                _typeData("Alamat", variable.address),
                // _typeData("Identitas", variable.identity),
                // _typeData("Nomor Identitas", variable.identity_number),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateProfileButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Perbarui Profil",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
          setState(() {});
        },
      ),
    );
  }

  changePasswordButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Ubah Sandi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
          );
        },
      ),
    );
  }

  historyButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Riwayat Transaksi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {},
      ),
    );
  }

  deleteButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Hapus Akun",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          modalDeleteAccount(context);
        },
      ),
    );
  }

  logoutButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(Dimensions.radius)),
          child: Center(
            child: Text(
              "Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          removeUser();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen(0)),
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }

  _typeData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.heightSize),
      child: Container(
        // /height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: CustomColor.secondaryColor.withOpacity(0.035),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
            top: Dimensions.heightSize,
            bottom: Dimensions.heightSize,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black, fontSize: Dimensions.defaultTextSize),
              ),
              Text(
                (value == null) ? "" : value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  modalDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text('Hapus Akun?'),
          content: SingleChildScrollView(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Tidak",
                    style: TextStyle(color: CustomColor.red),
                  )),
              TextButton(
                onPressed: () {
                  deleteUser();
                  removeUser();
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen(0)),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  "Ya",
                  style: TextStyle(color: CustomColor.red),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
