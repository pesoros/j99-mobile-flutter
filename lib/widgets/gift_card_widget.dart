import 'package:juragan99/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:ticket_card/ticket_card.dart';

class GiftCardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String route;
  final double rating;
  final String environment;
  final String journeyStart;
  final double price;

  GiftCardWidget(
      {this.image,
      this.name,
      this.route,
      this.rating,
      this.environment,
      this.journeyStart,
      this.price});

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      decoration: TicketDecoration(
        shadow: [TicketShadow(color: Colors.grey, elevation: 6)],
        border: TicketBorder(
            color: Colors.indigo, width: 0.1, style: TicketBorderStyle.dotted),
      ),
      lineFromTop: 110,
      lineColor: Colors.transparent,
      lineRadius: 15,
      child: Container(
        height: 250,
        //width: 200,
        color: Color(0xFFA813C4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ticketTopPart(),
              _ticketBottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  _ticketTopPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 60,
          width: 60,
        ),
      ],
    );
  }

  _ticketBottomPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get \$${price.toString()}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.extraLargeTextSize * 1.3),
            ),
            Text(
              'When you spend \$25',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MHGVACV 789',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.heightSize * 0.5,
            ),
            Text(
              'Free Vouchar for you',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
