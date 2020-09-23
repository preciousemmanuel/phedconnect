import 'package:flutter/material.dart';
import '../../../controllers/billDistribution/update_dtr_controller.dart';
import '../../../controllers/utility/feeder_11.dart';
import '../../../controllers/utility/feeder_33.dart';
import '../../../data/authenticated_staff.dart';
import '../../../models/customer.dart';
import '../../../services/location_service.dart';
import '../../../utilities/alert_dialog.dart';
import '../../../widgets/submit_btn.dart';

class NonMDBDUpdateDTRScreen extends StatefulWidget {
  final Customer customer;
  NonMDBDUpdateDTRScreen(this.customer);

  @override
  _NonMDBDUpdateDTRScreen createState() => _NonMDBDUpdateDTRScreen(customer);
}

class _NonMDBDUpdateDTRScreen extends State<NonMDBDUpdateDTRScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Feeder33Controller f33c = Feeder33Controller();
  final Feeder11Controller f11c = Feeder11Controller();
  final UpdateDTRController uDTRc = UpdateDTRController();
  final dTRnamecontroller = TextEditingController(text: dtrname);

  String feeder33;
  Customer c;
  static String dtrname;
  String feeder11;
  String feeder33Id;
  String feeder11id;
  String feeder33Name;
  String dtrName;
  String latitude;
  String longitude;
  String capacity;
  String dtrexec;
  bool isLoading = true;
  List feeder33List = List();

 
  List<DropdownMenuItem> dropdownItemsFeeder33 = List<DropdownMenuItem>();
  List<DropdownMenuItem> dropdownItemsFeeder11 = List<DropdownMenuItem>();


  _NonMDBDUpdateDTRScreen(this.c);
  
  @override
  void initState() {
    dtrname = c.dtrName;
    feeder11 = widget.customer.feeder11name;
    feeder11id = widget.customer.feeder11id;
    feeder33Name = widget.customer.feederName;
    feeder33Id = widget.customer.feeder33id;
    dtrName = widget.customer.dtrName;
    fetchFeeders33();
    super.initState();
  }

  fetchFeeders33() async {
    //isLoading = true;
    print("searching...");

    Map<String, dynamic> res = await f33c.getFeeder33();

    if (res != null && res["status"] == "SUCCESS") {
      feeder33List = res["data"];

      dropdownItemsFeeder33.clear();

     
      dropdownItemsFeeder33.add(
        DropdownMenuItem(
          child: Text(
            "SELECT 33KV FEEDER",
            //style: TextStyle(color: Colors.red),
          ),
          value: ""
        )
      );

      //populate the dropdown list
      feeder33List.forEach((element) {
        //print("xx$element['33kV_FdrName_NewName']");
        dropdownItemsFeeder33.add(DropdownMenuItem(
            child: Text(
              element["33kV_FdrName_NewName"],
              //style: TextStyle(color: Colors.red),
            ),
            value:
                "${element["33kV_FdrName_NewName"]} - ${element["33kV_FdrID"]}")); 
      });

      

    
      dropdownItemsFeeder11.clear();

      dropdownItemsFeeder11.add(
        DropdownMenuItem(
          child: Text(
            "SELECT 11KV FEEDER",
            //style: TextStyle(color: Colors.red),
          ),
          value: ""
        )
      );

      dropdownItemsFeeder11.add(
        DropdownMenuItem(
          child: Text(
            "$feeder11",
            //style: TextStyle(color: Colors.red),
          ),
          value: "$feeder11 - $feeder11id"
        )
      );

      //After populating the dropdown list, set the initial set value
      setState(() {
        feeder33 = "$feeder33Name - $feeder33Id";
        feeder11 = "$feeder11 - $feeder11id";
        isLoading = false;
      });
      
      
    } else {
      _showSnackBar(isSuccessSnack: false, msg: "33KV Feeder not found");
    }
  }

  getFeeder11() async {

    if (feeder33.toString().trim().length == 0 || feeder33 == null) {
      return;
    }

     dropdownItemsFeeder11.clear();
   
      dropdownItemsFeeder11.add(
        DropdownMenuItem(
          child: Text(
            "SELECT 11KV FEEDER",
            //style: TextStyle(color: Colors.red),
          ),
          value: ""
        )
      );
       setState(() {
          feeder11 = dropdownItemsFeeder11[0].value;
      });


    var f33 = feeder33.split("-");
    feeder33Name = f33[0].trim();
    feeder33Id = f33[1].trim(); //feeder33Id => 128.0

    
    var formattedFeeder33Id =
        feeder33Id.split('.'); //formattedFeeder33Id => [128, 0]
        var fr;

    if(formattedFeeder33Id.length > 0){
        print(formattedFeeder33Id[0]);
        fr = formattedFeeder33Id[0];
    }
    else{
      fr = feeder33Id;
    }

    print("fdsdsfds:"+fr);

    showAlertDialog(
        context: context,
        isLoading: true,
        loadingMsg: "retrieving 11KV Feeders");

    var f11List = List();
    Map<String, dynamic> res =
        await f11c.getFeeder11(fr.trim());
        print("dssfs: " + res.toString());
    if (res["status"] == "SUCCESS") {
      f11List.clear();
      f11List = res["data"];
      f11List.forEach((element) {
        dropdownItemsFeeder11.add(DropdownMenuItem(
            child: Text(element["feeder_name"], overflow: TextOverflow.visible),
            value:
                "${element["feeder_name"]} - ${element["feeder11kv_id"].toString()}"));
      });

      print("fsfsfsfs: "+dropdownItemsFeeder11.length.toString());
     
    } else {
      _showSnackBar(isSuccessSnack: false, msg: "No 11kv Feeder found");
    }
    Navigator.pop(context);
  }

//Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg, int duration}) {
    //create snackbar
    var snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    //show snackbar
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String validateInput() {
    if (feeder33 == null || feeder33.toString().trim().length == 0) {
      return "Please select a 33KV Feeder";
    }
    if (feeder11 == null || feeder11.toString().trim().length == 0) {
      return "Please select an 11KV Feeder";
    }
    if (dtrName == null || dtrName.toString().trim().length == 0) {
      return "Please enter a DTR Name";
    }
    if (capacity == null || capacity.toString().trim().length == 0) {
      return "Please enter a DTR capacity";
    }
    if (dtrexec == null || dtrexec.toString().trim().length == 0) {
      return "Please enter a DTR executive staff id";
    }
    return null;
  }

  submit() {
    _getGeoPoints();
  }

  Future _getGeoPoints() async {
    showAlertDialog(
        context: context, isLoading: true, loadingMsg: "updating DTR records...");

    try {
      var latLng = await LocationService.checkLocationPermissionStatus(context);
      print(latLng.toString());

      if (latLng["isServiceEnabled"] &&
          latLng["latitude"] != null &&
          latLng["longitude"] != null) {
        latitude = latLng["latitude"].toString();
        longitude = latLng["longitude"].toString();

        print(latLng["latitude"]);

        completeAction();
      } else {
        setState(() {
          isLoading = false;
        });
        _showSnackBar(
            isSuccessSnack: false, msg: "Please put on your location service"
          );
          Navigator.of(context).pop();
      }
    } catch (e) {
      print("dc_details: error fetching lat/lng");
      print("dc_details: " + e.toString());
      _showSnackBar(isSuccessSnack: false, msg: "Couldn't fetch coordinates");
      Navigator.of(context).pop();
    }

  }

  void completeAction() async {

    if (validateInput() != null) {
      _showSnackBar(isSuccessSnack: false, msg: validateInput());
      return;
    }

    try {
      var f11 = feeder11.split(" - ");
      feeder11 = f11[0].trim();
      feeder11id = f11[1].trim();
    } catch (e) {
      print(e.toString());
    }

    Map<String, dynamic> data = {
      "feeder33name": feeder33Name,
      "feeder11name": feeder11,
      "dtrName": dtrName,
      "feeder33id": feeder33Id,
      "feeder11id": feeder11id,
      "accountNo": '',
      "staffId": authenticatedStaff.staffId,
      "latitude": latitude,
      "longitude": longitude,
      "capacity": capacity,
      "dtrexec": dtrexec,
      "dtrid": widget.customer.dtrId
    };
    print("Submit-Data " + data.toString());

    Map<String, dynamic> res = await uDTRc.updateNewDTR(data);

    //submission was successful
    if (res != null) {
      if (res['status'] == "SUCCESS") {
        
          if (res['data'] == "\"Staff ID is invalid\"") {
             Navigator.of(context).pop();
            showAlertDialog(
                context: context,
                isLoading: false,
                isSuccess: false,
                completedMsg: "Invalid Staff Id");
          } 
          else if (res['data'] == "\"DTR Updated Successfully\"") {
             Navigator.of(context).pop();
            showAlertDialog(
                context: context,
                navigateTo: '/bd_searchdtr',
                isLoading: false,
                isSuccess: true,
                completedMsg: "DTR re-assigned to DTR Executive with Staff ID $dtrexec successfully");
          }
           else if (res['data'] == "\"Error has occured\"") {
             Navigator.of(context).pop();
            showAlertDialog(
                context: context,
                isLoading: false,
                isSuccess: false,
                completedMsg: "Error has occured \n DTR could be updated");
          } 
          else {
             Navigator.of(context).pop();
            showAlertDialog(
                context: context,
                navigateTo: '/bd_searchdtr',
                isLoading: false,
                isSuccess: true,
                completedMsg: "DTR with ID " +
                    res['data'] +
                    " was successfully assigned to DTR Executive with Staff ID $dtrexec");
          }
      }
      //submission failed
      else {
        setState(() => isLoading = false);
         Navigator.of(context).pop();
        showAlertDialog(
            context: context,
            isLoading: false,
            isSuccess: false,
            completedMsg: res['msg']);
      }
    }
  }

  Widget _buildDropDownButtonFeeder33() {
  
    Widget dropdownButton;
    dropdownButton = Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(8.0),
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 6.0, offset: Offset(0, 2), color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(5.0)),
      child: DropdownButton(
        items: dropdownItemsFeeder33,
        onChanged: (dynamic value) {
          print("dropdown value: $value");
          setState(() {
            feeder33 = value;
          });
          getFeeder11();
        },
        value: feeder33,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );

    return dropdownButton;
  }

  Widget _buildDropDownButtonFeeder11() {
    Widget dropdownButton;
    dropdownButton = Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(8.0),
      height: 60.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 6.0, offset: Offset(0, 2), color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(5.0)),
      child: DropdownButton(
        items: dropdownItemsFeeder11,
        onChanged: (dynamic value) {
          print("dropdown value: $value");
          setState(() {
            feeder11 = value;
          });
        },
        value: feeder11,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );

    return dropdownButton;
  }

  Widget _buildDTRTextField() {
    return Container(
      child: TextFormField(
        initialValue: widget.customer.dtrName,
        decoration: InputDecoration(
            labelText: "DTR Name",
            hintText: "",
            hintStyle: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1.0),
                fontFamily: "SFProText-Regular"),
            prefixIcon: Icon(Icons.verified_user),
            fillColor: Colors.white,
            filled: true),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter DTR";
          }
          return null;
        },
        onSaved: (value) => dtrName = value,
        onChanged: (String value) => dtrName = value,
      ),
    );
  }

  Widget _buildCapacityTextField() {
    return Container(
      child: TextFormField(
        initialValue: widget.customer.capacity,
        decoration: InputDecoration(
            labelText: "Capacity",
            hintText: "Capacity",
            prefixIcon: Icon(Icons.verified_user),
            fillColor: Colors.white,
            filled: true),
        validator: (String value) {
          if (value.length == 0 || value == null) {
            return "Please enter DTR capacity";
          }
          return null;
        },
        onSaved: (newValue) => capacity = newValue,
        onChanged: (String value) => capacity = value,
      ),
    );
  }

  Widget _buildDTRExecTextField() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "DTR Executive staff id",
            labelText: "DTR Executive staff id",
            prefixIcon: Icon(Icons.verified_user),
            fillColor: Colors.white,
            filled: true),
        validator: (String value) {
          if (value.length == 0 || value == null) {
            return "Please enter DTR Executive staff id";
          }
          return null;
        },
        onSaved: (newValue) => dtrexec = newValue,
        onChanged: (String value) => dtrexec = value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Assign DTR")),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bgg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1.0), BlendMode.dstATop))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Text(
                        "Please complete the following fields",
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildDropDownButtonFeeder33(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildDropDownButtonFeeder11(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildDTRTextField(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildCapacityTextField(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildDTRExecTextField(),
                      SizedBox(
                        height: 25.0,
                      ),
                      SubmitButton(submit, isLoading, "SUBMIT"),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
