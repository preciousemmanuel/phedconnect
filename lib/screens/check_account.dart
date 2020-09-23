import 'package:customer_app/scoped-model/main.dart';
import 'package:customer_app/screens/customer_info.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/bill.dart';

class CheckAccountScreen extends StatefulWidget {
  @override
  _CheckAccountScreenState createState() => _CheckAccountScreenState();
}

class _CheckAccountScreenState extends State<CheckAccountScreen> {
  Color myHexColor = Color(0xff5e6da0);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {
    "CustomerNumber": "",
    "Mobile_Number": "",
    "mailid": "",
    "CustomerType": "PREPAID"
  };

  void _handleRadioValueChanged(value) {
    setState(() => _formData['CustomerType'] = value);
  }

  _buildRadioButtons(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.white,
          value: "PREPAID",
          groupValue: _formData["CustomerType"],
          onChanged: _handleRadioValueChanged,
        ),
        Text(
          "Prepaid",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 50.0),
        Radio(
            activeColor: Colors.white,
            value: "POSTPAID",
            groupValue: _formData["CustomerType"],
            onChanged: _handleRadioValueChanged),
        Text("Postpaid", style: TextStyle(color: Colors.white))
      ],
    );
  }

  _buildTextField(BuildContext context) {
    return Container(
      height: 50.0,
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'This field must not be empty';
          }
        },
        onSaved: (String value) {
          _formData["CustomerNumber"] = value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical:15.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    width: 0.8, color: Theme.of(context).primaryColor)),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              color: myHexColor,
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: myHexColor,
                ),
                onPressed: () {
                  setState(() {
                   _formKey.currentState.reset();
                  });
                }),
            hintText: "Meter / Account Number",
            hintStyle: TextStyle(color: myHexColor, fontFamily: "QuickSand")),
      ),
    );
  }

  _buildPhoneField(BuildContext context) {
    return Container(
      height: 50.0,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        validator: (String value) {
          if (value.isEmpty) {
            return 'This field must not be empty';
          }
        },
        onSaved: (String value) {
          _formData["Mobile_Number"] = value;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            // labelText: "Phone Number",
            // labelStyle: TextStyle(color:Colors.grey[10],fontSize:18.0,letterSpacing: 1.1),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    width: 0.8, color: Theme.of(context).primaryColor)),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.phone,
              color: myHexColor,
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: myHexColor,
                ),
                onPressed: () {}),
            hintText: "Phone Number",
            hintStyle: TextStyle(color: myHexColor, fontFamily: "QuickSand")),
      ),
    );
  }

  _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.getLoading
          ? Center(child: CircularProgressIndicator())
          : RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _formKey.currentState.save();

                model
                    .checkAccount(
                        _formData["CustomerNumber"],
                        _formData["CustomerType"]
                        )
                    .then((Map<String,dynamic> responseStatus) {
                  if (!responseStatus['status']) {
                    //customer not found
                    final snackBar = SnackBar(
                      content: Text(responseStatus['message']),
                    );

                    // Find the Scaffold in the widget tree and use
                    // it to show a SnackBar.
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.pushNamed(context, '/customer_info');

                  }
                });

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => CustomerInfoScreen()),);
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, letterSpacing: 1.0),
              ),
            );
    });
  }

  _buildEmailField(BuildContext context) {
    return Container(
      height: 50.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'This field must not be empty';
          }
        },
        onSaved: (String value) {
          _formData["mailid"] = value;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    width: 0.8, color: Theme.of(context).primaryColor)),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              Icons.email,
              color: myHexColor,
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: myHexColor,
                ),
                onPressed: () {}),
            hintText: "Email Address",
            hintStyle: TextStyle(color: myHexColor, fontFamily: "QuickSand")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              //alignment: Alignment.center,
              children: [
                Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
                Container(
                  height: 250.0,
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
                            "Bills Payment",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 170.0),
                    //padding: EdgeInsets.only(left: 20.0, right: 20.0,top:150.0),

                    child: Column(
                      children: [
                        _buildRadioButtons(context),
                        SizedBox(height: 20.0),
                        _buildTextField(context),
                        
                        
                        SizedBox(height: 85.0),
                        _buildSubmitButton()
                      ],
                    )),

                ///SizedBox(height:100.0),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
