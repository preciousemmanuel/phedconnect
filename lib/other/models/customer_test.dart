/*
* This class is the model for a customer(currently for list of customers due for disconnection)
*  Note: To extend it for other customers
*/

/*to be deleted*/

import 'package:flutter/material.dart';

class CustomerTest{

    int serialNo;
    String accountName;
    String accountNo;
    String address;
    String lastPayDate;
    String amountPaid;
   

    CustomerTest(
      {
        @required this.serialNo,
        @required this.accountName,
        @required this.accountNo,
        @required this.address,
        @required this.lastPayDate,
        @required this.amountPaid,   
      }
    );

    
}
