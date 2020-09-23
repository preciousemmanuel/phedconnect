import 'package:customer_app/scoped-model/bill.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class CardPaymentScreen extends StatefulWidget {
  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  var publicKey = 'pk_test_e5ed53a5a32dc1e27e55b0135b099cf47d998640';
  bool _isLoading=false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String _cardNumber = null;
   int _amount = null;
   String _cvv = null;
   int _month = null;
   int _year = null;
   String _customer_phone = null;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: publicKey);
  }

  _submitPayment(model) {
    if(!_formKey.currentState.validate()){
      return;
    }

    _formKey.currentState.save();

    Charge charge = Charge();
    charge.card = _getCardFromUI();

    //setState(() => _inProgress = true);

    
      // Set transaction params directly in app (note that these params
      // are only used if an access_code is not set. In debug mode,
      // setting them after setting an access code would throw an exception

      charge
        ..amount = _amount // In base currency
        ..email = 'customer@email.com'
        ..reference = _getReference()
        ..putCustomField('Charged From', 'Flutter SDK');
      _chargeCard(charge,model);
   
  }

  
  _chargeCard(Charge charge,BillModel model) async {
    setState(() {
      _isLoading=true;
    });
    final response = await PaystackPlugin.chargeCard(context, charge: charge);

    final reference = response.reference;
    print("response payment");
    print(response);

    // Checking if the transaction is successful
    if (response.status) {
      
     Map<String,dynamic> responseStatus =await model.notifyPayment(response.reference,_amount,_customer_phone);
      print(responseStatus);
       setState(() {
      _isLoading=false;
    });
      if(!responseStatus['status']){
         showDialog(context: context,builder:(BuildContext context){
       return  AlertDialog(title:Text("Error occured"),content:Text(responseStatus['message']),actions: [
           FlatButton(onPressed: (){
             Navigator.of(context).pop();
           }, child: Text("Ok"))
         ],);
       });

      }else{
        //navigate
      }
      
      //_verifyOnServer(reference);
      return;
    }

    // The transaction failed. Checking if we should verify the transaction
    if (response.verify) {
      //_verifyOnServer(reference);
    } else {
      setState(() {
      _isLoading=false;
    });
      //setState(() => _inProgress = false);
      //_updateStatus(reference, response.message);
    }
  }

  _buildSubmitButton(){
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child,MainModel model){
      return _isLoading?Center(child: CircularProgressIndicator()): 
      Container(
            margin: EdgeInsets.all(15.0),
            height: 50.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child:
      RaisedButton(
              onPressed: () {
                _submitPayment(model);
              },
              child: Text(
                "Pay",
                style: TextStyle(color: Colors.white, letterSpacing: 1.7),
              ),
              color: Theme.of(context).primaryColor,
    )
      );
    });
            
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _month,
      expiryYear: _year,
    );

    // Using Cascade notation (similar to Java's builder pattern)
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear)
//      ..name = 'Segun Chukwuma Adamu'
//      ..country = 'Nigeria'
//      ..addressLine1 = 'Ikeja, Lagos'
//      ..addressPostalCode = '100001';

    // Using optional parameters
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear,
//        name: 'Ismail Adebola Emeka',
//        addressCountry: 'Nigeria',
//        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            "Pay Bill Now",
            style: TextStyle(fontSize: 20.0, letterSpacing: 1.7),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.0),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 70.0,
            child: TextFormField(
              validator: (String value){
                if(value.isEmpty){
                  return "Amount must be entered";
                }
              },
              onSaved: (String value){
                _amount=int.tryParse(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                
                  labelText: "Amount",
                  filled: true,
                  
                  fillColor: Colors.grey[20],
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white))),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 70.0,
            child: TextFormField(
              validator: (String value){
                if(value.isEmpty){
                  return "Phone number must be entered";
                }
              },
              onSaved: (String value){
                _customer_phone=value;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: "Notification Phone Number",
                  filled: true,
                  fillColor: Colors.grey[20],
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white))),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 70.0,
            child: TextFormField(
               validator: (String value){
                if(value.isEmpty){
                  return "Enter Card Number";
                }
              },
              onSaved: (String value){
                _cardNumber=value;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Card Number",
                  filled: true,
                  fillColor: Colors.grey[20],
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.0, color: Colors.white))),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  margin: EdgeInsets.all(3.0),
                  height: 80.0,
                  child: TextFormField(
                     validator: (String value){
                if(value.isEmpty){
                  return "Expiry Month must be entered";
                }
              },
              maxLength: 2,
              onSaved: (String value){
                _month=int.tryParse(value);
              },
              keyboardType: TextInputType.phone,
              
                    decoration: InputDecoration(
                      
                        labelText: "Month",
                        filled: true,
                        fillColor: Colors.grey[20],
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white))),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(3.0),
                  height: 80.0,
                  child: TextFormField(
                     validator: (String value){
                if(value.isEmpty){
                  return "Expiry year must be entered";
                }
              },
              maxLength: 2,
              onSaved: (String value){
                _year=int.tryParse(value);
              },
              
              keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Year",
                        filled: true,
                        fillColor: Colors.grey[20],
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white))),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(3.0),
                  height: 80.0,
                  child: TextFormField(
                     validator: (String value){
                if(value.isEmpty){
                  return "CVV must be entered";
                }
              },
              onSaved: (String value){
                _cvv=value;
              },
              keyboardType: TextInputType.phone,
              maxLength: 3,
                    decoration: InputDecoration(
                        labelText: "CVV",
                        
                        filled: true,
                        fillColor: Colors.grey[20],
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white))),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 10.0),
          _buildSubmitButton(),
          
        ]),
      ),
    );
  }
}
