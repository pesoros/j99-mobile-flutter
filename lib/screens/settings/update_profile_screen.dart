// ignore_for_file: must_be_immutable, unused_import, unused_element, non_constant_identifier_names

import 'package:juragan99/data/profile.dart';
import 'package:juragan99/data/update_profile.dart';
import 'package:juragan99/dialog/forgot_password_dialog.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
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

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isLoading = true;

  TextEditingController emaileController = TextEditingController();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController identity_numberController = TextEditingController();
  TextEditingController identityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    await Profile.list(variable.email).then((value) {
      setState(() {
        emailController.text = value['email'];
        first_nameController.text = value['first_name'];
        last_nameController.text = value['last_name'];
        addressController.text = value['address'];
        phoneController.text = value['phone'];
        identity_numberController.text = value['identity_number'];
        identityController.text = value['identity'];
        isLoading = false;
      });
    });
  }

  updateProfile() async {
    await UpdateProfile.list(
      emailController.text,
      first_nameController.text,
      last_nameController.text,
      addressController.text,
      phoneController.text,
      identity_numberController.text,
      identityController.text,
    ).then((value) {
      if (value == true) {
        Navigator.pop(context);
      }
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
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : bodyWidget(context),
              (isLoading) ? Container() : saveButtonWidget(context),
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
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Perbarui Profil",
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
                Text("Nama Depan"),
                SizedBox(height: 5),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: first_nameController,
                  decoration: InputDecoration(
                    hintText: "Nama Depan",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
                SizedBox(height: 10),
                Text("Nama Belakang"),
                SizedBox(height: 5),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: last_nameController,
                  decoration: InputDecoration(
                    hintText: "Nama Belakang",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
                SizedBox(height: 10),
                Text("Alamat"),
                SizedBox(height: 5),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Alamat",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
                SizedBox(height: 10),
                Text("Nomor Handphone"),
                SizedBox(height: 5),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Nomor Handphone",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
                SizedBox(height: 10),
                Text("Nomor Identitas"),
                SizedBox(height: 5),
                TextFormField(
                  style: CustomStyle.textStyle,
                  controller: identity_numberController,
                  decoration: InputDecoration(
                    hintText: "Nomor Identitas",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    labelStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveButtonWidget(BuildContext context) {
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
              "Simpan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () async {
          updateProfile();
        },
      ),
    );
  }
}
