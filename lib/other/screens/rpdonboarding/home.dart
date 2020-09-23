
// import 'dart:convert';
// import 'dart:io';
// import '../../data/active_dtr.dart';
// import 'package:flutter/material.dart';

// import '../../controllers/onboarding/onboarding_controller.dart';
// import '../../controllers/utility/lga_controller.dart';
// import '../../models/utility/lga.dart';
// import '../../models/utility/state.dart';
// import '../../screens/rpdonboarding/dropdown_data.dart';
// import '../../controllers/image_uploader_controller.dart';
// import '../../controllers/utility/dtr_controller.dart';
// import '../../controllers/utility/feeder_controller.dart';
// import '../../controllers/utility/state_controller.dart';
// import '../../controllers/utility/zone_controller.dart';
// import '../../data/authenticated_staff.dart';
// import '../../data/dropdown_btn_list.dart';
// import '../../models/utility/dtr.dart';
// import '../../models/utility/feeder.dart';
// import '../../models/utility/zone.dart';
// import '../../services/location_service.dart';
// import '../../utilities/alert_dialog.dart';
// import '../../widgets/file_upload.dart';
// import '../../widgets/submit_btn.dart';
// import 'onboarding_dtr_list.dart';





// class RPDOnboardingHomeScreen extends StatefulWidget {
//   @override
//   _RPDOnboardingHomeScreenState createState() => _RPDOnboardingHomeScreenState();
// }

// class _RPDOnboardingHomeScreenState extends State<RPDOnboardingHomeScreen> {

//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
//     OnboardingController model = new OnboardingController();
//     ZoneController zc = ZoneController();
//     FeederController fc = FeederController();
//     DTRController dtrc = DTRController();
//     StateController stateController = StateController();
//     LGAController lgaController = LGAController();
//     final ImageUploaderController imageUploadController = ImageUploaderController();

//     List<RCDCState> stateList = [];
//     List<LGA> lgaList = [];

//      List<DropdownMenuItem> dropdownItemsStates = [
//         DropdownMenuItem(
//           child: Text("Select State**", style: TextStyle(color: Colors.blue),),
//           value: "",
//         ),
//       ];
//       List<DropdownMenuItem> dropdownItemsLGAs = [
//         DropdownMenuItem(
//           child: Text("Select LGA**", style: TextStyle(color: Colors.blue),),
//           value: "",
//         ),
//       ];

   

//     String _applicantSignature;
//     String _bookCode;
//     String _communityName;
//     String _customerEmail;
//     String _customerLoad;
//     String _dtrCode;
//     String _dtrName;
//     String _feederId;
//     String _feederName;
//     //String _filePaths;
//     String _houseNo;
//     String _landMark;
//     String latitude;
//     String longitude;
//     String _lga;
//     String _mda;
//     String _meanOfId;
//     String _meterNo;
//     String _nearbyAccountNo;
//     String _occupation;
//     String _officeEmail;
//     String _debulkingNumber;
//     String _obCategory;
//     String _otherNames;
//     String _parentAccountNo;
//     //String _passport;
//     String _phoneNumber1;
//     String _phoneNumber2;
//     String _state;
//     String _status;
//     String _streetName;
//     String _surname;
//     String _typeOfMeterRequired;
//     String _typeOfPremises;
//     String _useOfPremises;
//     //String _capturedBy;
//     String _zipCode;
//     String _zone;
   

//     String _selectedFeeder;
//     //String _selectedDTR;
//     //String _selectedSubCategory;
  
//     bool isLoading = true;
//     List uploadedImages = [];
//     List<File> displayImageList = List<File>();
//     List<File> passportImageList = List<File>();
//     //DateTime _dateTime = DateTime.now();
//     var latLng;
//     List<Zone> zoneList = [];
//     List<Feeder> feederList = [];
//     List<DTR> dtrList = [];
  
//     //onboarding variables
    

//     @override
//     void initState(){
//         _selectedFeeder = dropdownItemsFeeders[0].value;
//         _zone = dropdownItemsZones[0].value;
//         //_selectedDTR = dropdownItemsDTR[0].value;
//         //_selectedSubCategory = dropdownItemsSubCategory[0].value;

//         _typeOfPremises = dropdownItemsOnboardingTypeOfPremise[0].value;
//         _obCategory = dropdownItemsOnboardingCategory[0].value;
//         _meanOfId = dropdownItemsOnboardingID[0].value;
//         _typeOfMeterRequired = dropdownItemsOnboardingMeterRequired[0].value;
//         _useOfPremises = dropdownItemsOnboardingUseOfPremise[0].value;
//         _mda = dropdownItemsOnboardingOccupationCat[0].value;
//         _state = dropdownItemsStates[0].value;
//         _lga = dropdownItemsLGAs[0].value;
        
//         getStates();
//         initStateVariables();
//         checkLocationServiceStatus();
//         super.initState();
//     }

//     initStateVariables() async{
//       Map<String, dynamic> resZones = await zc.getZones();
      
//       if(resZones["status"] == "SUCCESS"){ 

//             zoneList.clear();
//             if(dropdownItemsZones.length > 1){
//                dropdownItemsZones.removeRange(1, dropdownItemsZones.length); 
//             }
//             zoneList = resZones["data"];
//             zoneList.forEach((element) {
//               dropdownItemsZones.add(
//                   DropdownMenuItem(
//                     child: Text(element.ibcName, overflow: TextOverflow.visible,),
//                     value: element.ibcId.toString(),
//                   ),
//               );
//             }); 

//             //fetch the report categories
//       }
      
//       if(resZones != null){
//           setState(() {
//             isLoading = false;
//           });
//       }
        
//     }

//     getStates() async{
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

//     getLGAsByState(String state) async{

//         //if(dropdownItemsLGAs.length > 1){
//           //dropdownItemsLGAs.removeRange(1, dropdownItemsLGAs.length);
//         //}
//         _lga = dropdownItemsLGAs[0].value;
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
//                 value: element.lgaName,
//               ),
//             );
//           });

//           dropdownItemsLGAs.clear();
//           setState(() {
//              dropdownItemsLGAs = dropdownItemsLs;
//           });
//           _lga = dropdownItemsLGAs[0].value;

//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No LGAs found for the selected State");
//         }
//         Navigator.pop(context);

//       }

//     getFeedersByZone(String zone) async{
        
//         //dropdownItemsFeeders.clear();
//         _selectedFeeder = dropdownItemsFeeders[0].value;
//         onBoardingActiveDTR = null;
        
//         if(dropdownItemsFeeders.length > 1){
//           dropdownItemsFeeders.removeRange(1, dropdownItemsFeeders.length);
//         }
//         setState(() {
//           _zone = zone;
//           print(_zone);
//         });
        
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving feeders");
//         Map<String, dynamic> res = await fc.getFeederByZone(zone);
         
//         if(res["status"] == "SUCCESS"){  
//           feederList.clear();
//           feederList = res["data"];
//           feederList.forEach((element) {
//             dropdownItemsFeeders.add(
//                 DropdownMenuItem(
//                   child: Text(
//                     element.feederName,
//                     overflow: TextOverflow.visible,
//                   ),
//                   value: element.feederName+"|"+element.feederId,
//                 ),
//             );
//          }); 
//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No Feeder found for the selected Zone");
//         }
//         Navigator.pop(context);
     
    
//     }

//     getDTRByFeeder(String feeder) async{
        
//         onBoardingActiveDTR = null;
//         var f = feeder.split("|");
//         if(f.length < 2){
//           return;
//         }
        
//         _feederId = f[1];
//         _feederName = f[0];
//         print("feederId: "+_feederId);
//         print("feedername: "+_feederName);

//         if(dropdownItemsDTR.length > 1){
//             dropdownItemsDTR.removeRange(1, dropdownItemsDTR.length);
//         }
//         setState(() {
//             _selectedFeeder = feeder;   
//         });
//         print(_selectedFeeder);   
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving DTRS");
//         Map<String, dynamic> res = await dtrc.getDTRByFeeder(_feederId);

//         if(res["status"] == "SUCCESS"){  
//           dtrList.clear();
//           dtrList = res["data"];
//           //Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingDTRScreen(dtrList)));

//           dtrList.forEach((element) {
//             dropdownItemsDTR .add(
//                 DropdownMenuItem(
//                   child: Text(element.dtrName, overflow: TextOverflow.ellipsis,),
//                   value: element.dtrName+"|"+element.dtrId,
//                 ),
//             );
//          }); 

//         }
//          else{
//           _showSnackBar(isSuccessSnack: false, msg: "No DTR found for the selected Feeder");
//         }
        
//         Navigator.pop(context);
    
//     }

//     checkLocationServiceStatus() async{

//         // checkLocationServiceStatus();
//         try{
//             latLng = await LocationService.checkLocationPermissionStatus(context);
//             if(!latLng["isServiceEnabled"]){
//                 _showSnackBar(isSuccessSnack: false, msg: "Please turn on your location service");
//             }
//         }
//         catch(e){
//             print("ireport-eLog: system couldn't check location service status");
//         }
        
//     }

//     //Function: snackbar for creating and displaying widget
//     void _showSnackBar({bool isSuccessSnack, String msg}){

//           //create snackbar
//           var snackBar =  SnackBar(
//               backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
//               content: Text(msg,
//               style: TextStyle(
//                 color: Colors.white
//               ),),
//           );

//           //show snackbar
//           scaffoldKey.currentState.showSnackBar(snackBar);
//     }


//   //set the images, selected in the "ImageGridView" widget
//   //To achieve this, "lifting up the state" concept is employed
//   //i.e passing a reference of the function to the "ImageGridView" widget
//   //On image selection, the function is executed and the "image" propertiy is set
  
//   _setImages(List<File> imageList){
//       if(imageList.length > 3){
//           _showSnackBar(
//             isSuccessSnack: false, 
//             msg: "Not more than 3 images can be uploaded!"
//             );
//           return;
//       }else{
//         setState(() {
//           displayImageList = imageList;
//         });
//       }

//       print("display length: ${displayImageList.length}");
//       print("passport length: ${passportImageList.length}");
//   }

//   _setPassport(List<File> imageList){
//       if(imageList.length > 1){
//           _showSnackBar(
//             isSuccessSnack: false, 
//             msg: "Only one image can be captured for passort!"
//             );
//           return;
//       }else{
//         setState(() {
//           passportImageList = imageList;
//         });
//       }
//       print("display length: ${displayImageList.length}");
//       print("passport length: ${passportImageList.length}");
//   }


//   showErrorDialog(String errMsg){
//     showAlertDialog(
//       context: context, 
//       isLoading: false, 
//       isSuccess: false,
//       completedMsg: errMsg
//     );
//   }

//   bool validateDropdownInput(){
      
//       setState(()=>isLoading = false); 

//       print(_bookCode);
//       if(_obCategory.toString().length < 1 || _obCategory == null){
//           showErrorDialog("Please select onboarding action category");
//           return false;
//       }
//       if(_surname.toString().length < 1 || _surname == null){
//           showErrorDialog("Please enter a customer surname to continue");
//           return false;
//       }
//       if(_otherNames.toString().length < 1 || _otherNames == null){
//           showErrorDialog("Please complete the other names field to continue");
//           return false;
//       }
//       if(_state.toString().length < 1 || _state == null){
//           showErrorDialog("Please select a state to continue");
//           return false;
//       }
//       if(_lga.toString().length < 1 || _lga == null){
//           showErrorDialog("Please select an LGA to continue");
//           return false;
//       }
//       if(_houseNo.toString().length < 1 || _houseNo == null){
//           showErrorDialog("Please enter the house number to continue");
//           return false;
//       }
//       if(_streetName.toString().length < 1 || _streetName == null){
//           showErrorDialog("Please enter the street name to continue");
//           return false;
//       }
//       if(_landMark.toString().length < 1 || _landMark == null){
//           showErrorDialog("Please select a land mark to continue");
//           return false;
//       }
//       if(latitude.toString().trim().length == 0 || latitude == null){
//          showErrorDialog("No coordinate selected. Get your coordinate by tapping on the Get Coordinate button. Check to see that your location service is turned on");
//          return false;
//       }
//       if(longitude.toString().trim().length == 0 || longitude == null){
//          showErrorDialog("No coordinate selected. Get your coordinate by tapping on the Get Coordinate button. Check to see that your location service is turned on");
//          return false;
//       }
//        if(_typeOfPremises.toString().length < 1 || _typeOfPremises == null){
//           showErrorDialog("Please select the type of premises");
//           return false;
//       }
//       if(_useOfPremises.toString().length < 1 || _useOfPremises == null){
//           showErrorDialog("Please select use of premises to continue");
//           return false;
//       }
//        if(_phoneNumber1.toString().length < 1 || _phoneNumber1== null){
//           showErrorDialog("Please enter phone number1 to continue");
//           return false;
//       }
//       if(_meanOfId.toString().length < 1 || _meanOfId == null){
//           showErrorDialog("Please select a mean of indentification");
//           return false;
//       }
//       if(_nearbyAccountNo.toString().length < 1 || _nearbyAccountNo == null){
//           showErrorDialog("Please enter a nearby account no to continue");
//           return false;
//       }
//       if(_zone.toString().length < 1 || _zone == null){
//           showErrorDialog("Please select a zone to continue!");
//           return false;
//       }
//       if(_feederId.toString().length < 1 || _feederId == null){
//           showErrorDialog("Please select a feeder to continue!");
//           return false;
//       }
//       if(_feederName.toString().length < 1 || _feederName == null){
//           showErrorDialog("Please select a feeder to continue!");
//           return false;
//       }
//       if(_dtrName.toString().length < 1 || _dtrName == null){
//           showErrorDialog("Please select a DTR to continue!");
//           return false;
//       }
//       if(_dtrCode.toString().length < 1 || _dtrCode == null){
//           showErrorDialog("Please select a DTR to continue!");
//           return false;
//       }
//       if(_bookCode.toString().length < 1 || _bookCode == null){
//           showErrorDialog("Please select a book code to continue");
//           return false;
//       }
     
//       return true;
    
//   }


//   setCustomerDefautValues(){
    
//     /*
//       if(_customerEmail == null || _customerEmail.toString().trim().length == 0){
//           _customerEmail = "N/A";
//       }
//       if(_customerPhoneNo == null || _customerPhoneNo.toString().trim().length == 0){
//           _customerPhoneNo = "N/A";
//       }
//       if(_customerAccountNo == null || _customerAccountNo.toString().trim().length == 0){
//           _customerAccountNo = "N/A";
//       }
//       if(_customerName == null || _customerName.toString().trim().length == 0){
//           _customerName = "N/A";
//       }
//       if(_customerAddress == null || _customerAddress.toString().trim().length == 0){
//           _customerAddress = "N/A";
//       }
//       if(_customerComment == null || _customerComment.toString().trim().length == 0){
//           _customerComment = "N/A";
//       }
//       if(_customerAccountName == null || _customerAccountName.toString().trim().length == 0){
//           _customerAccountName = "N/A";
//       }
    
//     */
      
//   }


//   /*
//   * This method handles the submission process
//   */
//   void _completeSubmitAction() async{

//         String filePaths;
//         String passport;
//         //validate input
//         if(!_formKey.currentState.validate()){
//             setState(()=>isLoading = false); 
//             showAlertDialog(
//               context: context, 
//               isLoading: false, 
//               isSuccess: false, 
//               completedMsg: "Ooops...\nAll fields were not properly completed"
//             );
          
//             return;
//         }

//         if(!validateDropdownInput()){
//           return;
//         }

//         _formKey.currentState.save();
//         setCustomerDefautValues();
      
     
//          //display loading dialog
//         setState(()=>isLoading = true);
         
            
//         Map<String, dynamic> imageUploadRes;


//           //A passport image exist
//             if(passportImageList.length > 0){
//                 imageUploadRes = await imageUploadController.uploadImagesToServer(passportImageList, senderFlag: "ir");

//                 //image was not uploaded successfully
//                 if(!imageUploadRes["isSuccessful"]){
//                     setState(()=>isLoading = false); 
//                     showAlertDialog(
//                       context: context, 
//                       isLoading: false, 
//                       isSuccess: false, 
//                       completedMsg: imageUploadRes['msg'].toString()
//                     );
                    
//                     //uncomment if the 'return' statement is removed
//                     //filePaths = null;
//                     return;
//                 }

//                 passport = imageUploadRes["data"];
//             }
//             // No passport image uploaded
//             else{
//                 print("no image uploaded for the passport");
//                 _showSnackBar(isSuccessSnack: false, msg: "No image uploaded for the passport. Please add an image for passport");
//                 setState(()=>isLoading = false);

//                 //uncomment if the 'return' statement is removed
//                 //filePaths = null;
//                 return;
//             }

          
//             //atleast one image was selected
//             if(displayImageList.length > 0){
//                 imageUploadRes = await imageUploadController.uploadImagesToServer(displayImageList, senderFlag: "ir");

//                 //image was not uploaded successfully
//                 if(!imageUploadRes["isSuccessful"]){
//                     setState(()=>isLoading = false); 
//                     showAlertDialog(
//                       context: context, 
//                       isLoading: false, 
//                       isSuccess: false, 
//                       completedMsg: imageUploadRes['msg'].toString()
//                     );
                    
//                     //uncomment if the 'return' statement is removed
//                     //filePaths = null;
//                     return;
//                 }

//                 filePaths = imageUploadRes["data"];
//             }
//             // no image was uploaded
//             else{
//               /*print("no image uploaded");
//                 _showSnackBar(isSuccessSnack: false, msg: "No image uploaded. Please add atleast 1 image");
//                 setState(()=>isLoading = false);
//                 //uncomment if the 'return' statement is remove
//                 //return;
//               */
//               filePaths = "[]";
//             }
           
//             //The DateFormat method is from the intl package
//             //String formattedDate = DateFormat('yyyy-MM-dd:kk:mm').format(DateTime.now());
 

//             //create form data
//             Map<String,dynamic> data = {
//                 "ApplicantsSignature":  _applicantSignature == null ? "N/A" : _applicantSignature,
//                 "BookCode": _bookCode == null ? "N/A" : _bookCode,
//                 "CapturedBy": authenticatedStaff.name,
//                 "CommunityName": _communityName == null ? "N/A" : _communityName,
//                 "CustomerEmail": _customerEmail == null ? "N/A" : _customerEmail,
//                 "CustomerLoad": _customerLoad == null ? "N/A" : _customerLoad,
//                 "DTRCode": _dtrCode == null ? "N/A" : _dtrCode,
//                 "DTRName": _dtrName == null ? "N/A" : _dtrName,
//                 "FeederId": _feederId == null ? "N/A" : _feederId,               
//                 'FeederName': _feederName == null ? "N/A" : _feederName,
//                 'filePaths': filePaths == null ? "N/A" : filePaths,
//                 "HouseNo": _houseNo == null ? "N/A" : _houseNo,
//                 'LandMark': _landMark == null ? "N/A" : _landMark,
//                 "Latitude": latitude,
//                 "Longitude": longitude,
//                 "LGA": _lga == null ? "N/A" : _lga,
//                 "MDA": _mda == null ? "N/A" : _mda,
//                 "MeansOfIdentification": _meanOfId == null ? "N/A" : _meanOfId,
//                 'MeterNo': _meterNo == null ? "N/A" : _meterNo,
//                 "NearbyAccountNo": _nearbyAccountNo == null ? "N/A" : _nearbyAccountNo,
//                 "Occupation": _occupation == null ? "N/A" : _occupation,
//                 "OfficeEmail": _officeEmail == null ? "N/A" : _officeEmail,
//                 "DebulkingNumber": _debulkingNumber == null ? "N/A" : _debulkingNumber,
//                 "OnboardCategory": _obCategory == null ? "N/A" : _obCategory,
//                 "OtherNames": _otherNames == null ? "N/A" : _otherNames,
//                 "ParentAccountNo": _parentAccountNo == null ? "N/A" : _parentAccountNo,
//                 "Passport": passport == null ? "N/A" : passport,
//                 "PhoneNumber1": _phoneNumber1 == null ? "N/A" : _phoneNumber1,
//                 "PhoneNumber2": _phoneNumber2 == null ? "N/A" : _phoneNumber2,
//                 "State": _state == null ? "N/A" : _state,
//                 "Status": _status == null ? "N/A" : _status,
//                 "StreetName": _streetName == null ? "N/A" : _streetName,
//                 "Surname": _surname == null ? "N/A" : _surname,
//                 "TypeOfMeterRequired": _typeOfMeterRequired == null ? "N/A" : _typeOfMeterRequired,
//                 "TypeOfPremises": _typeOfPremises == null ? "N/A" : _typeOfPremises,
//                 "UseOfPremises": _useOfPremises == null ? "N/A" : _useOfPremises,
//                 "UserId": authenticatedStaff.staffId,
//                 "ZipCode": _zipCode == null ? "N/A" : _zipCode,
//                 "Zone": _zone == null ? "N/A" : _zone,
//             };

//             print("Onboarding000 => "+ json.encode(data));

           
           
//             Map<String, dynamic> res;
//             res = await model.submit(data);
//             //submission was successful
//             if(res != null){
//               if(res['isSuccessful']){
//                 setState(()=>isLoading = false); 
//                 showAlertDialog(
//                   context: context,
//                   navigateTo: '/modules',
//                   isLoading: false, 
//                   isSuccess: true, 
//                   completedMsg: res['msg']);
//               }
//               //submission failed
//               else{
//                 setState(()=>isLoading = false); 
//                 showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
//               }
//             }
            
           
            
//         /*
//         setState(()=>isLoading = true);
//         Future.delayed( Duration(seconds: 2), (){  
//           setState(()=>isLoading = false); 
//           showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: "Operation successful");         
//         });
//         */

      
//     }

//     void _getGeoPoints() async{

//         showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching cordinates...");
      
//         try{
//           var latLng = await LocationService.checkLocationPermissionStatus(context);
//           print(latLng.toString());
          
//           if(latLng["isServiceEnabled"] && latLng["latitude"] != null && latLng["longitude"] != null){
              
//               setState(() {
//                 latitude = latLng["latitude"];
//                 longitude = latLng["longitude"];
//               }); 
//               print(latLng["latitude"]);
//           }
          
//         }
//         catch(e){
//             print("dc_details: error fetching lat/lng");
//             print("dc_details: "+e.toString());
//         }
        
//         Navigator.of(context).pop();
//         print(longitude);
//         print(latitude);
            
//       }


//   //builds textfield surname
//   Widget _buildSurnameTextField(){
//       return TextFormField(
//         //keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Applicant Surname",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _surname = value,
//         onSaved: (newValue) => _surname = newValue,
//       );
//   }

//   //builds textfield for other names
//   Widget _buildOtherNamesTextField(){
//       return TextFormField(
//         //keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Other Names",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _otherNames = value,
//         onSaved: (newValue) => _otherNames = newValue,
//       );
//   }

//   //builds textfield for house no
//   Widget _buildHouseNoTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "House Number",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _houseNo = value,
//         onSaved: (newValue) => _houseNo = newValue,
//       );
//   }

//   //builds textfield for street name
//   Widget _buildStreetNameTextField(){
//       return TextFormField(
//         //keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "StreetName",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _streetName = value,
//         onSaved: (newValue) => _streetName = newValue,
//       );
//   }


//   //builds textfield for community
//   Widget _buildCommunityNameTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Community/Village Name",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _communityName = value,
//         onSaved: (newValue) => _communityName = newValue,
//       );
//   }

//   //builds textfield for land mark
//   Widget _buildLandmarkTextField(){
//         return TextFormField(
//           decoration: InputDecoration(
//               labelText: "Landmark",
//               hintText: "Enter here",
//               fillColor: Colors.white,
//               filled: true 
//           ),
//           onChanged: (value) => _landMark = value,
//           onSaved: (newValue) => _landMark = newValue,
//         );
//     }

  
//   //builds the text field for zip code
//   Widget _buildZipCodeTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Zip Code(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _zipCode = value,
//         onSaved: (newValue) => _zipCode = newValue,
//       );
//   }
  
//   /*
//   //builds the text field for Other Premise Type
//   Widget _buildOtherPremiseTypeTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//             labelText: "Other Premise Types (Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _otherNames = newValue,
//       );
//   }
//   */
//   //builds the text field for occupation
//   Widget _buildOccupationTextField(){
//       return TextFormField(
//         //keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Occupation(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _occupation = value,
//         onSaved: (newValue) => _occupation = newValue,
//       );
//   }

//    //builds the text field for phone number 1
//   Widget _buildPhoneNumber1TextField(){
//       return TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Phone Number 1",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _phoneNumber1 = value,
//         onSaved: (newValue) => _phoneNumber1 = newValue,
//       );
//   }

//   //builds the text field for phone number 2
//   Widget _buildPhoneNumber2TextField(){
//       return TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Phone Number 2(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _phoneNumber2 = value,
//         onSaved: (newValue) => _phoneNumber2 = newValue,
//       );
//   }

//   //builds the text field Customer personal Email
//   Widget _buildPersonalEmailTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//             labelText: "Personal Email(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _customerEmail = value,
//         onSaved: (newValue) => _customerEmail = newValue,
//       );
//   }

//   //builds the text field for customer official Email
//   Widget _buildOfficialEmailTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//             labelText: "Official Email(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _officeEmail = value,
//         onSaved: (newValue) => _officeEmail = newValue,
//       );
//   }

//   //builds the text field for customer load
//   Widget _buildCustomerLoadTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Customer Load(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _customerLoad = value,
//         onSaved: (newValue) => _customerLoad = newValue,
//       );
//   }

//   //builds the text field for customer load
//   Widget _buildParentAccountNoTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Parent Account Number",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _parentAccountNo = value,
//         onSaved: (newValue) => _parentAccountNo = newValue,
//       );
//   }

//   //builds the text field for customer load
//   Widget _buildExistingMeterNoTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Existing Meter Number(If any)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _meterNo = value,
//         onSaved: (newValue) => _meterNo = newValue,
//       );
//   }

//   //builds the text field for number of account seperation
//   Widget _buildNoOfAccountSeperationTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Number of account seperation",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _debulkingNumber = value,
//         onSaved: (newValue) => _debulkingNumber = newValue,
//       );
//   }

//   //builds the text field for nearbyAccountNo
//   Widget _buildNearbyAccountNoTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Nearby Account Number",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _nearbyAccountNo = value,
//         onSaved: (newValue) => _nearbyAccountNo = newValue,
//       );
//   }

//   //builds the text field for bookcode
//   Widget _buildBookCodeTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Book Code",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onChanged: (value) => _bookCode = value,
//         onSaved: (newValue) {
//           _bookCode = newValue;
//           print(_bookCode);
//         } 
//       );
//   }


//   //builds the dropdown for Zones
//   Widget _buildDropDownButtonZones(){
//       Widget dropdownButton;
//       dropdownButton = Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(8.0),
//         height: 60.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)
//         ),
//         child: DropdownButton(
//           //the list "dropdownItemsZones" is from "lib/data/dropdown_btn_list.dart"
//           items: dropdownItemsZones,
//           onChanged: (dynamic value){
//             getFeedersByZone(value);
//           },
//           value: _zone,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//           ),
//         ),
//       );

//       return dropdownButton;
//   }
   
//   //builds the dropdown for Feeders
//   Widget _buildDropDownButtonFeeders(){
//       Widget dropdownButton;
//       dropdownButton = Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(8.0),
//         height: 60.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)
//         ),
//         child: DropdownButton(
//           //the list "dropdownItemsFeeders" is from "lib/data/dropdown_btn_list.dart"
//           items: dropdownItemsFeeders,
//           onChanged: (dynamic value){
//             getDTRByFeeder(value);
            
//           },
//           value: _selectedFeeder,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//           ),
//         ),
//       );

//       return dropdownButton;
//   }

//   //build date selection button
//   Widget _buildGeoPointsButton(){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             RaisedButton(
//               child: Text("Get Cordinates**", style: TextStyle(color: Colors.red)),
//               onPressed: _getGeoPoints,
//               color: Colors.white,
//             ),
//             Text(
//               latitude == null ? "" : "$latitude / $longitude",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600
//               ),
//             ),
//           ],
//       );
      
//     }

//   navigateToDTRScreen() async{
//       String results = await Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingDTRScreen(dtrList, _feederName)));
      
//       if(results == null || results.toString().trim().length < 1){
//         return;
//       }
//       setState(() {
//           onBoardingActiveDTR = results;
//           var selDTR = onBoardingActiveDTR.split("|");
//           _dtrName = selDTR[0].trim();
//           _dtrCode = selDTR[1].trim();
//           print("dtrN: "+ _dtrName);
//           print("dtrC: "+ _dtrCode);
//           print("feederId: "+ _feederId);
//           print("feederName: "+ _feederName);

//       });
//   }

//   //build date selection button
//   Widget _buildChooseDTRButton(){
//       return Row(
//         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           RaisedButton(
//           child: Text("Select DTR**", style: TextStyle(color: Colors.red, fontSize: 10.0, fontWeight: FontWeight.bold)),
//           onPressed: (){
//               if(_selectedFeeder.toString().trim().length < 1 || _selectedFeeder == null){
//                   showAlertDialog(
//                     context: context, 
//                     isLoading: false, 
//                     isSuccess: false, 
//                     completedMsg: "Please select a feeder to continue"
//                   );
//                   return;
//               }
//               else{
//                 onBoardingActiveDTR = null;
//                 navigateToDTRScreen(); 
//               }
              
//           },
//           color: Colors.white,
//             ),
//           SizedBox(width: 5.0,),
//           Container(
//             width: MediaQuery.of(context).size.width - 150,
//             child: Text(
//             onBoardingActiveDTR == null ? '': onBoardingActiveDTR,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 14
//             ),
//             overflow: TextOverflow.visible,
//             //maxLines: 2,
//               ),
//           ),
//         ],
//     );  
// }


//  Widget _buildDropDownObCategory(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingCategory,
//         onChanged: (dynamic value){
//           print("onboarding action: $value");
//           setState(() {
//             _obCategory = value;
//           });
         
//         },
//         value: _obCategory,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//  // dropdown for type of premises
//  Widget _buildDropDownTypeOfPremises(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingTypeOfPremise,
//         isExpanded: true,
//         onChanged: (dynamic value){
//           print("type of premises: $value");
//           setState(() {
//             _typeOfPremises = value;
//           });
         
//         },
//         value: _typeOfPremises,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//   // dropdown for use of premises
//  Widget _buildDropdownUseOfPremise(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingUseOfPremise,
//         isExpanded: true,
//         onChanged: (dynamic value){
//           print("use of premises: $value");
//           setState(() {
//             _useOfPremises = value;
//           });
//         },
//         value: _useOfPremises,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//  // dropdown for type of premises
//  Widget _buildDropDownMeansOfIdentification(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingID,
//         isExpanded: true,
//         onChanged: (dynamic value){
//           print("Means of identification: $value");
//           setState(() {
//             _meanOfId= value;
//           });
         
//         },
//         value: _meanOfId,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//   // dropdown for type of meter required
//  Widget _buildDropdownTypeOfMeterRequred(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingMeterRequired,
//         isExpanded: true,
//         onChanged: (dynamic value){
//           print("Type of meter required: $value");
//           setState(() {
//             _typeOfMeterRequired = value;
//           });
//         },
//         value: _typeOfMeterRequired,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//  // dropdown for type MDA
//  Widget _buildDropdownMDA(){
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(2.0),
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//         ],
//         borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsOnboardingOccupationCat,
//         isExpanded: true,
//         onChanged: (dynamic value){
//           print("MDA: $value");
//           setState(() {
//             _mda = value;
//           });
//         },
//         value: _mda,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600
//         ),
//       ),
//     );
//  }

//   //builds the dropdown for Zones
//   Widget _buildDropDownButtonState(){

//     Widget dropdownButton;
//     dropdownButton = Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         //the list "dropdownItemsZones" is from "lib/data/dropdown_btn_list.dart"
//         items: dropdownItemsStates,
//         onChanged: (dynamic value){

//           setState(() {
//             _state = value;
//             print(_state);
//           });
//           getLGAsByState(_state);
//         },
//         value: _state,
//         style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//         ),
//       ),
//     );

//     return dropdownButton;
//   }

//   //builds the dropdown for Report Description
//   Widget _buildDropDownButtonLGA(){
//     Widget dropdownButton;
//     dropdownButton = Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(8.0),
//       height: 60.0,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)
//       ),
//       child: DropdownButton(
//         items: dropdownItemsLGAs,
//         onChanged: (dynamic value){
//           //lga = null;
//           setState(() {
//             _lga = value;
//             print(_lga);
//           });

//         },
//         value: _lga,
//         style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//         ),
//       ),
//     );

//     return dropdownButton;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         appBar: AppBar(
//           title: Text("Customer Onboarding"),
//         ),
//         body:isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
//           child: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/bgg.png'),
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//                 )
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                   key: _formKey,
//                   child: Column(
//                   children: <Widget>[
//                     authenticatedStaff != null ? Container(
//                       margin: EdgeInsets.all(4.0),
//                       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(blurRadius: 4.0, offset: Offset(0, 2), color: Colors.black12)
//                         ]
//                       ),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(height: 3.0),
//                             authenticatedStaff != null ? 
//                             Text(authenticatedStaff.name,style: TextStyle(fontWeight: FontWeight.bold)): Container(), 
//                             SizedBox(height: 3.0),
//                             authenticatedStaff != null ? Text(authenticatedStaff.email.toLowerCase(),style: TextStyle(fontSize: 12.0)) : Container(),
//                             SizedBox(height: 3.0),
//                             authenticatedStaff != null ? Text(authenticatedStaff.staffId, style: TextStyle(fontSize: 12.0)) : Container()
//                           ],
//                       )
//                     ): Container(),
//                     SizedBox(height: 10.0),
//                     Text(
//                       "Please, complete the following fields",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     Divider(thickness: 2.0,),
//                     SizedBox(height: 10.0),
//                     _buildDropDownObCategory(), //action category
//                      SizedBox(height: 10.0,),
//                     _buildSurnameTextField(),
//                     SizedBox(height: 10,),
//                     _buildOtherNamesTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildDropDownButtonState(),
//                     SizedBox(height: 10.0,),
//                     _buildDropDownButtonLGA(),
//                     SizedBox(height: 10.0,),
//                     _buildHouseNoTextField(),
//                      SizedBox(height: 10.0,),
//                     _buildStreetNameTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildCommunityNameTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildLandmarkTextField(),
//                     SizedBox(height: 10.0),
//                     _buildZipCodeTextField(),
//                     SizedBox(height: 10.0),
//                     _buildDropDownTypeOfPremises(),
//                     SizedBox(height: 10.0,),
//                     _buildDropdownUseOfPremise(),
//                     SizedBox(height: 10.0),
//                     //_buildOtherPremiseTypeTextField(),
//                     // SizedBox(height: 10.0),
//                     _buildParentAccountNoTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildExistingMeterNoTextField(),
//                      SizedBox(height: 10.0,),
//                     _buildOccupationTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildDropdownMDA(),
//                      SizedBox(height: 10.0,),
//                     _buildPhoneNumber1TextField(),
//                      SizedBox(height: 10.0,),
//                     _buildPhoneNumber2TextField(),
//                      SizedBox(height: 10.0,),
//                     _buildPersonalEmailTextField(),
//                      SizedBox(height: 10.0,),
//                     _buildOfficialEmailTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildDropDownMeansOfIdentification(),
//                     SizedBox(height: 10.0,),
//                     _buildCustomerLoadTextField(),
//                      SizedBox(height: 10.0,),
//                     _obCategory == "ACCOUNT SEPERATION" ? _buildNoOfAccountSeperationTextField() : Container(),
//                      SizedBox(height: 10.0,),
//                     _buildNearbyAccountNoTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildDropdownTypeOfMeterRequred(),
//                      SizedBox(height: 10.0,),
//                    // _buildDropdownFeeder33(),
//                      SizedBox(height: 10.0,),
//                    // _buildDropdownFeeder11(),
//                     _buildDropDownButtonZones(),
//                     SizedBox(height: 10.0,),
//                    _buildDropDownButtonFeeders(),
//                     SizedBox(height: 10.0,),
//                    // _buildDropDownButtonDTR(),
//                     Padding(
//                       padding: const EdgeInsets.only(top:8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                             _buildChooseDTRButton(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10.0,),
//                     _buildBookCodeTextField(),
//                     SizedBox(height: 10.0),
//                     _buildGeoPointsButton(),
//                     SizedBox(height: 10.0),
//                     FileUploadButton(setPassport: _setPassport, buttonTitle: "Passport"),
//                     FileUploadButton(setImages:_setImages),
//                     SizedBox(height: 15.0),     
//                     SubmitButton(_completeSubmitAction, isLoading, "SUBMIT")                
//                   ],
//                 ),
//               ),
//             ),
//           ),
         

//         )
//     );
//   }
// }
