import 'package:customer_app/models/bill.dart';
import 'package:customer_app/scoped-model/bill.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'package:customer_app/screens/card_payment.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomerInfoScreen extends StatelessWidget {
  Color myHexColor = Color(0xff5e6da0);

  _buildCustomerNo(model) {
    Widget content;
    if (model.customerAccount.CONS_TYPE == "PREAPID") {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Customer No:",
            style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w500),
          ),
          Text(model.customerAccount.METER_NO),
        ],
      );
    } else {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Customer No:",
            style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w500),
          ),
          Text(model.customerAccount.CUSTOMER_NO),
        ],
      );
    }
    return content;
  }

  _buildForPospaid(model) {
    if(model.customerAccount.CONS_TYPE == "POSTPAID"){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Amount:",
                style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w500),
              ),
              Text('₦'+model.customerAccount.CURRENT_AMOUNT.toString()),
            ],
          ),
          SizedBox(height:10.0),
          Divider(color: Colors.grey, height: 1.0),
 Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Bill:",
                style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w500),
              ),
              Text('₦'+model.customerAccount.TOTAL_BILL.toString()),
            ],
          ),
          Divider(color: Colors.grey, height: 1.0),
        ],
      );
    }
    return Divider(color: Colors.grey, height: 1.0);
  }

  _buildCustomerContent() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView(children: [
        Container(
          height: 250.0,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 6.0)
              ]),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildCustomerNo(model),
              ),
              // SizedBox(height:10.0),

              SizedBox(height: 10.0),
              Divider(color: Colors.grey, height: 1.0),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Oustanding:",
                      style: TextStyle(
                          letterSpacing: 1.2, fontWeight: FontWeight.w500),
                    ),
                    Text('₦' + model.customerAccount.ARREAR.toString()),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.grey, height: 1.0),
              _buildForPospaid(model),

              

              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Type:",
                      style: TextStyle(
                          letterSpacing: 1.2, fontWeight: FontWeight.w500),
                    ),
                    Text(model.customerAccount.CONS_TYPE),
                  ],
                ),
              ),
              
            ],
          ),
        ),
        Container(
          height: 240.0,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 6.0)
              ]),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                                              child: Text(
                          "Name:",
                          style: TextStyle(
                              letterSpacing: 1.2, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(child: Text(model.customerAccount.CONS_NAME,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.grey, height: 1.0),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BSC:",
                      style: TextStyle(
                          letterSpacing: 1.2, fontWeight: FontWeight.w500),
                    ),
                    Text(model.customerAccount.BSC_NAME),
                  ],
                ),
              ),
              Divider(color: Colors.grey, height: 1.0),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone No:",
                      style: TextStyle(
                          letterSpacing: 1.2, fontWeight: FontWeight.w500),
                    ),
                    Text(model.customerAccount.CUSTOMER_NO),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.grey, height: 1.0),
              SizedBox(height: 10.0),
              Text(
                "Address.",
                style:
                    TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.0),
              Expanded(child: Text(model.customerAccount.ADDRESS,overflow: TextOverflow.ellipsis,)),
            ],
          ),
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor,
      body: Column(children: [
        Stack(
          children: [
            Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    myHexColor.withOpacity(0.3),
                    myHexColor.withOpacity(0.5),
                    myHexColor.withOpacity(0.6),
                    myHexColor.withOpacity(0.2)
                  ])),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30.0,
                        ),
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Customer Details",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        Expanded(
          child: _buildCustomerContent(),
        ),
        SizedBox(height: 70.0)
      ]),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: FlatButton(
            child: Text(
              "NEXT",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 2.0, fontSize: 18.0),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CardPaymentScreen())),
          ),
        ),
      ),
    );
  }
}
