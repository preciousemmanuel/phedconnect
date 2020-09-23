import 'package:flutter/material.dart';

class CustomerInfoText extends StatelessWidget {

  final String displayTitle;
  final String displayValue;

  CustomerInfoText(this.displayTitle, this.displayValue);

  @override
  Widget build(BuildContext context) {
    return Column(
     children: <Widget>[
        Row(
          children: <Widget>[
              Text(
                displayTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(width: 5.0),
              Text(displayValue,
              style: TextStyle(
                fontSize: 12.0
              ),)
          ],
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}