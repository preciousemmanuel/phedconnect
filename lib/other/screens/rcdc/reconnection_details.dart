import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/rcdc/reconnection_controller.dart';
import '../../data/authenticated_staff.dart';
import '../../models/customer.dart';
import '../../models/customer_incidence.dart';
import '../../models/expansion_panel_item.dart';
import '../../models/payment_history.dart';
import '../../utilities/alert_dialog.dart';
import '../../utilities/styles.dart';
import '../../widgets/customer_info_text.dart';
import '../../widgets/expansion_panel_info.dart';
import '../../widgets/submit_btn.dart';

class ReconnectionDetailsScreen extends StatefulWidget {

  final Customer customer;
  ReconnectionDetailsScreen(this.customer);

  @override
  _ReconnectionDetailsScreenState createState() => _ReconnectionDetailsScreenState();
}

class _ReconnectionDetailsScreenState extends State<ReconnectionDetailsScreen> {

  final ReconnectionController model = ReconnectionController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final numberFormat = new NumberFormat("#,##0.00", "en_US");
  bool isLoading = true; //show loading state
  String remarks;
  File file;
  List<File> displayImageList = List<File>();
  List uploadedImages = [];
  List<PaymentHistory> paymentHistoryList = List();
  List<CustomerIncidence> customerIncidences = List();

 

  @override
  void initState() {

    getReconnDetails();
    super.initState();
  }

    //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg}){

        //create snackbar
        var snackBar =  SnackBar(
            backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
            duration: Duration(seconds: 5),
            content: Text(msg,
            style: TextStyle(
              color: Colors.white
            ),),
        );

        //show snackbar
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  getReconnDetails() async{

      Map<String,dynamic> data = {
        "accountNo": widget.customer.accountNo,
        "date": widget.customer.dateOfDiscon,
        "disconnId": widget.customer.disconId
      };

      Map<String,dynamic> res;
      res = await model.fetchReconnDetails(data);

      if(res != null){
          customerIncidences.clear();
          paymentHistoryList.clear();
          setState(() {    
            isLoading = false;
            paymentHistoryList = res["paymentHistoryList"];
            customerIncidences = res["incidenceHistoryList"];
          });

          if(res["status"] != "SUCCESS"){
            _showSnackBar(
              isSuccessSnack: false, 
              msg:"No incidence/payment record found"
            );
          }
      }
      else{
         /* _showSnackBar(
            isSuccessSnack: false, 
            msg:"No payment/incidence record not found"
          ); */
      }
       
  }


  String validateInput(){

      if(authenticatedStaff.gangId == null){
        return "You don't have Reconnection privileges for this Gang";
      }
      if(customerIncidences.length < 1 && paymentHistoryList.length < 1){
        return "Customer cannot be reconnectedT! No payment/incidence history not found";
      }
      return null;
  }




  void completeReconnectionAction() async{

      
      if(validateInput() != null){
        _showSnackBar(isSuccessSnack: false, msg: validateInput());
        return;
      }

      setState(()=>isLoading = true); 
      Map<String, dynamic> res;

      res = await model.reconnect(widget.customer.disconId);

      //submission was successful
      if(res['isSuccessful']){
            
          setState(()=>isLoading = true); 
          showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: res['msg']);
          try{
              
              //res = await model.uploadDisconnectionDetails(formData);

              //submission was successful
              if(res['isSuccessful']){
                setState(()=>isLoading = false); 
                showAlertDialog(
                  context: context, 
                  navigateTo: '/reconnection_list', 
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
            showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
          }

          setState(()=>isLoading = false); 
      }
      else{

          setState(()=>isLoading = false); 
          showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
      }
      

      /*
      setState(()=>isLoading = true);
        Future.delayed( Duration(seconds: 2), (){  
          setState(()=>isLoading = false); 
          showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: "Operation successful");         
        });

      */
      
      
  }
   
  
  //set the images, selected in the "ImageGridView" widget
  //To achieve this, "lifting up the state" concept is employed
  //i.e passing a reference of the function to the "ImageGridView" widget
  //On image selection, the function is executed and the "image" propertiy is set
  
  /*
  void _setImages(List<File> imageList){
    setState(() {
        displayImageList = imageList;
    });
  }
  */

  //set the remarks, selected in the "RemarksTextFormField" widget
  //To achieve this, "lifting up the state" concept is employed
  //i.e passing a reference of the function to the "RemarksTextFormField" widget
  //On text change event, the function is executed and the "remarks" property is set on this class
 
  /*void _setRemarks(String rmks){
    remarks = rmks;
  }
  */
  
  //builds the expansion panel
  //It handles the building of all expansion panel on this screen
  //It accepts the expansion List<ExpansionPanelRow>, and builds the expansion panel accordingly
   // builds the Expansion List dynamically based on the  argument
  buildExpansionPanelList(List<ExpansionPanelRow> expansionList, {bool boldLastItem}){

      List<Widget> epList = [];
      Widget expansionItem;

      for(int i=0; i < expansionList.length; i++){
          Widget title;
          Widget value;
          if((i != (expansionList.length - 1))){
            title = Text(expansionList[i].title, style: i == 0 ? expansionPanelHeading : expansionPanelTitle);
            value = Text(expansionList[i].value, style:  i == 0 ? expansionPanelTitle : expansionPanelValue);
          }
          else{
            title = Text(expansionList[i].title, style: boldLastItem == true ? boldRed : expansionPanelTitle);
            value = Text(expansionList[i].value, style: boldLastItem == true ? boldRed : expansionPanelValue);
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


   //build the Payment History expansion list items
  buildPaymentHistoryExpansionPanelListItems(){

      List<ExpansionPanelRow> paymentHistoryExpansionPanelList = [
           new ExpansionPanelRow(title: "DATE", value: "AMOUNT")
      ];
      ExpansionPanelRow expansionPanelRow;
      if(paymentHistoryList != null){
        if(paymentHistoryList.length > 0){
          paymentHistoryList.forEach((history) {
          expansionPanelRow = new ExpansionPanelRow(
            title: history.datePaid, 
            value: "₦"+ numberFormat.format(history.amountPaid)
          );
          paymentHistoryExpansionPanelList.add(expansionPanelRow);
        }); 
        }
        else{
          expansionPanelRow = new ExpansionPanelRow(title: "Message: No payment record found", value: "");
        }
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
            //value: "Nfsds"
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
          new ExpansionPanelRow(title: "No Incidence(s) found", value: "")
        );
      }
    
      return buildExpansionPanelList(customerIncidencesExpansionPanelList, boldLastItem: true);
  }





  //build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("RC Customer Details")
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
                            BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                          ]
                    ),
                    child: Column(
                      children: <Widget>[
                            CustomerInfoText("NAME: ", widget.customer.accountName != null ? widget.customer.accountName : "NA"),
                            CustomerInfoText("ACCOUNT NO: ", widget.customer.accountNo != null ? widget.customer.accountNo : "NA"),
                            CustomerInfoText("ACCOUNT TYPE: ", widget.customer.accountType != null ? widget.customer.accountType : "NA"),
                            CustomerInfoText("ARREARS: N", widget.customer.arrears != null ? widget.customer.arrears : ""),
                            CustomerInfoText("LAST PAYMENT: ", widget.customer.lastPayDate != null ? widget.customer.lastPayDate : "NA"),
                            CustomerInfoText("DTR: ", widget.customer.dtrName != null ? widget.customer.dtrName : "NA"),
                            CustomerInfoText("TARIFF: ", widget.customer.tariff != null ? widget.customer.tariff : "NA"),
                            CustomerInfoText("ZONE: ", widget.customer.zone != null ? widget.customer.zone : "NA"),
                            CustomerInfoText("FEEDER: ", widget.customer.feederName != null ? widget.customer.feederName : "NA"),
                            CustomerInfoText("PHASE: ", widget.customer.phase != null ? widget.customer.phase : "NA"),
                            CustomerInfoText("STATUS: ", widget.customer.status != null ? widget.customer.phase : "NA"),
                            CustomerInfoText("DD: ", widget.customer.dateOfDiscon != null ? widget.customer.dateOfDiscon : ""),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //CustomerInfoText("SPA:", "2 INSTALLMENT FOR PENALTY"),
                  /*Text("DATE DISCONNECTED: ${widget.customer.dateOfDiscon}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0
                  ),),
                  */
                  //SizedBox(height: 20.0),
                  !isLoading ? ExpansionPanelInfo(
                    expansionList: buildPaymentHistoryExpansionPanelListItems(), 
                    expansionTitle: "PAYMENT HISTORY"
                  ): Container(),
                   SizedBox(height: 10.0),
                  !isLoading ? ExpansionPanelInfo(
                    expansionList: buildIncidenceExpansionPanelListItems(), 
                    expansionTitle: "BILLED INCIDENCE SUMMARY"
                  ) : Container(),
                 
                 
                 /* ExpansionPanelInfo(expansionList: buildExpansionList(incidenceExpansionPanelList), expansionTitle: "INCIDENCE"),
                  SizedBox(height: 10.0),
                  //ExpansionPanelInfo(expansionList: buildExpansionList(dtrExpansionPanelList), expansionTitle: "DTR EXECUTIVE DETAILS"),
                  SizedBox(height: 10.0),          
                  RemarksTextFormField(_setRemarks),
                  SizedBox(height: 15.0),
                  FileUploadButton(_setImages),
                  SizedBox(height: 15.0),
                  //ImageGridView(images), */
                  SizedBox(height: 20.0),      
                  SubmitButton(completeReconnectionAction, isLoading, "RECONNECT")
                  
                ],
              ),
            ),
          ),
        ),
    );
  }
}