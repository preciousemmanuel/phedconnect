import 'package:customer_app/models/bill.dart';
import 'package:customer_app/models/payment.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

mixin BillModel on Model {
  Bill acccount;
  bool isLoading = false;
  String message = "";
  bool isCustomerFound = false;
  final customerInfoUrl =
      "https://dlenhanceuat.phed.com.ng/dlenhanceapi/Collection/GetCustomerInfo";

  bool get getLoading {
    return isLoading;
  }

  bool get getFoundStatus {
    return isCustomerFound;
  }

  Future<Map<String,dynamic>> checkAccount(String customerNumber, String customerType) {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> custData = {
      "apikey": "2E639809-58B0-49E2-99D7-38CB4DF2B5B20",
      "Username": "phed",
      "CustomerNumber": customerNumber,
      "Mobile_Number": "",
      "mailid": "",
      "CustomerType": customerType
    };
    print(custData);
    return http.post(customerInfoUrl, body: json.encode(custData), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    }).then((http.Response response) {
      print(response.body);
     

      if (response.body == "Customer Not Found") {
         isLoading = false;
        isCustomerFound = false;
        notifyListeners();
        return {"status":false,"message":"Customer not found"};

      } else {
        List responseListData = json.decode(response.body);
        Map<String, dynamic> responseData = responseListData.first;
        acccount = Bill(
          IBC_NAME: responseData["IBC_NAME"],
          BSC_NAME: responseData["BSC_NAME"],
          CONS_NAME: responseData["CONS_NAME"],
          METER_NO: responseData["ADDRESS"],
          CUSTOMER_NO: responseData["CUSTOMER_NO"],
          CONS_TYPE: responseData["CONS_TYPE"],
          CURRENT_AMOUNT: responseData["CONS_TYPE"]=="PREPAID"? responseData["CURRENT_AMOUNT"]:double.tryParse(responseData["CURRENT_AMOUNT"]),
          ADDRESS: responseData["ADDRESS"],
          TOTAL_BILL: double.parse(responseData["TOTAL_BILL"]),
          ARREAR: double.parse(responseData["ARREAR"]),
          TARIFFCODE: responseData["TARIFFCODE"],
        );
        isCustomerFound = true;
         isLoading = false;
         notifyListeners();
        return {"status":true,"message":"Customer found"};
      }

      
    }).catchError((error){
      print(error);
      isLoading = false;
      isCustomerFound = false;
    notifyListeners();
    return {"status":false,"message":"Oops!! Server issues.. try again later"};
    });
  }

  Future<Map<String,dynamic>> notifyPayment(String reference, int amount, String phone) async {
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy H:m:s');
  final String formatted = formatter.format(now);
    Map<String, dynamic> postData = {
     
        "Username": "phed",
        "apikey": "2E639809-58B0-49E2-99D7-38CB4DF2B5B20",
        "PaymentLogId": reference,
        "CustReference": acccount.CONS_TYPE == "POSTPAID"
            ? acccount.CUSTOMER_NO
            : acccount.METER_NO,
        "AlternateCustReference":reference,
        "Amount": amount,
        "PaymentMethod": "APP",
        "PaymentReference":reference,
        "TerminalID": null,
        "ChannelName": "MOBILE",
        "Location": null,
        "PaymentDate":formatted,
        "InstitutionName": null,
        "BankName": "PAYSTACK",
        "BranchName": "PAYSTACK",
        "CustomerName": acccount.CONS_NAME,
        "OtherCustomerInfo": null,
        "ReceiptNo": null,
        "CollectionsAccount": null,
        "BankCode": "001",
        "CustomerAddress": acccount.ADDRESS,
        "CustomerPhoneNumber": phone,
        "DepositorName": null,
        "DepositSlipNumber": null,
        "PaymentCurrency": "NGN",
        "ItemName": "Bill",
        "ItemCode": "01",
        "ItemAmount": amount,
        "PaymentStatus": "Success",
        "IsReversal": false,
        "SettlementDate": null,
        "Teller": null
      
    };
    

     //dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse("2019-09-30"));
   
    print(postData);
    print(formatted);
    try {
      isLoading = true;
    notifyListeners();
      final http.Response response=await http.post(
        "https://dlenhanceuat.phed.com.ng/dlenhanceapi/Collection/NotifyPayment",
        body: json.encode(postData),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
        print(response.body);
  

  
   Map<String, dynamic> responseData = json.decode(response.body);
    if(responseData.containsKey("Message") && responseData['Message']=="Duplicate Payment LogID"){
      isLoading = false;
    notifyListeners();
      return {"status":false,"message":"Duplicate Payment LogID"};
    }else if(responseData.containsKey("Message") && responseData['Message']=="UNKNOWN_ERROR"){
      isLoading = false;
    notifyListeners();
      return {"status":false,"message":"Oops !!! Error Validating Payment"};
    }
    else{
  
       List responseListData = json.decode(response.body);
        Map<String, dynamic> responseData = responseListData.first;
      var detail= responseData['DETAILS'].asMap();
      print(detail);
      
      Payment(amount: 100,token: responseData['TOKENDESC'] );
          isLoading = false;
    notifyListeners();
      return {"status":true,"message":"success"};

    }

    } catch (e) {
      print(e);
      isLoading = false;
    notifyListeners();
    return {"status":false,"message":"Oops! Error Validating payment"};
    }
   
  }

  Bill get customerAccount {
    return acccount;
  }
}
