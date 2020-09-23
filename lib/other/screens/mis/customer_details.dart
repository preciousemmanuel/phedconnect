
import 'dart:convert';
import '../../controllers/account_seperation_controller.dart';
import '../../data/active_dtr.dart';
import '../../data/authenticated_staff.dart';
import '../../models/rcdc_incidence.dart';
import '../../screens/rpdonboarding/dropdown_data.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import '../../widgets/submit_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/rcdc/disconnection_controller.dart';
import '../../data/data.dart';
import '../../models/customer.dart';
import '../../models/expansion_panel_item.dart';
import '../../models/payment_history.dart';
import '../../models/billing_history.dart';
import '../../models/settlement_duration.dart';
import '../../utilities/styles.dart';
import '../../widgets/customer_info_text.dart';
import '../../widgets/expansion_panel_info.dart';
import '../../models/customer_incidence.dart';
import '../../controllers/mis/mis_utility_controller.dart';

class MisCustomerDetailsScreen extends StatefulWidget {

  final Customer customer;  
  final String flag;
  MisCustomerDetailsScreen(this.customer, {this.flag});

  @override
  _MisCustomerDetailsScreenState createState() => _MisCustomerDetailsScreenState();
}

class _MisCustomerDetailsScreenState extends State<MisCustomerDetailsScreen> {

      FocusNode _addressFocusNode = FocusNode();
      final DisconnectionController model = DisconnectionController();
      final MISUtilityController misUtilityController = MISUtilityController();
      final AccountSeperation accountSeperationController = AccountSeperation();

      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      final numberFormat = new NumberFormat("#,##0.00", "en_US");
  
      List<PaymentHistory> paymentHistoryList = List<PaymentHistory>();
      List<BillingHistory> billingHistoryList = List<BillingHistory>();
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
      String selectedReasonForDisconnection;
      String remarks;
      String latitude;
      String longitude;
      bool customerDataState; //sets the state(open or close) of customer expansion panel
      bool isLoading = true; //show loading 
      List uploadedImages = [];
      List<CustomerIncidence> customerIncidences = [];
      String fileName;
      String settlementAmount;
      bool hasSettlement = false;
      String selectedDuration;
      String settlementStatus = "NO";
      String selectedLodProfile;
      String clampValue;
      double overallTotalWattage = 0;
      double consumption = 0;
      double kw = 0;
      String avgAvailability;
      String noOfMonths;
      String disconnectionNoticeNo;
      List<Map<String,dynamic>> listOfAppliances = List<Map<String,dynamic>>();

      //activeMISDisconnection = "MIS,DTR_DISCONNECT","TARRIF_CHANE";
      //where activeMISDiscconection == "DTR_DISCONNECT"
      String comments;
      String phase;

      //where activeMISDisconnection == "TARRIF_CHANGE"
      String _typeOfPremises;
      String selectedTariff;
      String selectedTariffCode;
      String tarrifChangeComment;
      String _useOfPremises;
      String _houseNo;
      String _streetName;

      //where activeMISDisconnection == "ACCOUNT_SEPERATION"
      String noOfAccountSeperation;
     
      
      
      @override
      void initState() {

          customerDataState = false;
          selectedReasonForDisconnection = dropdownItemsIncidences[0].value;
          selectedDuration = dropdownItemsSettlement[0].value;
          selectedLodProfile = dropdownItemsCalculateLoadOption[0].value;
          _typeOfPremises = dropdownItemsOnboardingTypeOfPremise[0].value;
          _useOfPremises = dropdownItemsOnboardingUseOfPremise[0].value;
          phase = dropdownItemsPhase[0].value;
          selectedTariff = dropdownItemsTariff[0].value;
          _getGeoPoints();
          fetchPaymentHistory(); //fetch customer payment history
          fetchTariffList();
          fetchIncidenceList();
          super.initState();
      }

      @override
      void dispose() {        
        _addressFocusNode.dispose();
        super.dispose();
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

      /*
      * This method fetches the customer payment history
      */
      void fetchPaymentHistory() async{

          //The 'fetchListOfIncidences' method is @ 'lib/controllers.disconnection_controller.dart'
          print("fetch customer....");
          paymentHistoryList = [];
          billingHistoryList = [];
          Map<String,dynamic> res;
          res = await model.fetchPaymentHistory(widget.customer.accountNo);
          print(res.toString());

          setState(() {
              isLoading = false;
              paymentHistoryList = res["data"];
              billingHistoryList = res["billing"];
          });
          if(res["status"] != "SUCCESS"){
            _showSnackBar(
              isSuccessSnack: false, 
              msg:"No payment history found"
            );
          }
          //print(paymentHistoryList.length.toString());
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

      showErrorDialog(String errMsg){
        showAlertDialog(
          context: context, 
          isLoading: false, 
          isSuccess: false,
          completedMsg: errMsg
        );
      }

      bool validateDropdownInput(){
      
          setState(()=>isLoading = false); 

           if(phase == null || phase.length < 1){
              showErrorDialog("Please select a customer phase to continue");
              return false;
          }
          if(selectedReasonForDisconnection.length < 1 || selectedReasonForDisconnection == null){
              showErrorDialog("Please select a reason for disconnection");
              return false;
          }
          if(disconnectionNoticeNo == null || disconnectionNoticeNo.length < 1){
              showErrorDialog("Please enter the disconnection notice number");
              return false;
          }
          if(latitude.toString().trim().length == 0 || latitude == null){
             showErrorDialog("No coordinate selected. Make sure your location service is turned on");
          }
          if(longitude.toString().trim().length == 0 || longitude == null){
             showErrorDialog("No coordinate selected. Make sure your location service is turned on");
          }
          if(customerEmail == null || customerEmail.length < 1){
             customerEmail = "NA";
          }
          if(customerPhone == null || customerPhone.length < 1){
             customerPhone = "NA";
          }
           if(comments == null || comments.length < 1){
             comments = "NA";
          }
          return true;
      }

      bool validateTarrifChangeParams(){
      
          setState(()=>isLoading = false); 

          if(_typeOfPremises.length < 1 || _typeOfPremises == null){
              showErrorDialog("Please select the type of premise");
              return false;
          }
          if(selectedTariffCode == null || selectedTariffCode.length < 1){
              showErrorDialog("Please select the tarrif code");
              return false;
          }
          if(customerPhone == null || customerPhone.length < 1){
              showErrorDialog("Please enter customer phone number");
              return false;
          }
          if(_houseNo == null || _houseNo.length < 1){
             showErrorDialog("Please enter house no. Enter NA if non exists");
             return false;
          }
          if(_streetName == null || _streetName.trim().length < 1){
             showErrorDialog("Please enter Street Name. Enter NA if not known");
             return false;
          }
          if(latitude.toString().trim().length == 0 || latitude == null){
             showErrorDialog("No coordinate selected. Make sure your location service is turned on");
          }
          if(longitude.toString().trim().length == 0 || longitude == null){
             showErrorDialog("No coordinate selected. Make sure your location service is turned on");
          }
          
          return true;
      }


      bool validateAccountSeperationParams(){
          
          setState(()=>isLoading = false); 
          if(noOfAccountSeperation == null || noOfAccountSeperation.length < 1){
              showErrorDialog("Please enter the number of account seperation required");
              return false;
          }

          return true;
      }


      void _getGeoPoints() async{

        //showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching cordinates...");
      
        try{
          var latLng = await LocationService.checkLocationPermissionStatus(context);
          print(latLng.toString());
          
          if(latLng["isServiceEnabled"] && latLng["latitude"] != null && latLng["longitude"] != null){
              
              latitude = latLng["latitude"];     
              longitude = latLng["longitude"];
              print(longitude);
              print(latitude);
             
          }
          
        }
        catch(e){
            print("dc_details: error fetching lat/lng");
            print("dc_details: "+e.toString());
        }
        
        //Navigator.of(context).pop();
            
      }

      void _completeSubmitActionDTRDisconnect() async{
        
          if(!validateDropdownInput()){
            return;
          }

          if(latitude == null || longitude == null){
              _getGeoPoints();
          }
           
          //display loading dialog
          setState(()=>isLoading = true);
         
           
          //create form data
          Map<String,dynamic> data = {
              "AccountNumber": widget.customer.accountNo,
              "AccountType": widget.customer.accountType,
              "Phase": phase,
              "AverageBillReading": widget.customer.avgConsumption,
              "Comments": comments,
              "Tariff":  widget.customer.tariff,
              "TariffRate": widget.customer.tariff,
              'StaffId': authenticatedStaff.staffId,
              "GangID": "DTR",
              "Latitude": latitude,
              "Longitude": longitude,
              "CustomerEmail": customerEmail,
              "CustomerPhone": customerPhone,
              "DisconnectionNoticeNo": disconnectionNoticeNo,
              "ReasonForDisconnection": selectedReasonForDisconnection,
              "DisconnID": widget.customer.disconId
          };

          print("DTR Disconnectxxxxx: "+ widget.customer.disconId);
          print("DTR Disconnect: "+ jsonEncode(data));

           
          
            Map<String, dynamic> res;
            res = await misUtilityController.dtrDisconnect(data);
            //submission was successful
            if(res != null){
              if(res['isSuccessful']){
                setState(()=>isLoading = false); 
                showAlertDialog(
                  context: context,
                  navigateTo: activeMISDisconnect == "DTR_DISCONNECT" ? '/bd_home' : '/modules',
                  isLoading: false, 
                  isSuccess: true, 
                  completedMsg: res['msg']);
              }
              //submission failed
              else{
                setState(()=>isLoading = false); 
                showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
              }
            }
            
           
            
        /*
        setState(()=>isLoading = true);
        Future.delayed( Duration(seconds: 2), (){  
          setState(()=>isLoading = false); 
          showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: "Operation successful");         
        });
        */

      
    }

      void _completeSubmitActionTarrifChange() async{

          if(!validateTarrifChangeParams()){
            return;
          }

          if(latitude == null || longitude == null){
              _getGeoPoints();
          }
           
          //display loading dialog
          setState(()=>isLoading = true);
         
          //create form data

          Map<String,dynamic> data = {
              "CapturedBy": authenticatedStaff.name,
              "CustomerEmail": customerEmail == null ? "NA" : customerEmail,
              "CustomerPhone": customerPhone == null ? "NA" : customerPhone,
              "DTRCode" : widget.customer.dtrCode == null ? "NA" : widget.customer.dtrCode,
              "DTRName" : widget.customer.dtrName == null ? "NA" : widget.customer.dtrName,
              "FeederId" : widget.customer.feederId == null ? "NA" : widget.customer.feederId,
              "FeederName" : widget.customer.feederName == null ? "NA" : widget.customer.feederName,
              "HouseNo": _houseNo == null ? "NA" : _houseNo,
              "Latitude": latitude == null ? "NA" : latitude,
              "Longitude": longitude == null ? "NA" : longitude,
              "MeterNo" : widget.customer.meterno == null ? "NA" : widget.customer.meterno,
              "AccountNo" :  widget.customer.accountNo == null ? "NA" : widget.customer.accountNo,
              "AccountName" : widget.customer.accountName == null ? "NA" : widget.customer.accountName,
              "StreetName" : _streetName == null ? "NA" : _streetName,
              "TypeOfPremises" : _typeOfPremises == null ? "NA" : _typeOfPremises,
              "UseOfPremises" : _useOfPremises == null ? "NA" : _useOfPremises,
              "UserId" : authenticatedStaff.id == null ? "NA" : authenticatedStaff.id,
              "StaffId" :  authenticatedStaff.staffId == null ? "NA" : authenticatedStaff.staffId,
              "Zone" : authenticatedStaff.zone == null ? "NA" : authenticatedStaff.zone,
              "OldTariff": widget.customer.tariff == null ? "NA" : widget.customer.tariff,
              "NewTariff": selectedTariffCode == null ? "NA" : selectedTariffCode,
              "Comment": tarrifChangeComment == null ? "NA" : tarrifChangeComment
          };

          print(jsonEncode(data));

           
          
            Map<String, dynamic> res;
            res = await misUtilityController.tarrifChange(data);
            //submission was successful
            if(res != null){
              if(res['isSuccessful']){
                setState(()=>isLoading = false); 
                showAlertDialog(
                  context: context,
                  navigateTo: '/modules',
                  isLoading: false, 
                  isSuccess: true, 
                  completedMsg: res['msg']);
              }
              //submission failed
              else{
                setState(()=>isLoading = false); 
                showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
              }
            }
        
    }

      void _completeSubmitAccountSeperation() async{

          if(!validateAccountSeperationParams()){
            return;
          }

          if(latitude == null || longitude == null){
             // _getGeoPoints();
          }
           
          //display loading dialog
          setState(()=>isLoading = true);


          //create form data
          String currentNow = DateTime.now().toIso8601String();
          List<String> splitTimeArray = currentNow.split("T");
          String requestdate = splitTimeArray[0];

          Map<String,dynamic> data = {

              "primaryaccount" :  widget.customer.accountNo == null ? "NA" : widget.customer.accountNo,
              "requestbyid" :  authenticatedStaff.staffId == null ? "NA" : authenticatedStaff.staffId,
              "requestbyname": authenticatedStaff.name  == null ? "NA" : authenticatedStaff.name,
              "requestdate": requestdate,
              "noofseparation": noOfAccountSeperation,
              "dtrid": widget.customer.dtrCode,
              "feeder33id": widget.customer.feederId,
              "feeder11id": widget.customer.feederId,
               
          };

          print(jsonEncode(data));
          
            Map<String, dynamic> res;
            res = await accountSeperationController.seperateAccount(data);

            //submission was successful
            if(res != null){
              if(res['isSuccessful']){
                setState(()=>isLoading = false); 
                showAlertDialog(
                  context: context,
                  navigateTo:  '/mis_find_customer',
                  isLoading: false, 
                  isSuccess: true, 
                  completedMsg: res['msg']);
              }
              //submission failed
              else{
                setState(()=>isLoading = false); 
                showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
              }
            }       
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

       //build the Payment History expansion list items
      buildBillingHistoryExpansionPanelListItems(){

          List<ExpansionPanelRow> billingHistoryExpansionPanelList = [
              new ExpansionPanelRow(title: "DATE", value: "AMOUNT")
          ];
          ExpansionPanelRow expansionPanelRow;
          if(billingHistoryList.length > 0){ 
              billingHistoryList.forEach((history) {
              expansionPanelRow = new ExpansionPanelRow(
                title: history.billedDate, 
                value: "₦"+numberFormat.format(double.parse(history.billedAmount))
              );
              billingHistoryExpansionPanelList.add(expansionPanelRow);
            }); 
          }
          else{
            expansionPanelRow = new ExpansionPanelRow(title: "Message: No billing record found", value: "");
          }
        
          return buildExpansionPanelList(billingHistoryExpansionPanelList);
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

      Widget _buildDropDownButtonReasonForDisconnection(){

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
                  selectedReasonForDisconnection = value;
                });
              
              },
              value: selectedReasonForDisconnection,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

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
                                  "DISCONNECTION DETAILS",
                                  style: expansionPanelHeading
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        SizedBox(height: 16.0,),
                                        Container(
                                          width: double.infinity,
                                          child: _buildDropDownButtonReasonForDisconnection()
                                        ),
                                        SizedBox(height: 16.0,),
                                        Container(width:double.infinity, child: _buildDropDownPhase()),
                                        SizedBox(height: 8.0,),
                                        TextField(             
                                          decoration: InputDecoration(
                                            labelText: "Disconnection Notice No",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Color(0XFFF4F4F4),
                                            filled: true
                                          ),
                                          onChanged: (String value) =>  disconnectionNoticeNo = value,
                                        ),
                                        SizedBox(height: 8.0,),
                                        TextField(             
                                          decoration: InputDecoration(
                                            labelText: "Customer Email",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Color(0XFFF4F4F4),
                                            filled: true
                                          ),
                                          onChanged: (String value) =>  customerEmail = value,
                                        ),
                                        SizedBox(height: 8.0,),
                                        TextField(             
                                          decoration: InputDecoration(
                                            labelText: "Customer Phone",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Color(0XFFF4F4F4),
                                            filled: true
                                          ),
                                          onChanged: (String value) =>  customerPhone = value,
                                        ),
                                        SizedBox(height: 8.0,),
                                        TextField(             
                                          decoration: InputDecoration(
                                            labelText: "Comments",
                                            hintText: "",
                                            prefixIcon: Icon(Icons.verified_user),
                                            fillColor: Color(0XFFF4F4F4),
                                            filled: true
                                          ),
                                          onChanged: (String value) => comments = value,
                                        ),
                                       
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                ],
                              ),
                            ),
                            isExpanded: customerDataState
                        ),
                      ]
              ),
            );
      }

      // dropdown for type of premises
      Widget _buildDropDownTypeOfPremises(){
          return  Container(
            width: double.infinity,
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
              items: dropdownItemsOnboardingTypeOfPremise,
              isExpanded: true,
              onChanged: (dynamic value){
                print("type of premises: $value");
                setState(() {
                  _typeOfPremises = value;
                });
              
              },
              value: _typeOfPremises,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );
      }

      // dropdown for use of premises
      Widget _buildDropdownUseOfPremises(){
          return  Container(
            width: double.infinity,
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
              items: dropdownItemsOnboardingUseOfPremise,
              isExpanded: true,
              onChanged: (dynamic value){
                print("use of premises: $value");
                setState(() {
                  _useOfPremises = value;
                });
              },
              value: _useOfPremises,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );
      }

      //dropdown for tariff
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

      //dropdown for phase
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
                  phase = value;
                });
              },
              value: phase,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          );

          return dropdownButton;
      }

      Widget buildTarrifChangeComment(){
        return TextField(             
            decoration: InputDecoration(
              labelText: "Add a comment",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => tarrifChangeComment = value,
          );
      }

      Widget buildTextFieldHouseNo(){
          return TextField(             
            decoration: InputDecoration(
              labelText: "House No",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => _houseNo = value,
          );
      }

      Widget buildTextFieldStreetName(){
          return TextField(             
            decoration: InputDecoration(
              labelText: "Street Name",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => _streetName = value,
          );
      }

      Widget buildTextFieldCustomerEmail(){
          return TextField(             
            decoration: InputDecoration(
              labelText: "Customer Email",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => customerEmail = value,
          );
      }
      
      Widget buildTextFieldCustomerPhone(){
          return TextField(             
            decoration: InputDecoration(
              labelText: "Customer Phone",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => customerPhone = value,
          );
      }

      Widget buildTextFieldNoOfAccountSeperation(){
          return TextField(             
            decoration: InputDecoration(
              labelText: "No Of Account Seperation",
              hintText: "",
              prefixIcon: Icon(Icons.verified_user),
              fillColor: Color(0XFFF4F4F4),
              filled: true
            ),
            onChanged: (String value) => noOfAccountSeperation = value,
          );
      }


      @override
      Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Customer Details")
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
                              CustomerInfoText("ARREARS: ", widget.customer.arrears != null ? 
                              "₦"+ numberFormat.format(double.parse(widget.customer.arrears)) : "NA"),
                              //"₦"+widget.customer.arrears : ""),
                              CustomerInfoText("LAST PAYMENT: ", widget.customer.lastPayDate != null ? widget.customer.lastPayDate : "NA"),
                              CustomerInfoText("DTR: ", widget.customer.dtrName != null ? widget.customer.dtrName : "NA"),
                              CustomerInfoText("TARIFF: ", widget.customer.tariff != null ? widget.customer.tariff : "NA"),
                              CustomerInfoText("ZONE: ", widget.customer.zone != null ? widget.customer.zone : "NA"),
                              CustomerInfoText("FEEDER: ", widget.customer.feederName != null ? widget.customer.feederName : "NA"),
                              CustomerInfoText("PHASE: ", widget.customer.phase != null ? widget.customer.phase : "NA"),
                              CustomerInfoText("STATUS: ", widget.customer.status != null ? widget.customer.status : "NA"),
                          ],
                        ),
                      ),
                  
                      SizedBox(height: 8.0),
                      ExpansionPanelInfo(expansionList: buildPaymentHistoryExpansionPanelListItems(), expansionTitle: "PAYMENT HISTORY"),
                      SizedBox(height: 10.0),
                      widget.customer.accountType == "POSTPAID" ? ExpansionPanelInfo(
                        expansionList: buildBillingHistoryExpansionPanelListItems(), 
                        expansionTitle: "BILLING HISTORY"
                      ): Container(),
                      SizedBox(height: 10.0),
                      ExpansionPanelInfo(expansionList: buildDTRExecutiveExpansionPanelListItems(), expansionTitle: "DTR EXECUTIVE DETAILS"),
                      SizedBox(height: 10.0),
                      activeMISDisconnect == "DTR_DISCONNECT" ? _buildCustomerDataExpansionPanel() : Container(),
                      activeMISDisconnect == "DTR_DISCONNECT" ? SizedBox(height: 30.0) : SizedBox(height: 0),
                      activeMISDisconnect == "DTR_DISCONNECT" ? SubmitButton(_completeSubmitActionDTRDisconnect, isLoading, "DISCONNECT") : Container(),

                      //this blocks display when
                      //activeMISDisconnect == "TARRIF_CHANGE"
                      
                      activeMISDisconnect == "TARRIF_CHANGE" ? _buildDropDownTypeOfPremises() : Container(),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ?  _buildDropdownUseOfPremises() : Container(),
                      activeMISDisconnect == "TARRIF_CHANGE" ? _buildDropDownTariff() : Container(),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 15.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? buildTextFieldHouseNo() : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? buildTextFieldStreetName() : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? buildTextFieldCustomerPhone() : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? buildTextFieldCustomerEmail() : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? buildTarrifChangeComment() : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "TARRIF_CHANGE" ? SubmitButton(_completeSubmitActionTarrifChange, isLoading, "SUBMIT") : SizedBox(height: 0),

                      activeMISDisconnect == "ACCOUNT_SEPERATION" ? buildTextFieldNoOfAccountSeperation() : Container(),
                      activeMISDisconnect == "ACCOUNT_SEPERATION" ? SizedBox(height: 10.0,) : SizedBox(height: 0),
                      activeMISDisconnect == "ACCOUNT_SEPERATION" ? SubmitButton(_completeSubmitAccountSeperation, isLoading, "SUBMIT") : SizedBox(height: 0),

                     

                    ],
                  ),
                ),
              ),
            ),
        );
      }
} 

 
