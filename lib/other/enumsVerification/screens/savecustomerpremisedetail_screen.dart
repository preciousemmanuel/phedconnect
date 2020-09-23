import '../../enumsVerification/controller/savecustomerdetails_controller.dart';
import '../../enumsVerification/screens/savecustomerdetail_screen.dart';
import '../../models/customer.dart';
import '../../screens/bill/constans.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SaveCustomerVerificationPremiseDetail extends StatefulWidget {
  SaveCustomerVerificationPremiseDetail();

  @override
  _SaveCustomerVerificationPremiseDetail createState() =>
      _SaveCustomerVerificationPremiseDetail();

  upDateBillCustomer(
      String feederid,
      String dTRID,
      String poleNo,
      String upriserNo,
      String streetID,
      String streetenteringfrom,
      String pin,
      String staffId,
      String noofCustomers,
      String premisesType,
      String lat,
      String lon,
      String streetAddress,
      String closestLandMark) {}
}

Customer c;

class _SaveCustomerVerificationPremiseDetail
    extends State<SaveCustomerVerificationPremiseDetail> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  String name;
  String enrolmentareaid;
  String pin;
  String clusterType;
  String customerType;
  String streetID;
  String streetenteringfrom;
  String noofCustomers;
  String premisesType;
  String buildingStatus;
  String vacantStatus;
  String streetNo;
  String buildingColour;
  String ext;
  String dTRID;
  String upriserNo;
  String poleNo;
  String poleType;
  String poleCondition;
  String connectionStatus;
  String acctNo;
  String nameOfCustomer;
  String typeOfBuilding;
  String tariffClass;
  String infraction;
  String nameOfLandLord;
  String closestLandMark;
  String streetAddress;
  String meterAccessible;
  String meterCondition;
  String separation;
  String landlordPhone;
  String landlordEmail;
  String customerPhone;
  String customerEmail;
  String stickerNo;
  String remark;
  String customerNo;
  String meterNoPostPaid;
  String saveDate;
  String billingType;
  String pPMNumber;
  String feederid;
  String lat, lon;
  String selectedArea;
  String selectedStreet;
  String feederName = '';
  String dTRName = '';

  SavePremisedetailController _savePremisedetailController =
      SavePremisedetailController();
  bool isSubmitting = false;

  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    //c = widget.customer;

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
                print("Saving premise");
                _formKey.currentState.save();
                _getGeoPoints();
              }

              //Navigator.pushNamed(context, '/modules');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              height: 45.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green),
              child: Text(
                "Add Customer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
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
          title: Text("Customer Verification"),
        ),
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
            controller: _scroll,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bgg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1.0), BlendMode.dstATop))),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    Text("Enter Customer Premise Details",
                        textAlign: TextAlign.start),
                    SizedBox(height: 20.0),
                    Focus(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                          initialValue: Constants.enrolmentareaid,
                          decoration: InputDecoration(
                              hintText: "Enrolment Area id",
                              labelText: "Enrolment Area id",
                              fillColor: Colors.white,
                              filled: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Enrolment area id';
                            } else if (enrolmentareaname == "null") {
                              return 'Please enter correct Enrolment area id';
                            }
                            return null;
                          },
                          onSaved: (value) => enrolmentareaid =
                              Constants.enrolmentareaid = value,
                          onChanged: (value) => enrolmentareaid = value,
                        ),
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            getENrollmentAreaName();
                          }
                        }),
                    SizedBox(height: 5.0),
                    Text("$enrolmentareaname", textAlign: TextAlign.start),
                    Focus(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                          initialValue: Constants.streetID,
                          decoration: InputDecoration(
                              hintText: "Street id",
                              labelText: "Street id",
                              fillColor: Colors.white,
                              filled: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Street id';
                            }
                            if (streetname == "null" || streetname == "") {
                              return "Street id is not correct";
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              Constants.streetID = streetID = value,
                          onChanged: (value) => streetID = value,
                        ),
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            getStreetName();
                          }
                        }),
                    Text("$streetname", textAlign: TextAlign.start),
                    SizedBox(
                      height: 10.0,
                    ),
                    Focus(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          focusNode: _focus,
                          initialValue: Constants.feederid,
                          decoration: InputDecoration(
                              hintText: "Feeder ID",
                              labelText: "Feeder ID",
                              fillColor: Colors.white,
                              filled: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter feederid';
                            }
                            if (feedername == "null" || feedername == "") {
                              return 'Please enter correct feederid';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              Constants.feederid = feederid = value,
                          onChanged: (value) => feederid = value,
                        ),
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            getFeederNamebyFeederid();
                          }
                        }),
                    Text("$feedername", textAlign: TextAlign.start),
                    SizedBox(
                      height: 5.0,
                    ),
                    Focus(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                          initialValue: Constants.dTRID,
                          decoration: InputDecoration(
                              hintText: "DTR ID",
                              labelText: "DTR ID",
                              fillColor: Colors.white,
                              filled: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter DTR id';
                            }
                            if (dtrname == "null" || dtrname == "") {
                              return 'Please enter correct feederid';
                            }
                            return null;
                          },
                          onSaved: (value) => Constants.dTRID = dTRID = value,
                          onChanged: (value) => dTRID = value,
                        ),
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            getDTRName();
                          }
                        }),
                    SizedBox(height: 5.0),
                    Text("$dtrname", textAlign: TextAlign.start),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Pole No",
                          labelText: "Pole No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter pole no';
                        }
                        return null;
                      },
                      onSaved: (value) => poleNo = value,
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
                          hintText: "Upriser No",
                          labelText: "Upriser No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter upriser no';
                        }
                        return null;
                      },
                      onSaved: (value) => upriserNo = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Focus(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Street Entering From",
                            hintText: "Street Entering From",
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Street Entering From';
                            }
                            return null;
                          },
                          onSaved: (value) => streetenteringfrom = value,
                          onChanged: (value) => streetenteringfrom = value,
                        ),
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            getStreetEnteringFromName();
                          }
                        }),
                    SizedBox(height: 5.0),
                    Text(streetenteringfromname, textAlign: TextAlign.start),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: "No of Customers",
                        hintText: "No of Customers",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enter No of Customers';
                        }
                        return null;
                      },
                      onSaved: (value) => noofCustomers = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Premise Type",
                          labelText: "Premise Type",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Premise Type';
                        }
                        return null;
                      },
                      onSaved: (value) => premisesType = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Street Address",
                          labelText: "Street Address",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter street address';
                        }
                        return null;
                      },
                      onSaved: (value) => streetAddress = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Clossest Landmark",
                          labelText: "Clossest Landmark",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter clossest landmark';
                        }
                        return null;
                      },
                      onSaved: (value) => closestLandMark = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSubmitButton()
                  ]),
                ),
              ),
            )));
  }

  String feedername = '';
  getFeederNamebyFeederid() async {
    feedername = await _savePremisedetailController.getFeederName(feederid);
    setState(() {
      feedername = "$feedername";
    });
  }

  String dtrname = '';

  getDTRName() async {
    if (feederid.length < 2 || feederid == null) {
      setState(() {
        dTRName = "Please enter feederid first";
      });
      return false;
    }
    dtrname =
        await _savePremisedetailController.getDTRNameName(dTRID, feederid);
    setState(() {
      dTRName = "$dtrname";
    });
  }

  String streetname = '';
  getStreetName() async {
    if (enrolmentareaid == null || enrolmentareaid.length < 2) {
      setState(() {
        streetname = "Please enter premise id first";
      });
      return false;
    }
    streetname = await _savePremisedetailController.getStreetName(
        streetID, enrolmentareaid);
    setState(() {
      streetname = "$streetname";
    });
  }
   String streetenteringfromname = '';
  getStreetEnteringFromName() async {
    
    streetenteringfromname = await _savePremisedetailController.getStreetName(
        streetenteringfrom, enrolmentareaid);
    setState(() {
      streetenteringfromname = "$streetenteringfromname";
    });
  }

  String enrolmentareaname = '';
  getENrollmentAreaName() async {
    enrolmentareaname = await _savePremisedetailController
        .getEnrolmentAreaName(enrolmentareaid);
    setState(() {
      enrolmentareaname = "$enrolmentareaname";
    });
  }

  Future<void> _savecustomerpremisedetails() async {
    //start loading spinner

    try {
      setState(() => isSubmitting = true);
      Map<String, dynamic> res;
      // make call to api login
      // authentication controller @lib/controller/auth
      res = await _savePremisedetailController.savecustomerpremisedetail(
          enrolmentareaid,
          feederid,
          dTRID,
          poleNo,
          upriserNo,
          streetID,
          streetenteringfrom,
          streetID + "/2",
          "2691200",
          noofCustomers,
          premisesType,
          lat,
          lon,
          streetAddress,
          closestLandMark);
      //show success snackbar
      setState(() => isSubmitting = false);
      if (res['isSuccessful']) {
        setState(() => isSubmitting = false);
        _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
        _redirect();
      }
      //show failed snackbar
      else {
        _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
        setState(() => isSubmitting = false);
      }
    } catch (e) {
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
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SaveCustomerVerificationDetail()));
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
        _savecustomerpremisedetails();
        print(latLng["latitude"]);
      } else {
        _showSnackBar(isSuccessSnack: false, msg: "Please on your location");
      }
    } catch (e) {
      setState(() => isSubmitting = false);
      print("dc_details: error fetching lat/lng");
      print("dc_details: " + e.toString());
    }

    Navigator.of(context).pop();
    print(lon);
    print(lat);
  }
}
