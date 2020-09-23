// import 'package:flutter/material.dart';
// import '../../../controllers/billDistribution/update_dtr_controller.dart';
// import '../../../controllers/utility/feeder_11.dart';
// import '../../../controllers/utility/feeder_33.dart';
// import '../../../data/authenticated_staff.dart';
// import '../../../models/customer.dart';
// import '../../../screens/bill/bd_details.dart';
// import '../../../services/location_service.dart';
// import '../../../utilities/alert_dialog.dart';
// import '../../../widgets/submit_btn.dart';

// class BDUpdateDTRScreen extends StatefulWidget {
//   final Customer customer;
//   BDUpdateDTRScreen(this.customer);

//   @override
//   _BDUpdateDTRScreenState createState() => _BDUpdateDTRScreenState();
// }

// class _BDUpdateDTRScreenState extends State<BDUpdateDTRScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final Feeder33Controller f33c = Feeder33Controller();
//   final Feeder11Controller f11c = Feeder11Controller();
//   final UpdateDTRController uDTRc = UpdateDTRController();

//   String feeder33; //feeder33 => concatenation: "Feeder33Name - Feeder33Id"
//   String feeder11;
//   String feeder33Id;
//   String feeder33Name;
//   String dtrName;
//   String latitude;
//   String longitude;
//   String dtrCapacity;
//   bool isLoading = true;
//   List feeder33List = List();

//   List<DropdownMenuItem> dropdownItemsFeederOption = [
//     DropdownMenuItem(
//         child: Text(
//           "Select 33KV Feeder**",
//           style: TextStyle(color: Colors.red),
//         ),
//         value: ""),
//   ];

//   List<DropdownMenuItem> dropdownItemsFeeder33 = [
//     DropdownMenuItem(
//         child: Text(
//           "Select 33KV Feeder**",
//           style: TextStyle(color: Colors.red),
//         ),
//         value: ""),
//   ];

//   List<DropdownMenuItem> dropdownItemsFeeder11 = [
//     DropdownMenuItem(
//         child: Text(
//           "Select 11KV Feeder**",
//           style: TextStyle(color: Colors.red),
//         ),
//         value: ""),
//   ];

//   @override
//   void initState() {
//     feeder33 = dropdownItemsFeeder33[0].value;
//     feeder11 = dropdownItemsFeeder11[0].value;
//     fetchFeeders33();
//     super.initState();
//   }

//   fetchFeeders33() async {
//     //isLoading = true;
//     print("searching...");
//     Map<String, dynamic> res = await f33c.getFeeder33();

//     if (res != null && res["status"] == "SUCCESS") {
//       feeder33List = res["data"];

//       if (dropdownItemsFeeder33.length > 1) {
//         setState(() {
//           dropdownItemsFeeder33.removeRange(1, dropdownItemsFeeder33.length);
//         });
//       }

//       feeder33List.forEach((element) {

       
//         if(element["33kV_FdrName_NewName"] != null ){
//               dropdownItemsFeeder33.add(DropdownMenuItem(
//                 child: Text(
//                   element["33kV_FdrName_NewName"],
//                   //style: TextStyle(color: Colors.red),
//                 ),
//                 value:
//                     "${element["33kV_FdrName_NewName"]} - ${element["33kV_FdrID"]}"
//               )
//             );
//         }

       
      
//       });
      

//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       _showSnackBar(isSuccessSnack: false, msg: "33KV Feeder not found");
//       setState(() {
//         isLoading = false;
//       });
      
//     }
//   }

//   getFeeder11() async {
//     if (feeder33.toString().trim().length == 0 && feeder33 == null) {
//       return;
//     }

//     var f33 = feeder33.split("-");
//     feeder33Name = f33[0].trim();
//     feeder33Id = f33[1].trim(); //feeder33Id => 128.0

//     var formattedFeeder33Id =
//         feeder33Id.split('.'); //formattedFeeder33Id => [128, 0]

//     print(formattedFeeder33Id[0]);

//     if (dropdownItemsFeeder11.length > 1) {
//       setState(() {
//         dropdownItemsFeeder11.removeRange(1, dropdownItemsFeeder11.length);
//       });
//     }
//     showAlertDialog(
//         context: context,
//         isLoading: true,
//         loadingMsg: "retrieving 11KV Feeders");

//     var f11List = List();
//     Map<String, dynamic> res =
//         await f11c.getFeeder11(formattedFeeder33Id[0].trim());
//     if (res["status"] == "SUCCESS") {
//       f11List.clear();
//       f11List = res["data"];
//       f11List.forEach((element) {
//         dropdownItemsFeeder11.add(
//           DropdownMenuItem(
//             child: Text(element["feeder_name"], overflow: TextOverflow.visible),
//             value: element["feeder11kv_id"].toString(),
//           ),
//         );
//       });
//     } else {
//       _showSnackBar(
//           isSuccessSnack: false,
//           msg: "No Map Installer for the selected Map contractor");
//     }
//     Navigator.pop(context);
//   }

// //Function: snackbar for creating and displaying widget
//   void _showSnackBar({bool isSuccessSnack, String msg, int duration}) {
//     //create snackbar
//     var snackBar = SnackBar(
//       duration: Duration(seconds: 5),
//       backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
//       content: Text(
//         msg,
//         style: TextStyle(color: Colors.white),
//       ),
//     );

//     //show snackbar
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }

//   String validateInput() {
//     if (feeder33 == null || feeder33.toString().trim().length == 0) {
//       return "Please select a 33KV Feeder";
//     }
//     if (feeder11 == null || feeder11.toString().trim().length == 0) {
//       return "Please select an 11KV Feeder";
//     }
//     if (dtrName == null || dtrName.toString().trim().length == 0) {
//       return "Please enter a DTR Name";
//     }
//     return null;
//   }

//   submit() {
//     _getGeoPoints();
//   }

//   Future _getGeoPoints() async {
//     showAlertDialog(
//         context: context, isLoading: true, loadingMsg: "updating records...");

//     try {
//       var latLng = await LocationService.checkLocationPermissionStatus(context);
//       print(latLng.toString());

//       if (latLng["isServiceEnabled"] &&
//           latLng["latitude"] != null &&
//           latLng["longitude"] != null) {
//         latitude = latLng["latitude"].toString();
//         longitude = latLng["longitude"].toString();

//         print(latLng["latitude"]);

//         completeAction();
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         _showSnackBar(
//             isSuccessSnack: false, msg: "Please put on your location");
//       }
//     } catch (e) {
//       print("dc_details: error fetching lat/lng");
//       print("dc_details: " + e.toString());
//     }

//     Navigator.of(context).pop();
//     print(longitude);
//     print(latitude);
//   }

//   void completeAction() async {
//     if (validateInput() != null) {
//       _showSnackBar(isSuccessSnack: false, msg: validateInput());
//       return;
//     }

//     Map<String, dynamic> data = {
//       "feeder33name": feeder33,
//       "feeder11name": feeder11,
//       "dtrName": dtrName,
//       "accountNo": widget.customer.accountNo,
//       "staffId": authenticatedStaff.staffId,
//       "latitude": latitude,
//       "longitude": longitude,
//       "dtrid": widget.customer.dtrId,
//       'capacity': dtrCapacity
//     };

//     print("${widget.customer.dtrId}");
//     print(dtrCapacity);
//     print("qqqqqqqq:" +data.toString());
    

//     Map<String, dynamic> res = await uDTRc.updateDTR(data);

//     //submission was successful
//     if (res != null) {
//       if (res['status'] == "SUCCESS") {
//         //setState(()=>isLoading = false);
//         //Navigator.pop(context);
//         showAlertDialog(
//             context: context,
//             isLoading: false,
//             isSuccess: true,
//             completedMsg: "Updated successfully");
//         _redirect();
//       }
//       //submission failed
//       else {
//         setState(() => isLoading = false);
//         showAlertDialog(
//             context: context,
//             isLoading: false,
//             isSuccess: false,
//             completedMsg: res['message']);
//       }
//     }
//   }

//   void _redirect() {
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => BillDetailsScreen(widget.customer)));
//     });
//   }

//   Widget _buildDropDownButtonFeeder33() {
//     Widget dropdownButton;
//     dropdownButton = Container(
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 6.0, offset: Offset(0, 2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)),
//       child: DropdownButton(
//         items: dropdownItemsFeeder33,
//         onChanged: (dynamic value) {
//           print("dropdown value: $value");
//           setState(() {
//             feeder33 = value;
//           });
//           getFeeder11();
//         },
//         value: feeder33,
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//       ),
//     );

//     return dropdownButton;
//   }

//   Widget _buildDropDownButtonFeeder11() {
//     Widget dropdownButton;
//     dropdownButton = Container(
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 6.0, offset: Offset(0, 2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)),
//       child: DropdownButton(
//         items: dropdownItemsFeeder11,
//         onChanged: (dynamic value) {
//           print("dropdown value: $value");
//           setState(() {
//             feeder11 = value;
//           });
//         },
//         value: feeder11,
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//       ),
//     );

//     return dropdownButton;
//   }

//   Widget _buildDTRTextField() {
//     return TextFormField(
//       decoration: InputDecoration(
//           labelText: "DTR Name",
//           hintText: "",
//           prefixIcon: Icon(Icons.verified_user),
//           fillColor: Colors.white,
//           filled: true),
//       validator: (String value) {
//         if (value.length == 0 || value == null) {
//           return "Please enter DTR";
//         }
//         return null;
//       },
//       onSaved: (newValue) => dtrName = newValue,
//       onChanged: (String value) => dtrName = value,
//     );
//   }

//   Widget _buildDTRCapacityTextField() {
//     return TextFormField(
//       decoration: InputDecoration(
//           labelText: "DTR Capacity",
//           hintText: "",
//           prefixIcon: Icon(Icons.verified_user),
//           fillColor: Colors.white,
//           filled: true),
//       validator: (String value) {
//         if (value.length == 0 || value == null) {
//           return "Please enter DTR Capacity";
//         }
//         return null;
//       },
//       onSaved: (newValue) => dtrCapacity = newValue,
//       onChanged: (String value) => dtrCapacity = value,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text("Update DTR")),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/images/bgg.png'),
//                       fit: BoxFit.cover,
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(1.0), BlendMode.dstATop))),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
//                 child: Form(
//                   key: _formKey,
//                   child: ListView(
//                     children: <Widget>[
//                       SizedBox(height: 15.0),
//                       Text(
//                         "Please complete the following fields",
//                         //textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       _buildDropDownButtonFeeder33(),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       _buildDropDownButtonFeeder11(),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       _buildDTRTextField(),
//                        SizedBox(
//                         height: 15.0,
//                       ),
//                       _buildDTRCapacityTextField(),
//                       SizedBox(
//                         height: 25.0,
//                       ),
//                       SubmitButton(submit, isLoading, "SUBMIT")
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
