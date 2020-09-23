
// import 'dart:io';

// import '../../data/active_dtr.dart';
// import '../../screens/rpdonboarding/onboarding_dtr_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../controllers/i/i_report_controller.dart';
// import '../../controllers/image_uploader_controller.dart';
// import '../../controllers/utility/dtr_controller.dart';
// import '../../controllers/utility/feeder_controller.dart';
// import '../../controllers/utility/state_controller.dart';
// import '../../controllers/utility/zone_controller.dart';
// import '../../controllers/utility/report_category_controller.dart';
// import '../../controllers/utility/report_sub_category_controller.dart';
// import '../../data/authenticated_staff.dart';
// import '../../data/dropdown_btn_list.dart';
// import '../../models/utility/dtr.dart';
// import '../../models/utility/feeder.dart';
// import '../../models/utility/zone.dart';
// import '../../models/utility/report_category.dart';
// import '../../models/utility/report_sub_category.dart';
// import '../../services/location_service.dart';
// import '../../utilities/alert_dialog.dart';
// import '../../widgets/file_upload.dart';
// import '../../widgets/submit_btn.dart';
// import 'package:intl/intl.dart';


// class IReportHomeScreen extends StatefulWidget {
//   @override
//   _IReportHomeScreenState createState() => _IReportHomeScreenState();
// }

// class _IReportHomeScreenState extends State<IReportHomeScreen> {

//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
//     IReportController model = new IReportController();
//     ZoneController zc = ZoneController();
//     StateController sc = StateController();
//     FeederController fc = FeederController();
//     DTRController dtrc = DTRController();
//     ReportCategoryController rc = ReportCategoryController();
//     ReportSubCategoryController rsc = ReportSubCategoryController();
//     final ImageUploaderController imageUploadController = ImageUploaderController();
   
   
//     String _customerAccountNo;
//     String _customerName;
//     String _customerEmail;
//     String _customerAddress;
//     String _customerPhoneNo;
//     String _customerComment;
//     String _customerAccountName;
//     String _selectedReportCategory;
//     String _selectedZone;
//     String _selectedFeeder;
//     String _selectedDTR;
//     String _selectedSubCategory;
//     String latitude;
//     String longitude;
//     bool isLoading = true;
//     List uploadedImages = [];
//     List<File> displayImageList = List<File>();
//     //DateTime _dateTime = DateTime.now();
//     var latLng;
//     List<Zone> zoneList = [];
//     List<Feeder> feederList = [];
//     List<DTR> dtrList = [];
//     List<ReportCategory> reportCategoryList = [];
//     List<ReportSubCategory> reportSubCatList = [];

        

//     @override
//     void initState(){
//         _selectedReportCategory = dropdownItemsReportCategory[0].value;
//         _selectedFeeder = dropdownItemsFeeders[0].value;
//         _selectedZone = dropdownItemsZones[0].value;
//         _selectedDTR = dropdownItemsDTR[0].value;
//         _selectedSubCategory = dropdownItemsSubCategory[0].value;
        
//         initStateVariables();
//         checkLocationServiceStatus();
//         super.initState();
//     }

//     initStateVariables() async{
//       Map<String, dynamic> resZones = await zc.getZones();
//       Map<String, dynamic> reportCategory = await rc.getReportCategory(); 
      
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
       
//       if(reportCategory["status"] == "SUCCESS"){
//         reportCategoryList.clear();
//         reportCategoryList = reportCategory["data"];

//           if(dropdownItemsReportCategory.length > 1){
//             dropdownItemsReportCategory.removeRange(1, dropdownItemsReportCategory.length);
//           }
        
//           reportCategoryList.forEach((element) {
//           dropdownItemsReportCategory.add(
//               DropdownMenuItem(
//                 child: Text(element.reportCatName, overflow: TextOverflow.visible),
//                 value: element.reportCatId,
//               ),
//           );
//         }); 
//       }

//       if(resZones != null && reportCategory != null){
//           setState(() {
//             isLoading = false;
//           });
//       }
        
//     }

//     getFeedersByZone(String zone) async{

//         _selectedFeeder = dropdownItemsFeeders[0].value;
//         if(dropdownItemsFeeders.length > 1){
//           dropdownItemsFeeders.removeRange(1, dropdownItemsFeeders.length);
//         }
//         setState(() {
//           _selectedZone = zone;
//           print(_selectedZone);
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
//                   value: element.feederId,
//                 ),
//             );
//          }); 

//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No Feeder found for the selected Zone");
//         }
//         Navigator.pop(context);
     
//     }

//     getDTRByFeeder(String feederId) async{

//         if(dropdownItemsDTR.length > 1){
//             dropdownItemsDTR.removeRange(1, dropdownItemsDTR.length);
//         }
//         setState(() {
//             _selectedFeeder = feederId;
//         });
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving DTRS");
//         Map<String, dynamic> res = await dtrc.getDTRByFeeder(feederId);

//         if(res["status"] == "SUCCESS"){  
//           dtrList.clear();
//           dtrList = res["data"];
//           dtrList.forEach((element) {
//             dropdownItemsDTR .add(
//                 DropdownMenuItem(
//                   child: Text(element.dtrName, overflow: TextOverflow.ellipsis,),
//                   value: element.dtrId,
//                 ),
//             );
//          }); 

//         }
//          else{
//           _showSnackBar(isSuccessSnack: false, msg: "No DTR found for the selected Feeder");
//         }
        
//         Navigator.pop(context);
    
//     }

//     getReportSubCat(String reportCategoryId) async{
         
//         if(dropdownItemsSubCategory.length > 1){       
//             setState(() {
//                 dropdownItemsSubCategory.removeRange(1, dropdownItemsSubCategory.length);
//             });
//         }
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving sub report categories");
//         Map<String, dynamic> res = await rsc.getSubReportCategory(reportCategoryId);
//         if(res["status"] == "SUCCESS"){  
//           reportSubCatList.clear();
//           reportSubCatList = res["data"];          
//           reportSubCatList.forEach((element) {
//           dropdownItemsSubCategory.add(
//                 DropdownMenuItem(
//                   child: Text(element.reportSubCatName, overflow: TextOverflow.visible),
//                   value: element.reportSubCatId,
//                 ),
//             );
//           });  
//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No Sub category for the selected category");
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

//       print("length: ${displayImageList.length}");
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

//       if(_selectedReportCategory.length < 1 || _selectedReportCategory == null){
//           showErrorDialog("Please select a report category");
//           return false;
//       }
//       if(_selectedSubCategory.length < 1 || _selectedSubCategory == null){
//           showErrorDialog("Please select a sub report category");
//           return false;
//       }
//       if(_selectedZone.length < 1 || _selectedZone == null){
//           showErrorDialog("Please select a zone!");
//           return false;
//       }
//       if(_selectedFeeder.length < 1 || _selectedFeeder == null){
//           showErrorDialog("Please select a feeder!");
//           return false;
//       }
//       if(_selectedDTR.length < 1 || _selectedDTR == null){
//           showErrorDialog("Please select a DTR");
//           return false;
//       }
//       if(latitude.toString().trim().length == 0 || latitude == null){
//          showErrorDialog("No coordinate selected. Get your coordinate by tapping on the Get Coordinate button");
//       }
//       if(longitude.toString().trim().length == 0 || longitude == null){
//          showErrorDialog("No coordinate selected. Get your coordinate by tapping on the Get Coordinate button");
//       }

//       return true;
    
//   }


//   setCustomerDefautValues(){

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
      
//   }


//   /*
//   * This method handles the submission process
//   */
//   void _completeSubmitAction() async{

    
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

//        if(!validateDropdownInput()){
//          return;
//        }

//         _formKey.currentState.save();
//         setCustomerDefautValues();
      
     
//          //display loading dialog
//         setState(()=>isLoading = true);
         
//             String filePaths;
//             Map<String, dynamic> imageUploadRes;

          
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
//               print("no image uploaded");
//               _showSnackBar(isSuccessSnack: false, msg: "No image uploaded. Please add atleast 1 image");
//               setState(()=>isLoading = false);

//               //uncomment if the 'return' statement is removed
//               //filePaths = null;
//               return;
//             }
           
//             //The DateFormat method is from the intl package
//             String formattedDate = DateFormat('yyyy-MM-dd:kk:mm').format(DateTime.now());


//             //create form data
//             Map<String,dynamic> data = {
//                 "Zone": _selectedZone,
//                 "CustomerName": _customerName == null ? "N/A" : _customerName,
//                 "IreportersPhoneNo": authenticatedStaff.phoneNo,
//                 "IreportersEmail": authenticatedStaff.email,
//                 "Status": "Status Ireport",
//                 "FeederId": _selectedFeeder,
//                 "CustomerAccountName": _customerAccountName == null ? "N/A" : _customerAccountName,
//                 "CustomerAddress": _customerAddress == null ? "N/A" : _customerAddress,
//                 "DTR_Id": _selectedDTR,               
//                 'Comments': _customerComment == null ? "N/A" : _customerComment,
//                 'StaffId': authenticatedStaff.staffId,
//                 "ReportCategory": _selectedReportCategory,
//                 'ReportSubCategory': _selectedSubCategory,
//                 "CustomerPhoneNo": _customerPhoneNo == null ? "N/A" : _customerPhoneNo,
//                 "CustomerEmail": _customerEmail == null ? "N/A" : _customerEmail,
//                 "CustomerAccountNo": _customerAccountNo == null ? "N/A" : _customerAccountNo,
//                 'DateReported': formattedDate,
//                 "Latitude": latitude,
//                 "Longitude": longitude,
//                 "UserId": authenticatedStaff.id,
//                 "filePaths": filePaths
//             };

           
           
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


//     //builds the text field for entering the customer account no
//   Widget _buildAccountNoTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Customer Account No(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerAccountNo = newValue,
//       );
//   }


//   Widget _buildAccountNameTextField(){
//         return TextFormField(
//           decoration: InputDecoration(
//               labelText: "Customer Account Name(Optional)",
//               hintText: "Enter here",
//               fillColor: Colors.white,
//               filled: true 
//           ),
//           onSaved: (newValue) => _customerAccountName = newValue,
//         );
//     }

  
//   //builds the text field for entering the customer name
//   Widget _buildNameTextField(){
//       return TextFormField(
//         decoration: InputDecoration(
//             labelText: "Customer Name(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerName = newValue,
//       );
//   }

//   //builds the text field for entering the customer email
//   Widget _buildEmailTextField(){

//       return TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//             labelText: "Customer Email(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerEmail = newValue,
//       );
//   }

//   //builds the text field for entering the customer address
//   Widget _buildAddressTextField(){
//       return TextFormField(
//         maxLines: 3,
//         decoration: InputDecoration(
//             labelText: "Customer Address(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerAddress = newValue,
//       );
//   }

//   //builds the text field for entering the customer address
//   Widget _buildPhoneTextField(){
//       return TextFormField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//             labelText: "Customer Phone No(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerPhoneNo = newValue,
//       );
//   }

//   //builds the dropdown for Nature of Report
//   Widget _buildDropDownButtonReportCategory(){
//       Widget dropdownButton;
//       dropdownButton = Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(16.0),
//         height: 60.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 6.0, offset: Offset(0,3), color: Colors.black12)
//           ],
//           borderRadius: BorderRadius.circular(5.0)
//         ),
//         child: DropdownButton(
//           //the list "dropdownItemsNatureOfReport" is from "lib/data/dropdown_btn_list.dart"
//           items: dropdownItemsReportCategory,
//           onChanged: (dynamic value){
//             setState(() {
//               _selectedReportCategory = value;
//             });
//             print(_selectedReportCategory);
//             getReportSubCat(value);
//           },
//           value: _selectedReportCategory,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//           ),
          
          
//         ),
//       );

//       return dropdownButton;
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
//             /*setState(() {
//               _selectedZone = value;
//               print(_selectedZone);
//             });
//             */
//             getFeedersByZone(value);
//           },
//           value: _selectedZone,
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

//   //builds the dropdown for Report Description
//   Widget _buildDropDownButtonReportSubCategory(){
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
//           //the list "dropdownItemsReportDesc" is from "lib/data/dropdown_btn_list.dart"
//           items: dropdownItemsSubCategory,
//           onChanged: (dynamic value){
//             setState(() {
//                _selectedSubCategory = value;
//             });
//             print(_selectedSubCategory);
//           },
//           value: _selectedSubCategory,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//           ),
//         ),
//       );

//       return dropdownButton;
//   }
  
//   //builds the dropdown for DTR
//  /* Widget _buildDropDownButtonDTR(){
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
//           //the list "dropdownItemsDTR" is from "lib/data/dropdown_btn_list.dart"
//           items: dropdownItemsDTR,
//           onChanged: (dynamic value){
//             setState(() {
//               _selectedDTR = value;
//             });
//           },
//           value: _selectedDTR,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600
//           ),
//         ),
//       );

//       return dropdownButton;
//   }
// */
//   //builds the text field for comment
//   Widget _buildCommentTextField(){
//       return TextFormField(
//         maxLines: 3,
//         decoration: InputDecoration(
//             labelText: "Comments/Hints(Optional)",
//             hintText: "Enter here",
//             fillColor: Colors.white,
//             filled: true 
//         ),
//         onSaved: (newValue) => _customerComment = newValue,
//       );
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
//       String results = await Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingDTRScreen(dtrList, "")));
      
//       if(results == null || results.toString().trim().length < 1){
//         return;
//       }
//       setState(() {
//          ireportActiveDTR = results;
//           var selDTR = ireportActiveDTR.split("|");
//           //String dtName = selDTR[0].trim();
//           _selectedDTR = selDTR[1].trim();
//           print("selectedDTR: "+ _selectedDTR);
//           print("dtrName: "+ ireportActiveDTR);
//           print("dtrName: "+ selDTR[1].toString());
        
//       });
//   }

//     //build date selection button
//     Widget _buildChooseDTRButton(){
//         return Row(
//           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             RaisedButton(
//             child: Text("Select DTR**", style: TextStyle(color: Colors.red, fontSize: 10.0, fontWeight: FontWeight.bold)),
//             onPressed: (){
//                 if(_selectedFeeder.toString().trim().length < 1 || _selectedFeeder == null){
//                     showAlertDialog(
//                       context: context, 
//                       isLoading: false, 
//                       isSuccess: false, 
//                       completedMsg: "Please select a feeder to continue"
//                     );
//                     return;
//                 }
//                 else{
//                   ireportActiveDTR = null;
//                   navigateToDTRScreen(); 
//                 }
               
//             },
//             color: Colors.white,
//               ),
//             SizedBox(width: 5.0,),
//             Container(
//               width: MediaQuery.of(context).size.width - 150,
//               child: Text(
//              ireportActiveDTR == null ? '': ireportActiveDTR,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14
//               ),
//               overflow: TextOverflow.visible,
//               //maxLines: 2,
//                 ),
//             ),
//           ],
//       );  
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         appBar: AppBar(
//           title: Text("i-Report"),
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
//                     Text("Please, complete the following fields"),
//                     Divider(thickness: 2.0,),
//                     SizedBox(height: 10.0),
//                     _buildDropDownButtonReportCategory(),
//                     SizedBox(height: 10.0,),
//                     _buildDropDownButtonReportSubCategory(),
//                     SizedBox(height: 10.0,),
//                     _buildAccountNoTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildAccountNameTextField(),
//                     SizedBox(height: 10.0,),
//                     _buildNameTextField(),
//                     SizedBox(height: 10.0),
//                     _buildPhoneTextField(),
//                     SizedBox(height: 10.0),
//                     _buildEmailTextField(),
//                     SizedBox(height: 10.0),
//                     _buildAddressTextField(),
//                     SizedBox(height: 10),
//                     _buildDropDownButtonZones(),
//                     SizedBox(height: 10.0,),
//                     _buildDropDownButtonFeeders(),
//                     SizedBox(height: 10.0,),
//                     //_buildDropDownButtonDTR(),
//                     SizedBox(height: 10.0),
//                     _buildChooseDTRButton(),
//                     _buildGeoPointsButton(),
//                     SizedBox(height: 10.0),
//                     _buildCommentTextField(),
//                     SizedBox(height: 10.0),
//                     FileUploadButton(setImages: _setImages),
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
