import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../controllers/billDistribution/billcustomer_controller.dart';
import '../../../data/authenticated_staff.dart';
import '../../../models/customer.dart';
import '../../../services/location_service.dart';
import '../../../utilities/alert_dialog.dart';

import '../constans.dart';

class BillNewCustomer extends StatefulWidget {
  final Customer customer;
  BillNewCustomer(this.customer);

  @override
  _BillNewCustomer createState() => _BillNewCustomer();
}

Customer c;

class _BillNewCustomer extends State<BillNewCustomer> {
  LocationService latlon = new LocationService();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  String bookcode,
      email,
      phoneno,
      dtrcode,
      streetname,
      lat,
      lon,
      customername,
      landmark,
      streetno;
  int poleno, houseHoldCountCommercial, houseHoldCountResidential;
  BillCustomerController sc = BillCustomerController();
  bool isSubmitting = false;
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    print("streetsid " + Constants.streetCode);
    c = widget.customer;

    super.initState();
  }

  //submit button widget
  Widget _buildSubmitButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a Snackbar.
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
          print("New customer add");
          _formKey.currentState.save();
          _getGeoPoints();
        }

        //Navigator.pushNamed(context, '/modules');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60.0),
        alignment: Alignment.center,
        height: 45.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.green),
        child: Text(
          "Save",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _scroll = new ScrollController();
    _focus.addListener(() {
      _scroll.jumpTo(-1.0);
    });
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("New Customer"),
        ),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
            controller: _scroll,
            child: Container(
               decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
              )
            ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    Text("Complete the following details",
                        textAlign: TextAlign.start),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Customer Name",
                          hintText: "Customer Name",
                          fillColor: Colors.white,
                          filled: true),
                      // initialValue: c.accountName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                      onSaved: (value) => customername = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Book Code",
                          hintText: "Book Code",
                          fillColor: Colors.white,
                          filled: true),
                      // initialValue: c.accountName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter book code';
                        }
                        return null;
                      },
                      onSaved: (value) => bookcode = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone No",
                          hintText: "Phone No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter phone no';
                        }
                        return null;
                      },
                      onSaved: (value) => phoneno = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: "House Hold Count - Commercial",
                        hintText: "House Hold Count - Commercial",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'House Hold Count - Commercial';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          houseHoldCountCommercial = int.parse(value),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: "House Hold Count - Residential",
                        hintText: "House Hold Count - Residential",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'House Hold Count - Residential';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          houseHoldCountResidential = int.parse(value),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Pole No",
                          hintText: "Pole No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter pole no';
                        }
                        return null;
                      },
                      onSaved: (value) => poleno = int.parse(value),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Dtr Code",
                          hintText: "Dtr Code",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter DTR Code';
                        }
                        return null;
                      },
                      onSaved: (value) => dtrcode = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Street No",
                            hintText: "Street No",
                            fillColor: Colors.white,
                            filled: true),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter street no';
                          }
                          return null;
                        },
                        onSaved: (value) => streetno = value),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          labelText: "Address",
                          hintText: "Address",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                      onSaved: (value) => streetname = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Land mark",
                          hintText: "Land mark",
                          fillColor: Colors.white,
                          filled: true),
                      // initialValue: c.accountName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter landmark';
                        }
                        return null;
                      },
                      onSaved: (value) => landmark = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildSubmitButton()
                  ]),
                ),
              ),
            )));
  }

  Future<void> _addBillNewCustomer() async {
    //start loading spinner
    setState(() => isSubmitting = true);
    Map<String, dynamic> res;
    // make call to api login
    // authentication controller @lib/controller/auth
    // await _getGeoPoints();
    res = await sc.addBillNewCustomer(
        bookcode,
        email,
        phoneno,
        poleno.toString(),
        dtrcode,
        streetname,
        streetno.toString(),
        "c.accountNo",
        authenticatedStaff.staffId,
        lat.toString(),
        lon.toString(),
        landmark,
        customername,
        Constants.streetCode,
        houseHoldCountCommercial.toString(),
        houseHoldCountResidential.toString());
    print("resultd :" + res.toString());
    //show success snackbar
    if (res['isSuccessful']) {
      setState(() => isSubmitting = false);
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
      _redirect();
    }
    //show failed snackbar
    else {
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: "Error occured");
      setState(() => isSubmitting = false);
    }
  }

  //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg}) {
    //create snackbar
    var snackBar = SnackBar(
      backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    //show snackbar
    scaffoldKey.currentState.showSnackBar(snackBar);
    if (isSuccessSnack) {
      _formKey.currentState.reset();
    }
  }

  //redirect on successful login
  void _redirect() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Future _getGeoPoints() async {
    showAlertDialog(
        context: context,
        isLoading: true,
        loadingMsg: "Fetching cordinates...");

    try {
      var latLng = await LocationService.checkLocationPermissionStatus(context);
      print(latLng.toString());

      if (latLng["isServiceEnabled"] &&
          latLng["latitude"] != null &&
          latLng["longitude"] != null) {
        lat = latLng["latitude"];
        lon = latLng["longitude"];

        print(latLng["latitude"]);
        _addBillNewCustomer();
      } else {
        _showSnackBar(isSuccessSnack: false, msg: "Please on your location");
      }
    } catch (e) {
      print("dc_details: error fetching lat/lng");
      print("dc_details: " + e.toString());
    }

    Navigator.of(context).pop();
    print(lon);
    print(lat);
  }
}
