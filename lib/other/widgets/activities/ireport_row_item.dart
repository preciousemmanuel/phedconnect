import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IreportActivityRowItem extends StatelessWidget {

    final Map<String, dynamic> customer;
    IreportActivityRowItem({this.customer});
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
                Text("Report Category:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Container(
                  width: 200,
                  child: Text(customer["ReportCategoryName"] == null ? "NA" : customer["ReportCategoryName"],
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,

                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("ReportSubCategory:",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),  
                
                ),
                Container(
                  width: 180,
                  child: Text(customer["ReportSubCategoryName"] == null ? "NA" : customer["ReportSubCategoryName"],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey
                    ),
                    overflow: TextOverflow.visible
                  ),
                  
                ),
              ],
            ),
            SizedBox(height: 8.0),
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
                Text(customer["CustomerName"] == null ? "NA" : customer["CustomerName"],
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
                Text(customer["PhoneNumber"] == null ? "NA" : customer["PhoneNumber"],
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
                    child: Text(customer["Address"] == null ? "NA" : customer["Address"],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Column(  
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
                */
                Text("See details", style: TextStyle(color: Colors.blue),),
                SizedBox(width: 5.0),
                Icon(Icons.info_outline, color: Colors.red, size: 24.0,)
              ],
            )
          ]
          
        );
    }
}