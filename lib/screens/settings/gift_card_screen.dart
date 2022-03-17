import 'package:juragan99/utils/dimensions.dart';
import 'package:juragan99/utils/strings.dart';
import 'package:juragan99/widgets/back_widget.dart';
import 'package:juragan99/widgets/gift_card_widget.dart';
import 'package:flutter/material.dart';

class GiftCardScreen extends StatefulWidget {
  @override
  _GiftCardScreenState createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackWidget(
              title: Strings.giftCard,
            ),
            bodyWidget(context),
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: GiftCardWidget(
                image: 'assets/images/giftbox.png',
                name: 'Green Wheel',
                route: 'Dhaka to Bogura',
                rating: 5,
                environment: 'AC',
                journeyStart: 'Gabtoli Bus Stand (8:30)',
                price: 95,
              ),
            );
          },
        ),
      ),
    );
  }
}
