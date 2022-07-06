// ignore_for_file: unused_element, unrelated_type_equality_checks, unused_field

import 'dart:async';

import 'package:juragan99/data/otp.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/colors.dart';

// ignore: must_be_immutable
class OtpConfirmationRegistration extends StatefulWidget {
  final String title;
  final String subTitle;
  final String emailAddress;
  final String email;
  final String phone;
  final Future<String> Function(String) validateOtp;
  final void Function(BuildContext) routeCallback;
  Color topColor;
  Color bottomColor;
  bool _isGradientApplied;
  final Color titleColor;
  final Color themeColor;
  final Color keyboardBackgroundColor;
  final Widget icon;

  /// default [otpLength] is 4
  final int otpLength;

  OtpConfirmationRegistration({
    Key key,
    this.title = "Verification Code",
    this.subTitle = "please enter the OTP sent to your\n device",
    this.otpLength = 4,
    @required this.validateOtp,
    @required this.routeCallback,
    this.themeColor = Colors.black,
    this.titleColor = Colors.black,
    this.icon,
    this.keyboardBackgroundColor,
    this.emailAddress,
    this.email,
    this.phone,
  }) : super(key: key) {
    this._isGradientApplied = false;
  }

  OtpConfirmationRegistration.withGradientBackground({
    Key key,
    this.title = "Verification Code",
    this.subTitle = "please enter the OTP sent to your\n device",
    this.otpLength = 4,
    @required this.validateOtp,
    @required this.routeCallback,
    this.themeColor = Colors.white,
    this.titleColor = Colors.white,
    @required this.topColor,
    @required this.bottomColor,
    this.keyboardBackgroundColor,
    this.icon,
    this.emailAddress,
    this.email,
    this.phone,
  }) : super(key: key) {
    this._isGradientApplied = true;
  }

  @override
  _OtpConfirmationRegistrationState createState() =>
      new _OtpConfirmationRegistrationState();
}

class _OtpConfirmationRegistrationState
    extends State<OtpConfirmationRegistration>
    with SingleTickerProviderStateMixin {
  Size _screenSize;
  int _currentDigit;
  List<int> otpValues;
  bool showLoadingButton = false;

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    otpValues = List<int>.filled(widget.otpLength, null, growable: false);
    startTimer();
    super.initState();
  }

  _setOtp() async {
    await SetOtp.list(widget.email, widget.phone).then(
      (value) {
        if (value['status'] == 200) {
          Fluttertoast.showToast(
            msg: "Dikirim",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: Dimensions.defaultTextSize,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: MediaQuery.of(context).size.height,
          decoration: widget._isGradientApplied
              ? BoxDecoration(
                  gradient: LinearGradient(
                  colors: [widget.topColor, widget.bottomColor],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0, 1],
                  tileMode: TileMode.clamp,
                ))
              : BoxDecoration(color: Colors.white),
          width: _screenSize.width,
          child: _getInputPart,
        ),
      ),
    );
  }

  /// Return Title label
  get _getTitleText {
    return new Text(
      widget.title,
      style: TextStyle(
          color: Colors.black, fontSize: Dimensions.extraLargeTextSize * 1.5),
    );
  }

  /// Return subTitle label
  get _getSubtitleText {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.subTitle,
          style: CustomStyle.textStyle,
        ),
        Text(widget.emailAddress,
            style: TextStyle(
                color: Colors.black, fontSize: Dimensions.largeTextSize)),
      ],
    );
  }

  /// Return "OTP" input fields
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getOtpTextWidgetList(),
    );
  }

  /// Returns otp fields of length [widget.otpLength]
  List<Widget> getOtpTextWidgetList() {
    // ignore: deprecated_member_use
    List<Widget> optList = List();
    for (int i = 0; i < widget.otpLength; i++) {
      optList.add(_otpTextField(otpValues[i]));
    }
    return optList;
  }

  /// Returns Otp screen views
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.topLeft,
            child: BackWidget(
              title: "Kode Verifikasi",
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: _getSubtitleText,
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _getInputField,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kode tidak terkirim? ",
              style: CustomStyle.textStyle,
            ),
            GestureDetector(
              child: Text(
                ("$_start" == "0")
                    ? "Kirim ulang"
                    : "Tunggu " + "$_start" + " detik",
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: ("$_start" == "0")
                        ? CustomColor.primaryColor
                        : Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                if ("$_start" == "0") {
                  _setOtp();
                }
              },
            ),
          ],
        ),
        showLoadingButton
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: 0,
                height: 0,
              ),
        _getOtpKeyboard
      ],
    );
  }

  /// Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        color: widget.keyboardBackgroundColor,
        height: _screenSize.width - 100,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {
                      _setCurrentDigit(4);
                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {
                      _setCurrentDigit(5);
                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {
                      _setCurrentDigit(6);
                    }),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {
                      _setCurrentDigit(7);
                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {
                      _setCurrentDigit(8);
                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {
                      _setCurrentDigit(9);
                    }),
              ],
            ),
            Flexible(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: widget.themeColor,
                      ),
                      onPressed: () {
                        setState(() {
                          for (int i = widget.otpLength - 1; i >= 0; i--) {
                            if (otpValues[i] != null) {
                              otpValues[i] = null;
                              break;
                            }
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Returns "Otp text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: Dimensions.defaultTextSize,
          color: widget.titleColor,
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: widget.titleColor,
      ))),
    );
  }

  /// Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: Dimensions.defaultTextSize,
                color: widget.themeColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  /// sets number into text fields n performs
  ///  validation after last number is entered
  void _setCurrentDigit(int i) async {
    setState(() {
      _currentDigit = i;
      int currentField;
      for (currentField = 0; currentField < widget.otpLength; currentField++) {
        if (otpValues[currentField] == null) {
          otpValues[currentField] = _currentDigit;
          break;
        }
      }
      if (currentField == widget.otpLength - 1) {
        // showLoadingButton = true;
        String otp = otpValues.join();
        widget.validateOtp(otp).then((value) {
          // showLoadingButton = false;
        });
      }
    });
  }

  ///to clear otp when error occurs
  void clearOtp() {
    otpValues = List<int>.filled(widget.otpLength, null, growable: false);
    setState(() {});
  }

  ///to show error  message
  showToast(BuildContext context, String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: Dimensions.defaultTextSize,
    );
  }
}
