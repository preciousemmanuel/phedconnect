import 'package:flutter/material.dart';
import '../../models/customer.dart';
import 'package:intl/intl.dart';

class CustomerRowItem extends StatelessWidget {

    final Customer customer;
    CustomerRowItem({this.customer});
    final numberFormat = new NumberFormat("#,##0.00", "en_US");
    
    @override
    Widget build(BuildContext context) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Customer Name:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer.accountName.trim(),
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Account Number:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer.accountNo,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              height: 35.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Address:",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),  
                  
                  ),
                  Expanded(                                                               
                    child: Text(customer.address,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                      
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(  
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  mainAxisAlignment: MainAxisAlignment.center,                       
                  children: <Widget>[                          
                    Text("Last Payment Date: ${customer.lastPayDate}",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      )
                    ),
                    SizedBox(height: 5.0),
                   // "#"+numberFormat.format(history.amountPaid)
                    Text(
                      customer.amountPaid == null || customer.amountPaid.toString().trim().length == 0 ?
                       "" : "Amount Paid: ₦"+numberFormat.format(double.parse(customer.amountPaid)),
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      )
                    ),
                  ],
                ),
                Image(
                image: AssetImage("assets/images/headerLogo.jpg"),
                width: 60.0,
                height: 60.0,
                fit: BoxFit.contain,
                  )
              ],
            )
          ]
          
        );
    }
}