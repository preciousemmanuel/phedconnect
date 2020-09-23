// import 'package:flutter/material.dart';
// import '../../../controllers/utility/lga_controller.dart';
// import '../../../controllers/utility/state_controller.dart';
// import '../../../data/active_dtr.dart';
// import '../../../data/authenticated_staff.dart';
// import '../../../models/billDistribution/addStreetToDTRModel.dart';
// import '../../../controllers/billDistribution/streetsController.dart';
// import '../../../models/utility/lga.dart';
// import '../../../models/utility/state.dart';
// import '../../../utilities/alert_dialog.dart';

// import 'street_list.dart';
  
  
//   class BDStreetAdd extends StatefulWidget {
//     @override
//     _BDStreetAddState createState() => _BDStreetAddState();
//   }

//   class _BDStreetAddState extends State<BDStreetAdd> {

//       final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//       final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
//       String state,lga,community,lastbusstop,nlandmark,streetname,dtrid;
//       bool isSubmitting = false;
//       bool isLoading = true;
//       ScrollController _scroll;
//       FocusNode _focus = new FocusNode();

//       StreetsController sc = StreetsController();
//       StateController stateController = StateController();
//       LGAController lgaController = LGAController();

//       List<RCDCState> stateList = [];
//       List<LGA> lgaList = [];


//       List<DropdownMenuItem> dropdownItemsStates = [
//         DropdownMenuItem(
//           child: Text("Select State**"),
//           value: "",
//         ),
//       ];
//       List<DropdownMenuItem> dropdownItemsLGAs = [
//         DropdownMenuItem(
//           child: Text("Select LGA**"),
//           value: "",
//         ),
//       ];



//       //submit button widget
//       Widget _buildSubmitButton(){
//       return GestureDetector(
//           onTap: (){
//             if (_formKey.currentState.validate()) {
//                 // If the form is valid, display a Snackbar.
//                 //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
//                   print("New street add");
//                   _formKey.currentState.save();
//                   _addStreet();
//             }
//           },
//           child:Container(
//           margin: EdgeInsets.symmetric(horizontal: 60.0),
//           alignment: Alignment.center,
//           height: 45.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30.0),
//             color: Colors.green
//           ),
//           child: isSubmitting ?
//           Container(
//               width: 25,
//               height: 25,
//               child: CircularProgressIndicator(
//                 valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
//               ),
//           ):
//           Text(
//             "Add Street",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w600
//               ),
//           ),
//         ),
//       );
//   }


//       @override
//       void initState() {
//         state = dropdownItemsStates[0].value;
//         lga = dropdownItemsLGAs[0].value;
//         getStates();
//         super.initState();
//       }


//       getStates() async{
//         Map<String, dynamic> resStates = await stateController.getStates();
//         if(resStates["status"] == "SUCCESS"){

//           stateList.clear();
//           if(dropdownItemsStates.length > 1){
//             dropdownItemsStates.removeRange(1, dropdownItemsStates.length);
//           }
          
//           stateList = resStates["data"];
//           stateList.forEach((element) {
//             dropdownItemsStates.add(
//               DropdownMenuItem(
//                 child: Text(element.name, overflow: TextOverflow.visible,),
//                 value: element.code,
//               ),
//             );
//           });

//           setState(() => isLoading = false);

//           //fetch the report categories
//         }
//       }

//       getLGAsByState(String state) async{

//         //if(dropdownItemsLGAs.length > 1){
//           //dropdownItemsLGAs.removeRange(1, dropdownItemsLGAs.length);
//         //}
//         lga = dropdownItemsLGAs[0].value;
//         List<DropdownMenuItem> dropdownItemsLs = List<DropdownMenuItem>();
//         dropdownItemsLs.clear();
//         dropdownItemsLs.add(
//           DropdownMenuItem(
//             child: Text("Select LGA**"),
//             value: "",
//           ),
//         );
//         //lga = dropdownItemsLGAs[0].value;

//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving LGAs");
//         Map<String, dynamic> res = await lgaController.getLGAs(state);

//         if(res["status"] == "SUCCESS"){
//           lgaList.clear();
//           lgaList = res["data"];
//           lgaList.forEach((element) {
//             dropdownItemsLs.add(
//               DropdownMenuItem(
//                 child: Text(
//                   element.lgaName,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 value: element.lgaCode,
//               ),
//             );
//           });

//           dropdownItemsLGAs.clear();
//           setState(() {
//              dropdownItemsLGAs = dropdownItemsLs;
//           });
//           lga = dropdownItemsLGAs[0].value;

//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No LGAs found for the selected State");
//         }
//         Navigator.pop(context);

//       }

//       //builds the dropdown for Zones
//       Widget _buildDropDownButtonState(){

//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ],
//               borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             //the list "dropdownItemsZones" is from "lib/data/dropdown_btn_list.dart"
//             items: dropdownItemsStates,
//             onChanged: (dynamic value){

//               setState(() {
//                 state = value;
//                 print(state);
//               });
//               getLGAsByState(state);
//             },
//             value: state,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//       }

//       //builds the dropdown for Report Description
//       Widget _buildDropDownButtonLGA(){
//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ],
//               borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             items: dropdownItemsLGAs,
//             onChanged: (dynamic value){
//               //lga = null;
//               setState(() {
//                 lga = value;
//                 print(lga);
//               });

//             },
//             value: lga,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//       }


//       @override
//       Widget build(BuildContext context) {
//         //print(authenticatedStaff.id);
//         _scroll = new ScrollController();
//             _focus.addListener(() {
//               _scroll.jumpTo(-1.0);
//             });
//           return Scaffold(
//           key: scaffoldKey,
//             appBar: AppBar(
//               title: Text("Add New Street"),
//             ),
//             //resizeToAvoidBottomPadding: true,
//             body: isLoading ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                  CircularProgressIndicator(),
//                  Text("Loading...Please wait")
//               ],)
              
//             ):
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/bgg.png'),
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//                 )
//               ),
//               child: SingleChildScrollView(
//                  controller: _scroll,
//                   child: Form(
//                     key: _formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                         children: <Widget>[
//                             Text(
//                               "Complete the following details",
//                               style: TextStyle(
//                                 color: Colors.white, 
//                                 fontWeight: FontWeight.bold
//                               ),
//                               textAlign: TextAlign.start
//                             ),
//                             SizedBox(height: 20.0),
//                             _buildDropDownButtonState(),
                          
//                             SizedBox(height: 10.0,),
//                             _buildDropDownButtonLGA(),
                          
//                             SizedBox(height: 10.0,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "Community",
//                                 fillColor: Colors.white,
//                                 filled: true
//                               ),
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'Please enter community';
//                                 }
//                               return null;
//                             },
//                                 onSaved: (value) => community = value,
//                             ),
//                             SizedBox(height: 10.0,),
//                               TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "Last bus stop",
//                                 fillColor: Colors.white,
//                                 filled: true
//                               ),
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'Please enter last bus stop';
//                                 }
//                               return null;
//                             },
//                                 onSaved: (value) => lastbusstop = value,
//                             ),

//                             SizedBox(height: 10.0,),
//                               TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "Nearest landmark",
//                                 fillColor: Colors.white,
//                                 filled: true
//                               ),
//                                 validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'Please enter nearest landmark';
//                                 }
//                               return null;
//                             },
//                               onSaved: (value) => nlandmark = value,
//                             ),
//                             SizedBox(height: 10.0,),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "Street Name",
//                                 fillColor: Colors.white,
//                                 filled: true
//                               ),
//                                 validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'Please enter Street name';
//                                 }
//                               return null;
//                             },
//                               onSaved: (value) => streetname = value,
//                             ),
//                             SizedBox(height: 20.0,),
//                             _buildSubmitButton()
//                         ]
//                       ),
//                     ),
//                       )
//                 ),
//             )
//           );
                
//   }
      
//       Future<void> _addStreet() async {

//           setState (() => isSubmitting = true);
//           AddStreettoDTRModel addStreettoDTRModel = AddStreettoDTRModel();
//           addStreettoDTRModel.streetname = streetname;
//           addStreettoDTRModel.state=state;
//           addStreettoDTRModel.nlandmark=nlandmark;
//           addStreettoDTRModel.lastbustop=lastbusstop;

//           List<String> dtrDetails = activeDTR.split("-");
//           String dtrName = dtrDetails[0].trim();
//           String dtrId = dtrDetails[1].trim();

//           print(dtrName);
//           print(dtrId);
//           print(authenticatedStaff.staffId);
//           //start loading spinner

//           Map<String, dynamic> res;
//           // make call to api login
//           // authentication controller @lib/controller/auth
//           res = await  sc.addStreet(
//             state, 
//             lga, 
//             community, 
//             lastbusstop, 
//             nlandmark, 
//             streetname, 
//             dtrId, 
//             authenticatedStaff.staffId, 
//             "streettype"
//           );
//           //show success snackbar
//           if(res['isSuccessful']){
//               setState (() => isSubmitting = false);
//               _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: "New street added successfully");
//               _redirect();
//           }
//           //show failed snackbar
//           else{
//               _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: "Operation failed...Please try again!");
//               setState (() => isSubmitting = false);
//           }
          
              
//       }

//       //Function: snackbar for creating and displaying widget
//       void _showSnackBar({bool isSuccessSnack, String msg}){

//             //create snackbar
//             var snackBar =  SnackBar(
//                 backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
//                 content: Text(msg,
//                 style: TextStyle(
//                   color: Colors.white
//                 ),),
//             );

//             //show snackbar
//             scaffoldKey.currentState.showSnackBar(snackBar);
//             if(isSuccessSnack){
//               _formKey.currentState.reset();
//             }
//       }

//       //redirect on successful login
//       void _redirect(){
//           Future.delayed(Duration(seconds: 2), (){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BDStreetList()),
//             );  
//           });
//       }
//   }