import 'package:flutter/material.dart';

class PaymentHistory{
   
    String paymentId;
    double amountPaid;
    String datePaid;
    String paymentDescription;


    PaymentHistory(
      {
          @required this.amountPaid,
          @required this.paymentId,
          @required this.datePaid,
          @required this.paymentDescription
      }
    );

    factory PaymentHistory.createPaymentHistory(Map<String, dynamic> json){
      
        return PaymentHistory(
          paymentId: json["PaymentID"],
          amountPaid: json["AmountPaid"],
          datePaid: json["DatePaid"],
          paymentDescription: json["PaymentDescription"]

        );
    }

}