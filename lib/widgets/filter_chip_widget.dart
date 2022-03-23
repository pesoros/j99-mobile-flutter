// ignore_for_file: must_be_immutable

import 'package:juragan99/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  bool chipFunc;

  FilterChipWidget({Key key, this.chipName, this.chipFunc}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: CustomColor.primaryColor,
        fontSize: Dimensions.defaultTextSize,
      ),
      selected: (widget.chipFunc == null) ? _isSelected : widget.chipFunc,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
      onSelected: (isSelected) {
        setState(() {
          widget.chipFunc = isSelected;
        });
      },
      selectedColor: CustomColor.primaryColor.withOpacity(0.2),
      pressElevation: 10,
    );
  }
}
