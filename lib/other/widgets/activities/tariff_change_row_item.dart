import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TariffChangeActivityRowItem extends StatelessWidget {

    final Map<String, dynamic> customer;
    TariffChangeActivityRowItem({this.customer});
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
                Text(customer["Surname"].trim(),
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
                Text("Parent Account Number",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer["ParentAccountNo"],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Phone Number:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer["PhoneNumber1"] == null ? "NA" : customer["PhoneNumber1"],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("House No:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer["HouseNo"] == null ? "NA" : customer["HouseNo"],
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
                  Text("Street Name:",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),  
                  
                  ),
                  Expanded(                                                               
                    child: Text(customer["StreetName"] == null ? "NA" : customer["StreetName"],
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
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Type Of Premises:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer["TypeOfPremises"] == null ? "NA" : customer["TypeOfPremises"],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Use Of Premises:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Text(customer["UseOfPremises"] == null ? "NA" : customer["UseOfPremises"],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  )
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 Row(
                  children: <Widget>[
                    Text(
                      "OLD TARIFF: ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),  
                    ),
                    SizedBox(width: 3,),
                    Text(customer["OldTariff"] == null ? "NA" : customer["OldTariff"],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),  
                    
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("PROPOSED TARIFF: ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),  
                    ),
                    SizedBox(width: 3,),
                    Text(customer["NewTariff"] == null ? "NA" : customer["NewTariff"],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),  
                    
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(  
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  mainAxisAlignment: MainAxisAlignment.center,                       
                  children: <Widget>[                          
                    /*Text("Date: TODAY",
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
                    */
                  ],
                ),
                /*Image(
                image: AssetImage("assets/images/headerLogo.jpg"),
                width: 60.0,
                height: 60.0,
                fit: BoxFit.contain,
                  )*/
              ],
            )
          ]
          
        );
    }
}