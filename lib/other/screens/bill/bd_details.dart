import 'dart:io';

import '../../controllers/billDistribution/billcustomer_controller.dart';
import '../../controllers/image_uploader_controller.dart';
import '../../data/authenticated_staff.dart';
import '../../models/customer.dart';
import '../../models/expansion_panel_item.dart';
import '../../screens/bill/customer/billUpdateCustpmerDetail.dart';
import '../../screens/bill/customer/bill_update_dtr.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import '../../widgets/customer_info_text.dart';
import '../../widgets/file_upload.dart';
import '../../widgets/remarks_text_field.dart';
import '../../widgets/submit_btn.dart';
import 'package:flutter/material.dart';

import 'constans.dart';

class BillDetailsScreen extends StatefulWidget {
  final Customer customer;
  BillDetailsScreen(this.customer);

  @override
  _BillDetailsScreenState createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  BillCustomerController sc = new BillCustomerController();

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  Customer c;
  bool dtrExecutiveState;
  String _offence;
  String _remarks, lat, lon, action;
  bool isSubmitting = false;
  String yellowPhase, bluePhase, redPhase;
  String staffID, presentreading;
  List<File> displayImageList = List<File>();
  //String _phaseReadingvisible = '';
  final ImageUploaderController imageUploadController =
      ImageUploaderController();

  List<DropdownMenuItem> dropdownItemsOffence = [
    DropdownMenuItem(
      child: Text("Bill Delivery Status"),
      value: "",
    ),
    DropdownMenuItem(
      child: Text("Delivered"),
      value: "Delivered",
    ),
    DropdownMenuItem(
      child: Text("Not Delivered"),
      value: "Not Delivered",
    ),
    DropdownMenuItem(
      child: Text("Meter Reading"),
      value: "Meter Reading",
    ),
    DropdownMenuItem(
      child: Text("Line Load"),
      value: "Line Load",
    ),
  ];

  @override
  void initState() {
    c = widget.customer;
    print("CustomerOnStreets " + c.delivered.toString());
    action = dropdownItemsOffence[0].value;
    dtrExecutiveState = false;
    staffID = authenticatedStaff.staffId;
    print("dsdsd : " + c.meterno.toString());
    super.initState();
  }


  Widget _buildDropDownButton() {
    Widget dropdownButton;
    dropdownButton = Container(
      padding: EdgeInsets.all(8.0),
      height: 60.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 6.0, offset: Offset(0, 2), color: Colors.black12)
      ]),
      child: DropdownButton(
        items: dropdownItemsOffence,
        onChanged: (dynamic value) {
          setState(() {
            action = value;
          });
         /* if (value == "Direct Reading") {
            _phaseReadingvisible = true;
          }
          */
        },
        value: action,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );

    return dropdownButton;
  }

  void completeBDAction() {
    //This method will be responsibible for making the
    //api call to complete the disconnection process
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _getGeoPoints();
      print("yes, I am validating");
      print(_offence);
      print(_remarks);

      //  setState(()=>isSubmitting = true);

    }
  }

  Future<void> _captureBillDelivered() async {
    /*showAlertDialog(
        context: context, isLoading: true, loadingMsg: "Submitting data...");*/
    //start loading spinner
    setState(() => isSubmitting = true);
    Map<String, dynamic> res;
    // make call to api login
    // authentication controller @lib/controller/auth
    if (action.trim().length < 1) {
      setState(() => isSubmitting = false);
      _showSnackBar(
          isSuccessSnack: false, msg: "Please select a bill delivery status");
      return;
    }
    if (action.toString() == "Not Delivered" && _remarks.trim().length < 1) {
      setState(() => isSubmitting = false);
      _showSnackBar(
          isSuccessSnack: false,
          msg: "Please state a reason why you could not deliver the bill");
      return;
    }

    /*Image upload: start*/

    String filePaths;
    Map<String, dynamic> imageUploadRes;

    //atleast one image was selected
    if (displayImageList.length > 0) {
      imageUploadRes = await imageUploadController
          .uploadImagesToServer(displayImageList, senderFlag: "bd");

      //image was not uploaded successfully
      if (!imageUploadRes["isSuccessful"]) {
        setState(() => isSubmitting = false);
        showAlertDialog(
            context: context,
            isLoading: false,
            isSuccess: false,
            completedMsg: imageUploadRes['msg'].toString());

        //uncomment if the 'return' statement is removed
        //filePaths = null;
        return;
      }

      /*
        imageUploadRes:
        {
          "status":"SUCCESS",
          "data":["http:\/\/10.10.25.42\/PHEDConnect\/bd\/scaled_image_picker5423798253383698933.jpg"],
          "message":"1 images uploaded successfully"
        }
        */
      filePaths = imageUploadRes["data"];
    }
    // no image was uploaded
    else {
      print("no image uploaded");
      _showSnackBar(
          isSuccessSnack: false,
          msg: "No image uploaded. Please add atleast 1 image");
      setState(() => isSubmitting = false);

      //uncomment if the 'return' statement is removed
      //filePaths = null;
      return;
    }

    /* Image upload: ends */

    print(
        filePaths); //This is to be added as an argument on saveDeliverBillAction

    // await _getGeoPoints();
    print("StreesIDS " + Constants.streetCode);
    res = await sc.saveDeliverBillAction(
        _remarks == null ? "NA" : _remarks,
        action == null ? "NA" : action,
        lat == null ? "NA": lat,
        lon == null ? "NA" : lon,
        staffID == null ? "NA" : staffID,
        presentreading == null ? "NA" : presentreading,
        Constants.streetCode == null ? "NA" : Constants.streetCode,
        c.accountNo == null ? 'NA' : c.accountNo,
        c.meterno == null ? '' : c.meterno,
        filePaths == null ? '' : filePaths,
        redPhase == null ? "NA" : redPhase,
        bluePhase == null ? "NA" : bluePhase,
        yellowPhase == null ? "NA" : yellowPhase);
    //show success snackbar
    setState(() => isSubmitting = false);
    if (res['isSuccessful']) {
      setState(() => isSubmitting = false);
      _showSnackBar(isSuccessSnack: true, msg: "data saved");

      showAlertDialog(
        context: context,
        isSuccess: true,
        isLoading: false,
        completedMsg: "Data saved successfully",
        navigateTo: '/bd_search_customer',
      );
        print(Constants.bdCustomer);
        // Navigator.pop(context); //remove alert modal
       // _redirect();
    }
    //show failed snackbar
    else {
      _showSnackBar(isSuccessSnack: false, msg: res['msg']);
      setState(() => isSubmitting = false);
    }
  }

  //set the images, selected in the "ImageGridView" widget
  //To achieve this, "lifting up the state" concept is employed
  //i.e passing a reference of the function to the "ImageGridView" widget
  //On image selection, the function is executed and the "image" propertiy is set

  _setImages(List<File> imageList) {
    if (imageList.length > 3) {
      _showSnackBar(
          isSuccessSnack: false,
          msg: "Not more than 3 images can be uploaded!");
      return;
    } else {
      setState(() {
        displayImageList = imageList;
      });
    }

    print("length: ${displayImageList.length}");
  }

  void _setRemarks(String rmks) {
    _remarks = rmks;
  }
  //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg}) {
    //create snackbar
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    //show snackbar
    scaffoldKey.currentState.showSnackBar(snackBar);
    if (isSuccessSnack) {
      //_formKey.currentState.reset();
    }
  }

  //redirect on successful login
  /*void _redirect() {
    Future.delayed(Duration(seconds: 1), () {
      if (Constants.bdCustomer != null && Constants.bdCustomer == "MD") {
        Navigator.pushReplacementNamed(context, '/bd_search_customer');
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StreetCustomerList(
                    Constants.streetCode, Constants.streetName)));
      }
    });
  }
  */

  builExpansionPanelList(List<ExpansionPanelRow> expansionList) {
    List<Widget> epList = [];
    Widget expansionItem;

    for (int i = 0; i < expansionList.length; i++) {
      expansionItem = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(expansionList[i].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(expansionList[i].value,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      );

      epList.add(expansionItem);
    }

    return epList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Details: " + c.accountName)),
      body: isSubmitting ? 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 10.0),
              Text("Submitting details..")
            ],
          )
        ) 
        : Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(1.0), BlendMode.dstATop))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                            color: Colors.black12)
                      ]),
                  child: Column(
                    children: <Widget>[
                      CustomerInfoText(
                          "Bill Delivered:",
                          // ignore: unrelated_type_equality_checks
                          c.delivered == '0' ? 'No' : 'yes'),
                      CustomerInfoText("NAME:", c.accountName),
                      CustomerInfoText("ACCOUNT NO:", c.accountNo),
                      CustomerInfoText(
                          "Phone:", c.phoneNo == null ? 'N/A' : c.phoneNo),
                      CustomerInfoText(
                          "Address:", c.address == null ? 'N/A' : c.address),
                      CustomerInfoText("TARIFF:", c.tariff),
                      CustomerInfoText("Feeder Name:", c.feederName),
                      CustomerInfoText("DTR:", c.dtrName),
                      CustomerInfoText("Book Code:",
                          c.bookcode == null ? 'N/A' : c.bookcode),
                      CustomerInfoText("Bill SN:", c.billsn),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateBillCustomerDetail(c))),
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Text("Update Detail",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          textAlign: TextAlign.center),
                    )),
                Constants.bdCustomer != null && Constants.bdCustomer == "MD"
                    ? InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BDUpdateDTRScreen(c))),
                        child: Container(
                          //margin: const EdgeInsets.all(15.0),
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Text("Update DTR",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                              textAlign: TextAlign.center),
                        ))
                    : Container(),
                SizedBox(height: 10.0),
                _buildDropDownButton(),
                SizedBox(height: 10.0),
                 action == "Line Load" && Constants.bdCustomer != null && Constants.bdCustomer == "MD" ? Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Blue Phase value",
                                labelStyle: TextStyle(fontSize: 8),
                                //hintText: "Blue Phase",
                                //prefixIcon: Icon(Icons.verified_user),
                                fillColor: Colors.white,
                                filled: true),
                            validator: (String value) {
                              if (value.length == 0 || value == null) {
                                return "Please enter Blue phase value";
                              }
                              return null;
                            },
                            onSaved: (newValue) => bluePhase = newValue,
                            onChanged: (String value) => bluePhase = value,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                            flex: 3,
                            child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Yellow Phase",
                                labelStyle: TextStyle(fontSize: 8),
                                //hintText: "Yellow phase value",
                                //prefixIcon: Icon(Icons.verified_user),
                                fillColor: Colors.white,
                                filled: true),
                            validator: (String value) {
                              if (value.length == 0 || value == null) {
                                return "Please enter yellow phase";
                              }
                              return null;
                            },
                            onSaved: (newValue) => yellowPhase = newValue,
                            onChanged: (String value) => yellowPhase = value,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                            flex: 3,
                            child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Red Phase value",
                                labelStyle: TextStyle(fontSize: 8),
                                hintText: "",
                                //prefixIcon: Icon(Icons.verified_user),
                                fillColor: Colors.white,
                                filled: true),
                            validator: (String value) {
                              if (value.length == 0 || value == null) {
                                return "Please enter Red phase value";
                              }
                              return null;
                            },
                            onSaved: (newValue) => redPhase = newValue,
                            onChanged: (String value) => redPhase = value,
                          ),
                        ),
                      ],
                    )):         
                  action == "Meter Reading" ? TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Present Reading",
                      fillColor: Colors.white,
                      filled: true),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter present reading';
                    }
                    return null;
                  },
                  onSaved: (value) => presentreading = value,
                ): Container(),
                SizedBox(height: 10.0),
                RemarksTextFormField(_setRemarks),
                SizedBox(height: 10.0),
                FileUploadButton(setImages: _setImages),
                SizedBox(height: 10.0),
                // ignore: unrelated_type_equality_checks
                c.delivered == '1'
                    ? Container()
                    : SubmitButton(completeBDAction, isSubmitting, "SUBMIT")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _getGeoPoints() async {
   
    try {
      var latLng = await LocationService.checkLocationPermissionStatus(context);
      print(latLng.toString());

      if(!latLng["isServiceEnabled"]){
        _showSnackBar(
            isSuccessSnack: false, msg: "please put on your location service to complete your submission"
        );
        //Navigator.pop(context);
      }
      else{

        showAlertDialog(
          context: context,
          isLoading: true,
          loadingMsg: "Fetching cordinates..."
        );

          
        if (latLng["isServiceEnabled"] &&
            latLng["latitude"] != null &&
            latLng["longitude"] != null) {
            lat = latLng["latitude"];
            lon = latLng["longitude"];

          print(latLng["latitude"]);
          //Navigator.of(context).pop();
          _captureBillDelivered();
        } else {
          _showSnackBar(
              isSuccessSnack: false, msg: "Please put on your location");
        }
       // Navigator.of(context).pop();
      }

    } catch (e) {
      print("dc_details: error fetching lat/lng");
      print("dc_details: " + e.toString());
    }

    
    print(lon);
    print(lat);
  }
}
