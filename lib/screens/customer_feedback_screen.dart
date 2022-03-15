import 'package:flutter/material.dart';
import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/custom_style.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/utils/colors.dart';
import 'package:juragan99/screens/dashboard_screen.dart';
import 'package:juragan99/widgets/my_rating.dart';
import 'package:juragan99/widgets/back_widget.dart';

class CustomerFeedbackScreen extends StatefulWidget {
  @override
  _CustomerFeedbackScreenState createState() => _CustomerFeedbackScreenState();
}

class _CustomerFeedbackScreenState extends State<CustomerFeedbackScreen> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(
                title: Strings.customerFeedback,
              ),
              SizedBox(
                height: Dimensions.heightSize * 2,
              ),
              bodyWidget(context),
              submitButtonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 100,
          bottom: 100,
          left: Dimensions.marginSize,
          right: Dimensions.marginSize),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.giveReview,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.punctuality,
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      MyRating(
                        rating: 5,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.servicesStaff,
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      MyRating(
                        rating: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.heightSize * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.busCleanLines,
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      MyRating(
                        rating: 5,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.comfort,
                        style: TextStyle(
                            fontSize: Dimensions.largeTextSize,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: Dimensions.heightSize * 0.5,
                      ),
                      MyRating(
                        rating: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.heightSize * 3,
            ),
            Text(
              Strings.customerComment,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: Dimensions.heightSize),
            TextFormField(
              style: CustomStyle.textStyle,
              controller: commentController,
              keyboardType: TextInputType.name,
              validator: (String value) {
                if (value.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: Strings.demoComment,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                filled: true,
                fillColor: Colors.transparent,
                hintStyle: CustomStyle.hintTextStyle,
                focusedBorder: CustomStyle.focusBorder,
                enabledBorder: CustomStyle.focusErrorBorder,
                focusedErrorBorder: CustomStyle.focusErrorBorder,
                errorBorder: CustomStyle.focusErrorBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  submitButtonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize * 3,
          right: Dimensions.marginSize * 3,
        ),
        child: GestureDetector(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
            child: Center(
              child: Text(
                Strings.submitFeedback.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardScreen(0)));
          },
        ),
      ),
    );
  }
}
