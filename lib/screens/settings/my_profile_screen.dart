// ignore_for_file: must_be_immutable, unused_import, unused_element

import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juragan99/utils/variables.dart' as variable;

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File _image, file;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    String email = pref.getString('email');
    String firstName = pref.getString('firstName');
    String lastName = pref.getString('lastName');
    String address = pref.getString('address');
    String phone = pref.getString('phone');
    setState(() {
      this.token = token;
      this.email = email;
      this.firstName = firstName;
      this.lastName = lastName;
      this.address = address;
      this.phone = phone;
    });
  }

  removeUser() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('email');
    pref.remove('firstName');
    pref.remove('lastName');
    pref.remove('address');
    pref.remove('phone');
    variable.token = null;
    variable.email = null;
    variable.firstName = null;
    variable.lastName = null;
    variable.address = null;
    variable.phone = null;
  }

  String token;
  String email;
  String firstName;
  String lastName;
  String address;
  String phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            headerWidget(context),
            bodyWidget(context),
            buttonWidget(context)
          ],
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        color: CustomColor.white,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: Stack(
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
        top: 70,
        bottom: 70,
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
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
                addImageWidget(context),
                _typeData(Strings.userName, firstName),
                _typeData(Strings.emailAddress, email),
                _typeData(Strings.phoneNumber, phone),
                _typeData(Strings.address, address),
                _typeData(Strings.lifetimeInsurance, 'Yes'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addImageWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(children: <Widget>[
        Container(
          height: 150,
          width: 150,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: CustomColor.secondaryColor,
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: _image == null
              ? Image.asset('assets/images/user.png', fit: BoxFit.cover)
              : Image.file(
                  _image,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(20.0)),
            child: IconButton(
              onPressed: () {
                _openImageSourceOptions(context);
              },
              padding: EdgeInsets.only(left: 5, right: 5),
              iconSize: 24,
              icon: Icon(
                Icons.camera_enhance,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _openImageSourceOptions(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: Dimensions.defaultTextSize,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _chooseFromCamera();
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.photo,
                    size: Dimensions.defaultTextSize,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _chooseFromGallery();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _chooseFromGallery() async {
    // ignore: deprecated_member_use
    final XFile file =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (file == null) {
      Fluttertoast.showToast(msg: 'No File Selected');
    } else {
      setState(() {
        _image = file as File;
      });
      //_upload();
    }
  }

  _chooseFromCamera() async {
    //ignore: deprecated_member_use
    final XFile file =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 40);

    if (file == null) {
      Fluttertoast.showToast(msg: 'No Capture Image');
    } else {
      setState(() {
        _image = file as File;
      });
      //_upload();
    }
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize,
      right: Dimensions.marginSize,
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
                  fontSize: Dimensions.largeTextSize,
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
                    color: Colors.black, fontSize: Dimensions.largeTextSize),
              ),
              Text(
                (value == null) ? "" : value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
