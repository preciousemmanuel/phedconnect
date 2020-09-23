import '../../enumsVerification/controller/savecustomerdetails_controller.dart';
import '../../enumsVerification/screens/savecustomerpremisedetail_screen.dart';
import '../../models/customer.dart';
import '../../screens/bill/constans.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SaveCustomerVerificationDetail extends StatefulWidget {
  SaveCustomerVerificationDetail();

  @override
  _SaveCustomerVerificationDetail createState() =>
      _SaveCustomerVerificationDetail();

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

class _SaveCustomerVerificationDetail
    extends State<SaveCustomerVerificationDetail> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  String name;
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
  String lat, lon, flatno, tarriffclass,isseperation;
  List<String> _meterType = ['', 'PPM', 'Analog'];
  List tarriffclasslist = List();
  List<String> meterConditionlist = ['', 'Good', 'Bad', 'Not Accessible'];
  List<String> typeOfBuildinglist = ['', 'Bungalow', 'Duplex', 'Semi-detached'];
  List<String> vacantStatusList = [
    '',
    'Abandunt Property',
    'Under Construction',
    'Occupied'
  ];
  List<String> _accountType = [
    '',
    'Pre-paid',
    'Post-paid',
    'Burnt Meter Fee',
    'No Account no',
    'No Evidence of payment'
  ]; // Option 2
  List<String> _connectionType = [
    '',
    'Connected',
    'Not Connected',
    'On Disconnection'
  ];
  List<String> _isseperationchoice = [
    '',
    'No',
    'Yes'
  ];
  String _selectedMeterType;
  String _selectedAccountType;
  String _selectedConnectionType; // Option 2

  SavePremisedetailController sc = SavePremisedetailController();
  bool isSubmitting = false;
  ScrollController _scroll;
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    //c = widget.customer;
    fetchTariff();
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
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                  alignment: Alignment.center,
                  height: 45.0,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.greenAccent),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  child: InkWell(
                    child: Text(
                      "Finish",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
                        print("Saving customer");
                        _formKey.currentState.save();
                        _getGeoPoints(2);
                      }
                    },
                  ),
                ),
                AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                  alignment: Alignment.center,
                  height: 45.0,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blueAccent),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  child: InkWell(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
                        print("Saving customer");
                        _formKey.currentState.save();
                        _getGeoPoints(1);
                      }
                    },
                  ),
                ),
                AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                  alignment: Alignment.center,
                  height: 45.0,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.yellowAccent),
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  child: InkWell(
                    child: Text(
                      "Call Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      _formKey.currentState.save();
                      _getGeoPoints(3);
                    },
                  ),
                ),
              ]);
  }

  List<DropdownMenuItem> dropdownItemsTariff = [
    DropdownMenuItem(
        child: Text(
          "Select Tariff Class**",
          style: TextStyle(color: Colors.red),
        ),
        value: ""),
  ];
  fetchTariff() async {
    //isLoading = true;
    print("searching...");
    Map<String, dynamic> res = await sc.getalltariff();

    if (res != null && res["status"] == "SUCCESS") {
      tarriffclasslist = res["data"];

      if (dropdownItemsTariff.length > 1) {
        setState(() {
          dropdownItemsTariff.removeRange(1, dropdownItemsTariff.length);
        });
      }

      tarriffclasslist.forEach((element) {
        print("element  " + element["TariffClass"]);
        dropdownItemsTariff.add(DropdownMenuItem(
            child: Text(element["TariffClass"]
                //style: TextStyle(color: Colors.red),
                ),
            value: "${element["TariffClass"]}"));
      });
    } else {
      _showSnackBar(isSuccessSnack: false, msg: res["message"]);
    }
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
          title: Text("Customer Verification "),
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
                    Text("Enter Customer Details ",
                        textAlign: TextAlign.start),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Customer Full Name",
                          labelText: "Customer Full Name",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Customer Name';
                        }
                        return null;
                      },
                      onSaved: (value) => nameOfCustomer = value,
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
                          hintText: "Customer Phone",
                          labelText: "Customer Phone",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Customer Phone';
                        }
                        return null;
                      },
                      onSaved: (value) => customerPhone = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Customer Email",
                          labelText: "Customer Email",
                          fillColor: Colors.white,
                          filled: true),
                      onSaved: (value) => customerEmail = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Flat No",
                          labelText: "Flat No",
                          fillColor: Colors.white,
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter flat no';
                        }
                        return null;
                      },
                      onSaved: (value) => ext = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Connection status'),
                              value: _selectedConnectionType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedConnectionType = newValue;
                                });
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select connection status';
                                }
                                return null;
                              },
                              items: _connectionType.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Please select account type'),
                              value: _selectedAccountType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedAccountType = newValue;
                                });
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select account type';
                                }
                                return null;
                              },
                              items: _accountType.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          validateaccountno();
                        }
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Account No",
                          hintText: "Account No",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter account no';
                          } else if (accountname == "null"||accountname == "") {
                            return 'Account no is invalid';
                          }
                          return null;
                        },
                        onSaved: (value) => acctNo = value,
                        onChanged: (value) => acctNo = value,
                      ),
                    ),
                    Text(accountname, textAlign: TextAlign.start),
                    SizedBox(
                      height: 10.0,
                    ),
                     SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Is Seperation'),
                              value: isseperation,
                              onChanged: (newValue) {
                                setState(() {
                                  isseperation = newValue;
                                });
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'State if it is seperation';
                                }
                                return null;
                              },
                              items: _isseperationchoice.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButton(
                              hint: Text('Please meter type'),
                              value: _selectedMeterType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedMeterType = newValue;
                                });
                              },
                              items: _meterType.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: "Meter No",
                        hintText: "Meter No",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (value) => meterNoPostPaid = value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Select tarriff class'),
                              value: tariffClass,
                              onChanged: (newValue) {
                                setState(() {
                                  tariffClass = newValue;
                                });
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select a tariff class';
                                }
                                return null;
                              },
                              items: dropdownItemsTariff,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Select vacant status'),
                              value: vacantStatus,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              onChanged: (newValue) {
                                setState(() {
                                  vacantStatus = newValue;
                                });
                              },
                              validator: (String value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select vaccant status';
                                }
                                return null;
                              },
                              items: vacantStatusList.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Select meter condition'),
                              value: meterCondition,
                              onChanged: (newValue) {
                                setState(() {
                                  meterCondition = newValue;
                                });
                              },
                              validator: (String value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select meter condition';
                                }
                                return null;
                              },
                              items: meterConditionlist.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                      color: Colors.black12)
                                ]),
                            child: DropdownButtonFormField(
                              hint: Text('Please select building type'),
                              value: typeOfBuilding,
                              onChanged: (newValue) {
                                setState(() {
                                  typeOfBuilding = newValue;
                                });
                              },
                              validator: (String value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select building type';
                                }
                                return null;
                              },
                              items: typeOfBuildinglist.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Remarks",
                          labelText: "Remarks",
                          fillColor: Colors.white,
                          filled: true),
                      onSaved: (value) => remark = value,
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

  Future<void> _savecustomerdetails(int action) async {
    //start loading spinner
    setState(() => isSubmitting = true);
    Map<String, dynamic> res;
    // make call to api login
    // authentication controller @lib/controller/auth

    res = await sc.savecustomerdetail(isseperation,
        Constants.premiseid,
        nameOfCustomer,
        customerPhone,
        customerEmail,
        ext,
        _selectedConnectionType,
        _selectedMeterType,
        acctNo,
        meterNoPostPaid,
        tariffClass,
        vacantStatus,
        meterCondition,
        typeOfBuilding,
        remark);
    //show success snackbar
    setState(() => isSubmitting = false);
    if (res['isSuccessful']) {
      setState(() => isSubmitting = false);
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
      _redirect(action);
    }
    //show failed snackbar
    else {
      _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
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
  void _redirect(int action) {
    if (action == 1) {
      _formKey.currentState.reset();
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SaveCustomerVerificationDetail()));
      
    } else if (action == 2) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SaveCustomerVerificationPremiseDetail()));
      });
    }
  }

  Future _getGeoPoints(int action) async {
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
        if (action == 1) {
          _savecustomerdetails(1);
        } else if (action == 2) {
          _savecustomerdetails(2);
        } else if (action == 3) {}
        print(latLng["latitude"]);
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

  String accountname = '';
  validateaccountno() async {
    accountname = await sc.getAccountNo(acctNo);
    setState(() {
      accountname = accountname;
    });
  }
}
