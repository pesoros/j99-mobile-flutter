import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';

class HeaderWidget extends StatefulWidget {
  final String title;

  const HeaderWidget({Key key, this.title}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
