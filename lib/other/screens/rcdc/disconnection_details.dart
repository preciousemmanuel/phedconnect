
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/image_uploader_controller.dart';
import '../../controllers/rcdc/disconnection_controller.dart';
import '../../controllers/utility/settlement_duration_controller.dart';
import '../../data/authenticated_staff.dart';
import '../../data/data.dart';
import '../../models/customer.dart';
import '../../models/expansion_panel_item.dart';
import '../../models/payment_history.dart';
import '../../models/rcdc_incidence.dart';
import '../../models/settlement_duration.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import '../../utilities/styles.dart';
import '../../widgets/customer_info_text.dart';
import '../../widgets/expansion_panel_info.dart';
import '../../widgets/file_upload.dart';
import '../../widgets/load_calculator.dart';
import '../../widgets/remarks_text_field.dart';
import '../../widgets/submit_btn.dart';
import '../../models/customer_incidence.dart';

class DisconnectionDetailsScreen extends StatefulWidget {

  final Customer customer;  
  final String flag;
  DisconnectionDetailsScreen(this.customer, {this.flag});

  @override
  _DisconnectionDetailsScreenState createState() => _DisconnectionDetailsScreenState();
}

class _DisconnectionDetailsScreenState extends State<DisconnectionDetailsScreen> {

      FocusNode _addressFocusNode = FocusNode();
      final DisconnectionController model = DisconnectionController();
      final ImageUploaderController imageUploadController = ImageUploaderController();
      final SettlementDurationController sdc = SettlementDurationController();

      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      static final TextEditingController _avgAvailabililtyEC = TextEditingController();
      static final TextEditingController _noOfMonthEC = TextEditingController();
      final numberFormat = new NumberFormat("#,##0.00", "en_US");
  
      List<File> displayImageList = List<File>();
      List<PaymentHistory> paymentHistoryList = List<PaymentHistory>();
      List<SettlementDuration> settlementPlanList = List<SettlementDuration>();
      List<DropdownMenuItem> dropdownItemsIncidences = [
        DropdownMenuItem(
          child: Text(
            "Reason for Disconnection**",
            style: TextStyle(color: Colors.red),
          ), 
          value: "")
      ];
      List<DropdownMenuItem> dropdownItemsSettlement = [
        DropdownMenuItem(
          child: Text(
            "Payment Settlement Plan**",
            style: TextStyle(color: Colors.black),
          ), 
          value: "")
      ];

      List<ExpansionPanelRow> dtrExecutiveExpansionPanelList = [
          new ExpansionPanelRow(title: "DATE", value: "AMOUNT")
      ];

      String customerEmail;
      String customerPhone;
      String customerName;
      String customerAddress;
      String selectedIncidenceId;
      String selectedSettlementPlan;
      String remarks;
      String latitude;
      String longitude;
      bool customerDataState; //sets the state(open or close) of customer expansion panel
      bool isLoading = true; //show loading 
      List uploadedImages = [];
      List<CustomerIncidence> customerIncidences = [];
      String fileName;
      File file;
      String settlementAmount;
      bool hasSettlement = false;
      String selectedDuration;
      String settlementStatus = "NO";
      String selectedLodProfile;
      String selectedTariff;
      String selectedTariffCode;
      String selectedTariffRate;
      String selectedPhase;
      String clampValue;
      double overallTotalWattage = 0;
      double consumption = 0;
      double kw = 0;
      String avgAvailability;
      String noOfMonths;
      List<Map<String,dynamic>> listOfAppliances = List<Map<String,dynamic>>();
      
      
      @override
      void initState() {

          customerDataState = false;
          selectedIncidenceId = dropdownItemsIncidences[0].value;
          selectedDuration = dropdownItemsSettlement[0].value;
          selectedLodProfile = dropdownItemsCalculateLoadOption[0].value;
          selectedPhase = dropdownItemsPhase[0].value;
          selectedTariff = dropdownItemsTariff[0].value;
          _addressFocusNode.addListener(getKWFromClampMeter);
          

          fetchSettlementPlanList(); //fetch settlement plan
          fetchIncidenceList(); //fetch list of incidence
          fetchPaymentHistory(); //fetch customer payment history
          fetchTariffList();
          super.initState();
      }

       @override
        void dispose() {
          
          _addressFocusNode.dispose();
          super.dispose();
        }


      getKWFromClampMeter() async{
        if(!_addressFocusNode.hasFocus){

            if(clampValue == null || clampValue.toString().trim().length < 1){
              return;
            }

            try{
              //print("fkslfksf;skfs;");
              double c =  double.parse(clampValue) * 0.24 * 0.85;
              setState(() {
                kw = c;
              });
              
            }
            catch(e){
              print(e.toString());
              return;
            }
            
      
        }

      }

      /*
      * This method fetches the list of Incidences
      * builds the dropdownMenuItem for the drop down button
      */
      void fetchIncidenceList() async{

          //The 'fetchListOfIncidences' method is @ 'lib/controllers.disconnection_controller.dart'
          List<RCDCIncidence> rcdcIncidences = await model.fetchListOfIncidences();
          DropdownMenuItem dropdownMenuItem;

          rcdcIncidences.forEach((incidence) {
              dropdownMenuItem = DropdownMenuItem(
                child: Text(incidence.incidenceName.toString()),
                value: incidence.incidenceId.toString(),
              );

            dropdownItemsIncidences.add(dropdownMenuItem);
            
          });  
            setState(() {
              isLoading = false;
            });
      }

      void fetchTariffList() async{

          //The 'fetchListOfIncidences' method is @ 'lib/controllers.disconnection_controller.dart'
          Map<String,dynamic> res = await model.getTariffList();

          if(dropdownItemsTariff.length > 1){
              dropdownItemsTariff.removeRange(1, dropdownItemsTariff.length); 
          }

          if(res["status"] == "SUCCESS"){

              DropdownMenuItem dropdownMenuItem;
              res["data"].forEach((tariff) {
                dropdownMenuItem = DropdownMenuItem(
                  child: Text(tariff["TariffCode"]),
                  value: "${tariff["TariffCode"]}|${tariff["TariffRate"]}",
                );

                dropdownItemsTariff.add(dropdownMenuItem);
              
              });  

              setState(() {
                isLoading = false;
              });
          }
          else{
            _showSnackBar(
              isSuccessSnack: false, 
              msg:"Couldn't fetch tariff. If issue persist, contact admin"
            );
          }
              
      }

      /*
      * This method fetches the customer payment history
      */
      void fetchPaymentHistory() async{

          //The 'fetchListOfIncidences' method is @ 'lib/controllers.disconnection_controller.dart'
          paymentHistoryList = [];
          Map<String,dynamic> res;
          res = await model.fetchPaymentHistory(widget.customer.accountNo);

          setState(() {
              isLoading = false;
              paymentHistoryList = res["data"];
          });
          if(res["status"] != "SUCCESS"){
            _showSnackBar(
              isSuccessSnack: false, 
              msg:"No payment history found"
            );
          }
          //print(paymentHistoryList.length.toString());
      }
      

      /*
      * This method fetches the settlement plan
      */
      void fetchSettlementPlanList() async{
          Map<String, dynamic> res = await sdc.getSettlementDuration();
          settlementPlanList = res["data"];

          DropdownMenuItem dropdownMenuItem;

          settlementPlanList.forEach((spl) {
              dropdownMenuItem = DropdownMenuItem(
                child: Text(spl.settlementName.toString()),
                value: spl.settlementName.toString(),
              );

            dropdownItemsSettlement.add(dropdownMenuItem);
            
          });  
      }

      /*
      * This method calls the customer incidences
      */
      void fetchCustomerIncidences() async{

            print(selectedPhase);
            print(selectedTariff);
            print(selectedTariffCode);
            print(selectedTariffRate);

            
            
            if(selectedLodProfile.toString().length == 0 || selectedLodProfile == null){
                _showSnackBar(
                isSuccessSnack: false, 
                msg:"Please select a load profile",
                duration: 3
                );
                return;
            }

            if(selectedTariff.toString().length == 0 || selectedTariff == null){
                _showSnackBar(
                isSuccessSnack: false, 
                msg:"Please select a tariff to continue",
                duration: 3
                );
                return;
            }

            if(selectedPhase.toString().length == 0 || selectedPhase == null){
                _showSnackBar(
                isSuccessSnack: false, 
                msg:"Please select a Phase to continue",
                duration: 3
                );
                return;
            }

            
            showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving customer incidences..");

            Map<String, dynamic> data = {
              'accountNo': widget.customer.accountNo,
              'dateOfLastPayment': widget.customer.lastPayDate,
              'accountType': widget.customer.accountType,
              'reasonForDisconnectionId': selectedIncidenceId,
              'phase': selectedPhase == null || selectedPhase.toString().trim().length == 0 ? widget.customer.phase : selectedPhase,
              'tariffCode': selectedTariffCode == null || selectedTariffCode.toString().trim().length == 0 ? '': selectedTariffCode,
              'tariffRate': selectedTariffRate == null || selectedTariffRate.toString().trim().length == 0 ? '' : selectedTariffRate,
              'flag': selectedLodProfile,
              'loadProfile': selectedLodProfile == "1" ? consumption == null : consumption.toString(),
              'availability': avgAvailability,
              'duration': noOfMonths
            };

            print("fetch customer incidence initialized....");
            
            List<CustomerIncidence> tempCI = [];
            Map<String, dynamic> res;
            res = await model.fetchCustomerIncidences(data);
            tempCI = res["data"];
          

            setState(() {
                customerIncidences = tempCI;
                hasSettlement = res["hasSettlement"];
                settlementAmount = res["settlementAmount"];
                settlementStatus = "YES";
            });

            print(res["hasSettlement"]);
            print(res["settlementAmount"]);

            if(tempCI.length < 1){
                _showSnackBar(
                isSuccessSnack: false, 
                msg:"No incidence found for selected reason for disconnection",
                duration: 3
                );
            }    
            //showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: "Completed");
            Navigator.pop(context);
            print(customerIncidences);
            
      }
      

      void calculateConsumption(){

        if(selectedLodProfile == "2"){
            if(clampValue == null || clampValue.toString().trim().length == 0){
            _showSnackBar(isSuccessSnack: false, msg: "Plase enter a clamp value to proceed");
            return;
             }
        }
        if(kw.toString() == "" || kw == 0 || kw.toString().trim().length == 0){
          _showSnackBar(isSuccessSnack: false, msg: "Couldn't calculate KW for customer");
          return;
        }
        if(avgAvailability == null || avgAvailability.toString().trim().length == 0){
          _showSnackBar(isSuccessSnack: false, msg: "Plase enter the monthly availability");
          return;
        }
        if(noOfMonths == null || noOfMonths.toString().trim().length == 0){
          _showSnackBar(isSuccessSnack: false, msg: "Please enter a month");
          return;
        }
        

        // get consumption from clamp
        if(selectedLodProfile == "2"){
           double cons = 0;
           try{
              cons = kw * double.parse(avgAvailability) * double.parse(noOfMonths) * 0.6;
              setState(() {
                consumption = cons;
              });
           }
           catch(e){
             print(e.toString());
             return;
           }
          
        }
        //From load calculator
        if(selectedLodProfile == "3"){
            try{
              double cons = kw * double.parse(avgAvailability) * double.parse(noOfMonths) * 0.6;
              setState(() {
                consumption = cons;
              });
            }
            catch(e){
              print(e.toString());
              return;
            }
        }
      }



      _setImages(List<File> imageList){
          if(imageList.length > 3){
              _showSnackBar(
                isSuccessSnack: false, 
                msg: "Not more than 3 images can be uploaded!"
                );
              return;
          }else{
            setState(() {
              displayImageList = imageList;
            });
          }

          print("length: ${displayImageList.length}");
      }

      void _setRemarks(String rmks){
          remarks = rmks;
      }

      //loa = ListofAppliances
      //otw = overallTotalWattage
      _setListOfAppliances(List<Map<String,dynamic>> loa, double otw){

          setState(() {
             listOfAppliances = loa;
             overallTotalWattage = otw;
             kw = overallTotalWattage / 1000;

          });

          print("This is it: " + listOfAppliances.length.toString());
          print("This is it again $overallTotalWattage");
      }
      //Function: snackbar for creating and displaying widget
      void _showSnackBar({bool isSuccessSnack, String msg, int duration}){

            //create snackbar
            var snackBar =  SnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
                content: Text(msg,
                style: TextStyle(
                  color: Colors.white
                ),),
            );

            //show snackbar
            _scaffoldKey.currentState.showSnackBar(snackBar);
      }
      
      String validateInput(){
          
          
          if(authenticatedStaff.gangId == null){
            return "You don't have Disconnection privileges for this Gang";
          }
          
          if(customerIncidences.length < 1){
            return "An incidence(s) must be associated to a customer before he can be disconnected";
          }
          if(latitude == null || latitude.toString().trim().length == 0){
            return "Please fetch cordinates by pressing the 'Get Cordinates' button";
          }
          if(longitude == null || longitude.toString().trim().length == 0){
              return "Please fetch cordinates by pressing the 'Get Cordinates' button";
          }
          if(displayImageList.length > 3){
             return "Not more than 3 Images can be selected";
          }
          if(selectedLodProfile == "2" || selectedLodProfile == "3"){
               if(consumption == 0){
                  return "No consumption was calculated for the customer."
                  + "Please calculate the customer consumption before submission";
               }
          }
          if(selectedLodProfile == "3"){
            if(listOfAppliances.length < 1){
              return "No appliance selected. Please select an appliance";
            }
          }
          if(latitude == null || latitude.toString().trim().length == 0){
                return "No cordinates found. Use the 'Get cordintes' button to get your cordinates";
            }
            if(longitude == null || longitude.toString().trim().length == 0){
                return "No cordinates found. Use the 'Get cordintes' button to get your cordinates";
            }

            if(selectedTariff.toString().length == 0 || selectedTariff == null){
                return "Please select a tariff to continue";
            }

            if(selectedPhase.toString().length == 0 || selectedPhase == null){
                return "Please select a phase to continue";
            }


          return null;
      }
      //This method will be responsibible for making the 
      //api call to complete the disconnection process
      void completeDisconnectionAction() async{ 

            if(validateInput() != null){
              _showSnackBar(isSuccessSnack: false, msg: validateInput());
              return;
            }

            if(customerEmail == null || customerEmail.toString().trim().length == 0){
                customerEmail = "N/A";
            }
            if(customerPhone == null || customerPhone.toString().trim().length == 0){
                customerPhone = "N/A";
            }
            if(remarks == null || remarks.toString().trim().length == 0){
                remarks = "N/A";
            }
            
            if(selectedLodProfile == "1"){
              consumption = 0;
              listOfAppliances = null;
            }
           
            if(!hasSettlement){
                selectedDuration = "N/A";
                settlementAmount = "N/A";
                settlementStatus = "N/A";
            }


            print(selectedDuration);
            print(settlementAmount);
            print(settlementStatus);


            setState(()=>isLoading = true);

           
            String filePaths;
            Map<String, dynamic> imageUploadRes;

          
            //atleast one image was selected
            if(displayImageList.length > 0){
                imageUploadRes = await imageUploadController.uploadImagesToServer(displayImageList, senderFlag: "dc");

                //image was not uploaded successfully
                if(!imageUploadRes["isSuccessful"]){
                    setState(()=>isLoading = false); 
                    showAlertDialog(
                      context: context, 
                      isLoading: false, 
                      isSuccess: false, 
                      completedMsg: imageUploadRes['msg'].toString()
                    );
                    
                    //uncomment if the 'return' statement is removed
                    //filePaths = null;
                    return;
                }

                
                filePaths = imageUploadRes["data"];
                // print("file path:" +filePaths);
                // print("jd_file_path:"+ json.decode(filePaths).toString());
                // print("je_file_path: "+ json.encode(filePaths));

            }
            // no image was uploaded
            else{
              print("no image uploaded");
              _showSnackBar(isSuccessSnack: false, msg: "No image uploaded. Please add atleast 1 image");
              setState(()=>isLoading = false);

              //uncomment if the 'return' statement is removed
              //filePaths = null;
              return;
            }

          
            Map<String, dynamic> data = {
                "AccountNo": widget.customer.accountNo,
                "DateOfLastPayment": widget.customer.lastPayDate,
                "AccountType": widget.customer.accountType,
                'Phase': selectedPhase == null || selectedPhase.toString().trim().length == 0 ? widget.customer.phase : selectedPhase,
                'TariffCode': selectedTariffCode == null || selectedTariffCode.toString().trim().length == 0 ? '': selectedTariffCode,
                'TariffRate': selectedTariffRate == null || selectedTariffRate.toString().trim().length == 0 ? '' : selectedTariffRate,
                "AverageBillReading": widget.customer.avgConsumption,
                "StaffId": authenticatedStaff.staffId,
                "UserId": authenticatedStaff.id,
                "DisconnId": widget.customer.disconId,
                "Comments": remarks,
                'GangID': authenticatedStaff.gangId,
                "Longitude": latitude,
                "Latitude": longitude,
                "CustomerEmail": customerEmail,
                "CustomerPhone": customerPhone,
                "ReasonForDisconnectionId": selectedIncidenceId,
                "Settlement": selectedDuration,
                "SettlementAmount": settlementAmount,
                "SettlementStatus": settlementStatus,
                "filePaths": filePaths,
                "flag": selectedLodProfile,
                "listOfAppliances": selectedLodProfile == "3" ? json.encode(listOfAppliances) : json.encode([])

            }; 


            Map<String, dynamic> res;
            res = await model.disconnect(data);
            
              //submission was successful
            if(res['isSuccessful']){
                    
                  setState(()=>isLoading = false); 
                  showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: res['msg']);
                  try{
                      
                      //res = await model.uploadDisconnectionDetails(formData);
                      //submission was successful
                      String page;
                      if(widget.flag != null && widget.flag == "rpd"){
                        page = "/rpd_find_customer";
                      }
                      else{
                        page = '/disconnection_list';
                      }
                      if(res['isSuccessful']){
                        setState(()=>isLoading = false); 
                        showAlertDialog(
                          context: context, 
                          navigateTo: page, 
                          isLoading: false, isSuccess: 
                          true,
                          completedMsg: res['msg']
                        );
                      }
                      //submission failed
                      else{
                        setState(()=>isLoading = false); 
                        showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
                      }
                  }
                  catch(e){
                    print(e.toString());
                    setState(()=>isLoading = false); 
                    showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
                  }
          
              

                  setState(()=>isLoading = false); 
            }
            else{
              setState(()=>isLoading = false);
              showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
              print("not submitted");
            } 

        
        /* setState(()=>isLoading = true);
          Future.delayed( Duration(seconds: 2), (){  
            setState(()=>isLoading = false); 
            showAlertDialog(context: context, isLoading: false, completedMsg: "Operation Completed");         
          });
          */
      }

      void _getGeoPoints() async{

            showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching cordinates...");
          
            try{
              var latLng = await LocationService.checkLocationPermissionStatus(context);
              print(latLng.toString());
              
              if(!latLng["isServiceEnabled"]){
                _showSnackBar(isSuccessSnack: false, msg: "Please turn on your location service");
                return;
              }
              if(latLng["isServiceEnabled"] && latLng["latitude"] != null && latLng["longitude"] != null){
                  
                  setState(() {
                    latitude = latLng["latitude"];
                    longitude = latLng["longitude"];
                  }); 
                  print(latLng["latitude"]);
              }
              else{
                _showSnackBar(isSuccessSnack: false, 
                msg: "couldn't fetch cordinates. Please ensure your location service is turned on");
                return;
              }

              
            }
            catch(e){
                print("dc_details: error fetching lat/lng");
                print("dc_details: "+e.toString());
            }
            
            Navigator.of(context).pop();
            print(longitude);
            print(latitude);
            
      }

      Widget _buildDropDownButton(){

          Widget dropdownButton;
          dropdownButton = Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: DropdownButton(
              items: dropdownItemsIncidences,
              onChanged: (dynamic value){
                print("dropdown value: $value");
                setState(() {
                  selectedIncidenceId = value;
                });
                fetchCustomerIncidences();
              },
              value: selectedIncidenceId,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

      Widget _buildDropDownSettlementPlan(){

          Widget dropdownButton;
          dropdownButton = Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: DropdownButton(
              items: dropdownItemsSettlement,
              onChanged: (dynamic value){
                print("dropdown value: $value");
                setState(() {
                  selectedDuration = value;
                });
              },
              value: selectedDuration,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

      Widget _buildDropDownCalculateLoadOption(){
      
          Widget dropdownButton;
          dropdownButton = Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: DropdownButton(
              items: dropdownItemsCalculateLoadOption,
              onChanged: (dynamic value){
                print("dropdown value: $value");
                _avgAvailabililtyEC.text = "";
                noOfMonths = "";
                avgAvailability = "";
                _noOfMonthEC.text = "";
                consumption = 0;
                kw = 0;
                setState(() {
                  selectedLodProfile = value;
                });
              },
              value: selectedLodProfile,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

      Widget _buildDropDownPhase(){
      
          Widget dropdownButton;
          dropdownButton = Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: DropdownButton(
              items: dropdownItemsPhase,
              onChanged: (dynamic value){
                print("selected phase value: $value");
                setState(() {
                  selectedPhase = value;
                });
              },
              value: selectedPhase,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

       Widget _buildDropDownTariff(){
      
          Widget dropdownButton;
          dropdownButton = Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: DropdownButton(
              items: dropdownItemsTariff,
              onChanged: (dynamic value){
                print("selected tariff value: $value");
                setState(() {
                  selectedTariff = value;
                });

                var st = selectedTariff.split("|");
                selectedTariffCode = st[0].trim();
                selectedTariffRate = st[1].trim();
              },
              value: selectedTariff,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }


      //build the DTR Executive Expansion list items
      buildDTRExecutiveExpansionPanelListItems(){
          ExpansionPanelRow dtrName = new ExpansionPanelRow(title: "Name", value: widget.customer.dtrExecName == null ? "NA": widget.customer.dtrExecName);
          ExpansionPanelRow dtrPhone = new ExpansionPanelRow(title: "Phone", value: widget.customer.dtrExecPhone == null ? "NA": widget.customer.dtrExecPhone);
          ExpansionPanelRow dtrEmail = new ExpansionPanelRow(title: "Email", value: widget.customer.dtrExecEmail == null ? "NA": widget.customer.dtrExecEmail);
          dtrExecutiveExpansionPanelList = [dtrName, dtrPhone, dtrEmail];

          return buildExpansionPanelList(dtrExecutiveExpansionPanelList);
      }

      //build the Payment History expansion list items
      buildPaymentHistoryExpansionPanelListItems(){

          List<ExpansionPanelRow> paymentHistoryExpansionPanelList = [
              new ExpansionPanelRow(title: "DATE", value: "AMOUNT")
          ];
          ExpansionPanelRow expansionPanelRow;
          if(paymentHistoryList.length > 0){ 
              paymentHistoryList.forEach((history) {
              expansionPanelRow = new ExpansionPanelRow(
                title: history.datePaid, 
                value: "₦"+numberFormat.format(history.amountPaid)
              );
              paymentHistoryExpansionPanelList.add(expansionPanelRow);
            }); 
          }
          else{
            expansionPanelRow = new ExpansionPanelRow(title: "Message: No payment record found", value: "");
          }
        
          return buildExpansionPanelList(paymentHistoryExpansionPanelList);
      }

      //build the Customer incidences expansion list items
      buildIncidenceExpansionPanelListItems(){

          List<ExpansionPanelRow> customerIncidencesExpansionPanelList = [];
          
          ExpansionPanelRow expansionPanelRow;
          if(customerIncidences != null && customerIncidences.length > 0){
            double total = 0;
            customerIncidencesExpansionPanelList.add(
              new ExpansionPanelRow(title: "INCIDENCE", value: "AMOUNT")
            );
            customerIncidences.forEach((ci) {
              try{total += double.parse(ci.incidenceAmount);}
              catch(e){print("error parsing string to double: $e");}
              expansionPanelRow = new ExpansionPanelRow(
                title: ci.incidenceName, 
                value: "₦"+ numberFormat.format(double.parse(ci.incidenceAmount))
      
              );
              customerIncidencesExpansionPanelList.add(expansionPanelRow);
            }); 

            if(total > 0){
                customerIncidencesExpansionPanelList.add(
                    new ExpansionPanelRow(title: "TOTAL", value: "₦"+numberFormat.format(total))
                );
            }
          }
          else{
            customerIncidencesExpansionPanelList = [];
            customerIncidencesExpansionPanelList.add(
              new ExpansionPanelRow(title: "Message", value: "No charges")
            );
          }
        
          return buildExpansionPanelList(customerIncidencesExpansionPanelList, boldLastItem: true);
      }
      
      // builds the Expansion List dynamically based on the  argument
      buildExpansionPanelList(List<ExpansionPanelRow> expansionList, {bool boldLastItem}){

          List<Widget> epList = [];
          Widget expansionItem;

          for(int i=0; i < expansionList.length; i++){
              Widget title;
              Widget value;
              if((i != (expansionList.length - 1))){
                title = Text(
                  expansionList[i].title != null ? expansionList[i].title : '', 
                  style: i == 0 ? expansionPanelHeading : expansionPanelTitle
                );
                value = Text(expansionList[i].value != null ? expansionList[i].value : '',
                 style:  i == 0 ? expansionPanelTitle : expansionPanelValue
                );
              }
              else{
                title = Text(
                  expansionList[i].title != null ? expansionList[i].title : '', 
                  style: boldLastItem == true ? boldRed : expansionPanelTitle
                );
                value = Text(
                  expansionList[i].value != null ? expansionList[i].value : '', 
                  style: boldLastItem == true ? boldRed : expansionPanelValue
                );
              }
              expansionItem =  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    title,value 
                  ],
                ),
              );
              epList.add(expansionItem);
          }
          return epList;
      }

      //get load from bill, clamp meter, load calculator

      //builds the customer data(email/phone) expansion panel
      //The expansion panel item is composed of Textform fields for email and phone no
      Widget _buildCustomerDataExpansionPanel(){
            return  Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded){
                      setState(() => customerDataState = !isExpanded);
                  } ,
                  animationDuration:  Duration(milliseconds: 500),
                  children: <ExpansionPanel>[
                          ExpansionPanel(
                            headerBuilder: (BuildContext context, bool i){
                              return Container(
                                margin: EdgeInsets.only(left: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ALTERNATIVE DETAILS(OPTIONAL)",
                                  style: expansionPanelHeading
                                ),
                              );
                            },
                            body: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                         TextFormField(             
                                          decoration: InputDecoration(
                                            labelText: "Customer Name",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Colors.white,
                                            filled: true
                                          ),
                                          validator: (String value){
                                            if(value.length == 0 || value == null){
                                              return "Please enter an email. Enter N/A if non exists";
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) => customerName = newValue,
                                          onChanged: (String value) => customerName = value,
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.emailAddress,             
                                          decoration: InputDecoration(
                                            labelText: "Customer Email",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.mail),
                                            fillColor: Colors.white,
                                            filled: true
                                          ),
                                          validator: (String value){
                                            if(value.length == 0 || value == null){
                                              return "Enter N/A if non exists";
                                            }
                                            if(!value.contains("@")){
                                              return "Invalid email";
                                            }
                                          
                                            return null;
                                          },
                                          onSaved: (newValue) => customerEmail = newValue,
                                          onChanged: (String value) => customerEmail = value,
                                        ),
                                        TextFormField(  
                                          keyboardType: TextInputType.number,          
                                          decoration: InputDecoration(
                                            labelText: "Customer Phone No",
                                            hintText:  "",
                                            prefixIcon: Icon(Icons.phone),
                                            fillColor: Colors.white,
                                            filled: true
                                          ),
                                          onSaved: (newValue) => customerPhone = newValue,
                                          onChanged: (String value) => customerPhone = value,
                                        ),
                                        TextFormField(             
                                          decoration: InputDecoration(
                                            labelText: "Customer Address",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Colors.white,
                                            filled: true
                                          ),
                                          validator: (String value){
                                            if(value.length == 0 || value == null){
                                              return "Enter N/A if non exists";
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) => customerAddress = newValue,
                                          onChanged: (String value) => customerAddress = value,
                                        ),
                                      
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            isExpanded: customerDataState
                        ),
                      ]
              ),
            );
      }

      Widget _buildClampLoadValueTextField(){
          return TextFormField(
            keyboardType: TextInputType.number,
            focusNode: _addressFocusNode,          
            decoration: InputDecoration(
              labelText: "Enter Load Clamp Value (Amps)",
              hintText: "Enter Here",
              fillColor: Colors.white,
              filled: true
            ),
            validator: (String value){
              return null;
            },
            onSaved: (newValue) => clampValue = newValue,
            onChanged: (String value) => clampValue = value,
          );
      }

      //build date selection button
      Widget _buildGeoPointsButton(){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text("Get Cordinates**", style: TextStyle(color: Colors.red)),
              onPressed: _getGeoPoints,
              color: Colors.white,
            ),
            Text(
              latitude == null ? "" : "$latitude / $longitude",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
          ],
      );
      
    }

      Widget _buildConsumptionCalcTable(){
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(4.0),
              child: Table(
                border: TableBorder.all(color: Colors.white),
                children: [ 
                  TableRow( children: [
                      Text("KW", 
                        textAlign: TextAlign.center,
                         style: TextStyle(
                            color:Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      Text("Mntly Availability", 
                        textAlign: TextAlign.center,
                         style: TextStyle(
                            color:Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      Text("No of Months",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      Text("")
                  ]),
                  TableRow( children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Text(kw.toStringAsFixed(3), 
                         textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _avgAvailabililtyEC,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Enter Here",
                            filled: true   
                          ),
                          onChanged: (value) => avgAvailability = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: TextFormField(
                          controller: _noOfMonthEC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Enter Here",
                            filled: true,
                            //contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0)   
                          ),
                          onChanged: (value) => noOfMonths = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: RaisedButton(
                          onPressed: calculateConsumption,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            "Calc Consumption",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 7.0, 
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                          color: Colors.green,
                        ),
                      )
                  ])
                ]
              ),
            ),
            SizedBox(height: 8.0),
            
            Text("CONSUMPTION(KWH): "+ numberFormat.format(consumption), 
              style: TextStyle(
                color:Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8.0),
          ],
        );
    }
      

      @override
      Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("DC Customer Details")
        ),
        body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
          decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
                )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
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
                          BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                          CustomerInfoText("NAME: ", widget.customer.accountName != null ? widget.customer.accountName : "NA"),
                          CustomerInfoText("ACCOUNT NO: ", widget.customer.accountNo != null ? widget.customer.accountNo : "NA"),
                          CustomerInfoText("ACCOUNT TYPE: ", widget.customer.accountType != null ? widget.customer.accountType : "NA"),
                          CustomerInfoText("ADDRESS: ", widget.customer.address != null ? widget.customer.address : "NA"),
                          CustomerInfoText("ARREARS: ", widget.customer.arrears != null ? 
                          "₦"+ numberFormat.format(double.parse(widget.customer.arrears)) : "NA"),
                          //"₦"+widget.customer.arrears : ""),
                          CustomerInfoText("LAST PAYMENT: ", widget.customer.lastPayDate != null ? widget.customer.lastPayDate : "NA"),
                          CustomerInfoText("DTR: ", widget.customer.dtrName != null ? widget.customer.dtrName : "NA"),
                          CustomerInfoText("TARIFF: ", widget.customer.tariff != null ? widget.customer.tariff : "NA"),
                          CustomerInfoText("ZONE: ", widget.customer.zone != null ? widget.customer.zone : "NA"),
                          CustomerInfoText("FEEDER: ", widget.customer.feederName != null ? widget.customer.feederName : "NA"),
                          CustomerInfoText("PHASE: ", widget.customer.phase != null ? widget.customer.phase : "NA"),
                          CustomerInfoText("STATUS: ", widget.customer.status != null ? widget.customer.status: "NA"),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildDropDownCalculateLoadOption(),
                  _buildDropDownPhase(),
                  _buildDropDownTariff(),
                  SizedBox(height: 8.0,),
                  selectedLodProfile == "3" ? Container(
                    child:  LoadCalculator(
                      setListOfAppliances: _setListOfAppliances, scaffoldKey: _scaffoldKey, accountNo: widget.customer.accountNo
                    ),
                  ) : Container(),
                  SizedBox(height:8.0,),
                  selectedLodProfile == "2" ? _buildClampLoadValueTextField() : Container(),
                  SizedBox(height: 6.0),
                 selectedLodProfile == "2" || selectedLodProfile == "3" ? 
                 _buildConsumptionCalcTable() : Container(),
                 
                  SizedBox(height: selectedLodProfile == "2" ? 10.0 : 0.0),
                  ExpansionPanelInfo(expansionList: buildPaymentHistoryExpansionPanelListItems(), expansionTitle: "PAYMENT HISTORY"),
                  SizedBox(height: 10.0),
                  ExpansionPanelInfo(expansionList: buildDTRExecutiveExpansionPanelListItems(), expansionTitle: "DTR EXECUTIVE DETAILS"),
                  SizedBox(height: 10.0),
                  _buildCustomerDataExpansionPanel(),
                  SizedBox(height: 10.0),
                  _buildDropDownButton(),
                  SizedBox(height: 10.0),
                  customerIncidences.length > 0 ? 
                  ExpansionPanelInfo(expansionList: buildIncidenceExpansionPanelListItems(), expansionTitle: "INCIDENCE CHARGE SUMMARY")
                  : Container(),
                  SizedBox(height: 10.0),
                  settlementPlanList.length > 0 && hasSettlement ? Container(
                     width: double.infinity,
                     padding: EdgeInsets.symmetric(horizontal: 8),
                     child: Text(
                        "This customer has a settlement of ₦"+ numberFormat.format(double.parse(settlementAmount)) +
                        ". Kindly advise the customer to visit the nearest PHED office to sign the settlement document base on an"+
                        " agreed plan",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.0
                        ),
                     ),
                  ) : Container(),
                  SizedBox(height: 8.0,),
                  settlementPlanList.length > 0 && hasSettlement ? 
                  _buildDropDownSettlementPlan() : Container(),
                  SizedBox(height: 10.0),
                  RemarksTextFormField(_setRemarks),
                  SizedBox(height: 15.0),
                  _buildGeoPointsButton(),
                  SizedBox(height: 15.0),
                  FileUploadButton(setImages: _setImages),
                  SizedBox(height: 15.0),         
                  SubmitButton(completeDisconnectionAction, isLoading, "DISCONNECT")
                ],
              ),
            ),
          ),
        ),
    );
  }
} 

 
