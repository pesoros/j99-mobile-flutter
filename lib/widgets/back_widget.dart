// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/colors.dart';

class BackWidget extends StatefulWidget {
  final String title;
  final Color color;

  const BackWidget({Key key, this.title, this.color}) : super(key: key);

  @override
  _BackWidgetState createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
          child: Stack(
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: widget.color,
                    size: Dimensions.defaultTextSize,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: widget.color,
                            fontSize: Dimensions.smallTextSize,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
