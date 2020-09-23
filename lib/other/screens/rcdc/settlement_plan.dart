/*
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:SmartWorkForce/controllers/rcdc/settlement_plan_controller.dart';
import 'package:SmartWorkForce/utilities/alert_dialog.dart';
import 'package:SmartWorkForce/widgets/customer_info_text.dart';
import 'package:SmartWorkForce/widgets/file_upload.dart';
import 'package:SmartWorkForce/widgets/image_grid_view.dart';
import 'package:SmartWorkForce/widgets/submit_btn.dart';

class SettlementPlanScreen extends StatefulWidget {

  final SettlementPlanController model = SettlementPlanController();

  @override
  _SettlementPlanScreenState createState() => _SettlementPlanScreenState();
}

class _SettlementPlanScreenState extends State<SettlementPlanScreen> {

    GlobalKey<FormState> _formKey = GlobalKey();
    List uploadedImages = [];
    bool isLoading = false;
    String amountAgreed;
    String frequencyOfPayment;
    bool isCustomerAvailable = false;


    /*
    *  This method will be used to fecth customer details
    *  Takes "account no" as query parameter
    *  It is initiated when a certain length(for now = 10) of digits are entered
    *  in the account no search text field
    */
    void _fetchCustomer(String accountNo){
        //make call to fetch customer
        showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching customers...please wait"); 
        Future.delayed( Duration(seconds: 2), (){  
          Navigator.pop(context);
          setState(()=>isCustomerAvailable = true);     
        });
    }

    /*
    * This method handles the submission process
    */
    void _completeSettlementAction() async{

       /* 
        //display loading dialog
        setState(()=>isLoading = true);
        
        //validate input
        if(_formKey.currentState.validate()){
            _formKey.currentState.save();

            //get the uploade files
            //'getUploadFiles' method found in lib/utilities/retrieve_uploaded_file.dart
            uploadedImages = await getUploadFiles(images);

            //create form data
            FormData formData = FormData.fromMap({
                "amount_agreed": _amountAgreed,
                "frequency_of_payment": _frequencyOfPayment,
                "files": uploadedImages
            });
            
            //call "settlement plan submit" api endpoint
            //'uploadSettlementPlanDetails' method found 
            //in lib/controllers/rcdc/settlement_plan_controller.dart
            Map<String, dynamic> res;
            res = await widget.model.uploadSettlementPlanDetails(formData);

            //submission was successful
            if(res['isSuccessful']){
              setState(()=>isLoading = false); 
              showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: res['msg']);
            }
            //submission failed
            else{
              setState(()=>isLoading = false); 
              showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
            }

        }
        //submission failed
        else{
            setState(()=>isLoading = false); 
            showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: "Operation failed!");
        }

        */

        setState(()=>isLoading = true);
        Future.delayed( Duration(seconds: 2), (){  
          setState(()=>isLoading = false); 
          showAlertDialog(context: context, isLoading: false, isSuccess: true, completedMsg: "Operation successful");         
        });

      
    }


    //builds the search text field
    Widget _buildSearchTextField(){
      return  Container(
        child: Row(
          children: <Widget>[
            Expanded(                    
                  child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Enter Account Number",
                    labelText: "Find Customer",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: IconButton(
                      icon: Icon(Icons.account_circle, size: 24.0,),
                      onPressed: (){},
                    ),
                  ),
                  onChanged: (value){
                    if(value.toString().trim().length == 10){
                        _fetchCustomer(value);   
                    }
                    if(value.toString().trim().length == 0){
                      setState(()=>isCustomerAvailable = false);
                    }
                  },
                ),
            ),
          ],
        ),
      );
    }

    //builds the text field for entering the amount agreed
    //with the customer
    Widget _buildAmountAgreedTextField(){
        return TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Amount Agreed",
              hintText: "e.g 25000",
              fillColor: Colors.white,
              filled: true,
          ),
          validator: (String value){
            if(value.length == 0){
              return "Field is required";
            }
            return null;
          },
          onSaved: (newValue) => amountAgreed = newValue,
        );
    }

    //builds the text field for entering the frequency of payment
    //as agreed with the customer
    Widget _buildFrequencyTextField(){
        return TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Frequency of payment",
            hintText: "e.g 15234",
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (String value){
            if(value.length == 0){
              return "Field is required.";
            }
            return null;
          },
          onSaved: (newValue) => frequencyOfPayment = newValue,
        );
    }

    //build function
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Settlement Plan"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
          children: <Widget>[
            _buildSearchTextField(),
            SizedBox(height: 20.0),
            isCustomerAvailable ? Column(
              children: <Widget>[
                  CustomerInfoText("Customer Details", ''),
                  SizedBox(height: 15.0),
                  CustomerInfoText("Name:", "Egonu Ebuka"),
                  CustomerInfoText("Address:", "Trans-amadi, PH"),
                  CustomerInfoText("Account/Meter No:", "222222222"),
                  CustomerInfoText("Zone:", "Gamma"),
                  CustomerInfoText("Feeder:", "Eboi-Kutu"),
                  CustomerInfoText("Arrears:", "N50,000"),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildAmountAgreedTextField(),
                        SizedBox(height: 10.0),
                        _buildFrequencyTextField(),
                        SizedBox(height: 10.0),
                        //FileUploadButton(_setImages),
                        SizedBox(height: 15.0),
                        //ImageGridView(images),
                        SizedBox(height: 5.0),     
                        SubmitButton(_completeSettlementAction, isLoading, "SUBMIT")
                      ],
                    ),
                  )
                ],
              ) : Container(),
              ],
            ),
        ),
      );
  }
}

*/