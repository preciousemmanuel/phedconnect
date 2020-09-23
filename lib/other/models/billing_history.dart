import 'package:flutter/material.dart';

class BillingHistory{
   
    String billedAmount;
    String billedDate;
   
    BillingHistory(
      {
          @required this.billedAmount,
          @required this.billedDate,
      }
    );

    factory BillingHistory.createBillingHistory(Map<String, dynamic> json){
      
        return BillingHistory(
          billedAmount: json["BilledQty"],
          billedDate: json["BillingDate"],
        
        );
    }

}