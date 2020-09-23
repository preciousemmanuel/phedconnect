import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../controllers/billDistribution/billcustomer_controller.dart';
import '../../../data/authenticated_staff.dart';
import '../../../models/customer.dart';
import '../../../screens/bill/constans.dart';
import '../../../services/location_service.dart';
import '../../../utilities/alert_dialog.dart';

class UpdateBillCustomerDetail extends StatefulWidget {
  final Customer customer;
  UpdateBillCustomerDetail(this.customer);

  @override
  _UpdateBillCustomerDetail createState() => _UpdateBillCustomerDetail();
}

Customer c;

class _UpdateBillCustomerDetail extends State<UpdateBillCustomerDetail> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  String streetno,
      bookcode,
      email,
      phoneno,
      dtrcode,
      poleno,
      streetname,
      lat,
      lon,
      houseHoldCountCommercial,
      houseHoldCountResidential;

  BillCustomerController sc = BillCustomerController();
  bool isSubmitting = false;
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    c = widget.customer;

    super.initState();
  }

  //submit button widget
  Widget _buildSubmitButton() {
    return isSubmitting
        ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
            height: 45,
            width: 45,
          )
        : GestureDetector(
            onTap: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
                print("New street add");
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
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green),
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
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
          title: Text("Update: " + c.accountName),
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
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
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: InputDecoration(
                          hintText: "Phone No",
                          labelText: "Phone No",
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
                      decoration: InputDecoration(
                          hintText: "Pole No",
                          labelText: "Pole No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          //return 'Please enter pole no';
                        }
                        return null;
                      },
                      onSaved: (value) => poleno = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: Constants.dtrid,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "DTR ID",
                          hintText: "DTR ID",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter dtr code ';
                        }
                        return null;
                      },
                      onSaved: (value) => dtrcode = value,
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
                          return 'No value entered. Please enter 0 if non exist';
                        }
                        return null;
                      },
                      onSaved: (value) => houseHoldCountCommercial = value,
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
                          return 'No value entered. Please enter 0 if non exist';
                        }
                        return null;
                      },
                      onSaved: (value) => houseHoldCountResidential = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Street No",
                          labelText: "Street No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter street no';
                        }
                        return null;
                      },
                      onSaved: (value) => streetno = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Street Name",
                          labelText: "Street Name",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Street name';
                        }
                        return null;
                      },
                      onSaved: (value) => streetname = value,
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

  Future<void> _updateCustomer() async {
    //start loading spinner
  
    Map<String, dynamic> res;
    // make call to api login
    // authentication controller @lib/controller/auth

    res = await sc.upDateBillCustomer(
        email,
        phoneno,
        poleno,
        dtrcode,
        streetname,
        streetno,
        c.accountNo,
        authenticatedStaff.staffId,
        houseHoldCountCommercial,
        houseHoldCountResidential,
        lat,
        lon);
    //show success snackbar
    if (res['isSuccessful']) {
       Navigator.of(context).pop();
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
      _redirect();
    }
    //show failed snackbar
    else {
       Navigator.of(context).pop();
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
      //return;
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
  }

  //redirect on successful login
  void _redirect() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  Future _getGeoPoints() async {
    showAlertDialog(
        context: context,
        isLoading: true,
        loadingMsg: "Updating customer details...");
       
    //setState(() => isSubmitting = true);
     
    try {
      var latLng = await LocationService.checkLocationPermissionStatus(context);
      print(latLng.toString());

      if (latLng["isServiceEnabled"] &&
          latLng["latitude"] != null &&
          latLng["longitude"] != null) {
        lat = latLng["latitude"];
        lon = latLng["longitude"];
        _updateCustomer();
        print(latLng["latitude"]);
      } else {
          _showSnackBar(isSuccessSnack: false, msg: "Location service is OFF. Please TURN ON your location service");
          Navigator.of(context).pop();
      }
    } catch (e) {
        print("dc_details: error fetching lat/lng");
        print("dc_details: " + e.toString());
        _showSnackBar(isSuccessSnack: false, msg: "Couldn't fetch coordinates. Please try again");
        Navigator.of(context).pop();
    }
    print(lon);
    print(lat);
  }
}
