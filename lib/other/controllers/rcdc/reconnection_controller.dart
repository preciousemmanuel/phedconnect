import 'dart:convert';


import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';
import '../../data/base_url.dart';
import '../../models/customer.dart';
import '../../models/customer_incidence.dart';
import '../../models/payment_history.dart';
import 'package:scoped_model/scoped_model.dart';

class ReconnectionController extends Model{

    //String _baseUrl = "http://insight.phed.com.ng/api/PHEDConnectAPI";
    String _baseUrl = baseUrl;

    Future<Map<String,dynamic>> reconnect(String disconnId) async{

          http.Response response;
          Map<String, dynamic> _res;

          try{          

              print('submitting reconnection details...');
              response = await http.post("$_baseUrl/ReconnectCustomer", 
                body: {"DisconnId": disconnId}
              );
             
              print("disconn response: " + response.body);
              print("response "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("UPLOAD RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Customer successfully reconnected!"
                  }; 
                
              }
              //failed call
              else{
                print("UPLOAD RESPONSE: ${response.body}");
                 return  _res = {
                      'isSuccessful': false,
                      'msg': "Operation failed"
                  };  
              }
     
          }
          catch(e){

              print(e.toString());          
             _res = {
                'isSuccessful': false,
                'msg': "Ooops..system couldn't complete action.Please try again"
              };
              return _res;
          }
    }

    Future<Map<String, dynamic>> fetchCustomerReconnectionList() async{

        http.Response response;
        List<Customer> rcList = [];
        Map<String, dynamic> res;
        var responseData;

        try{
          response = 
          await http.post("$_baseUrl/GetReconnectionList", 
          body: {
            "Zone": authenticatedStaff.zone,
            "FeederId": authenticatedStaff.feederId
            //"Zone": "PH-Zone1",
            //"FeederId": "108"
          });

          responseData = json.decode(response.body);
              
          if(response.statusCode == 200){
                                      
              //parse API response endpoint
              responseData.forEach((item){
                // print("xxx: "+ item.toString());
                  Customer customer = Customer.createCustomer(item);
                  rcList.add(customer);
              });
              
              //print(dcList.length.toString());

              return res = {
                "status": "SUCCESS",
                "data": rcList,
                "message": "SUCCESS"
              };
                  
            }
            else{
                print("b");
                return res = {
                  "status": "ERROR",
                  "message": response.statusCode == 400 ? responseData["message"] : "Encountered an error..."
                };
            }

        }
        catch(e){
            print(e.toString());
            res = {
              "status": "ERROR",
              "message": "Encountered an error...Please try again"
            };
        }

        return res;

    }
    
    Future<Map<String, dynamic>> fetchReconnDetails(Map<String, dynamic> data) async{
              
        http.Response response;
        Map<String, dynamic> res;
        List<PaymentHistory> paymentHistoryList = [];
        List<CustomerIncidence> incidenceHistoryList = [];
        var responseData;

        print("account no " + data["accountNo"]);
        print("date " + data["date"]);
        print("disconn Id " + data["disconnId"]);

        try{

          response = 
          await http.post("$_baseUrl/GetReconnectionPaymentHistory",
          body: {
            "AccountNo": data["accountNo"],
            "Date": data["date"],
            "DisconnId": data["disconnId"]
          }); 

          print(response.body);

          if(response.statusCode == 200){
              responseData = json.decode(response.body);
              //print(historyDetails["PaymentHistory"]);

              //parse API response endpoint
              responseData["PaymentHistory"].forEach((item){
                  PaymentHistory paymentHistory = PaymentHistory.createPaymentHistory(item);
                  paymentHistoryList.add(paymentHistory);
              });

              responseData["IncidenceHistory"].forEach((item){
                  CustomerIncidence incidence = CustomerIncidence.createCustomerIncidence(item);
                  incidenceHistoryList.add(incidence);
              });

              return res = {
                  "status": "SUCCESS",
                  "paymentHistoryList": paymentHistoryList,
                  "incidenceHistoryList": incidenceHistoryList,
                  "message": "SUCCESS"
              };

          }
          else{
            return res = {
                "status": "FAILED",
                "data": paymentHistoryList,
                "message": "No payment history was found for customer"
            };
              
          }
        }
        catch(e){
            res = {
                "status": "FAILED",
                "data": paymentHistoryList,
                "message": "Unable to fetch payment history"
            };
        }
         
         return res;
    }

    Future<Map<String, dynamic>> fetchPaymentHistory(String disconnId) async {
        
        http.Response response;
        Map<String, dynamic> historyDetails;
        Map<String, dynamic> res;
        List<PaymentHistory> paymentHistoryList = [];

        /*
        *Note
        * API endpoint is not working properly
        */

        try{

          response = 
          await http.post("$_baseUrl/GetCustomerPaymentHistory",
          body: {
            //"DisconnId": disconnId,
            "AccountNo": "810001007901"
          }); 

          if(response.statusCode == 200){
              historyDetails = json.decode(response.body);
              //print(historyDetails["PaymentHistory"]);

              //parse API response endpoint
              historyDetails["PaymentHistory"].forEach((item){
                  PaymentHistory paymentHistory = PaymentHistory.createPaymentHistory(item);
                  paymentHistoryList.add(paymentHistory);
              });

              return res = {
                  "status": "SUCCESS",
                  "data": paymentHistoryList,
                  "message": "SUCCESS"
              };

          }
          else{
            return res = {
                "status": "FAILED",
                "data": paymentHistoryList,
                "message": "No payment history was found for customer"
            };
              
          }
        }
        catch(e){
            res = {
                "status": "FAILED",
                "data": paymentHistoryList,
                "message": "Unable to fetch payment history"
            };
        }
         
         return res;
    }

    Future<Map<String, dynamic>> fetchBilledIncidence(Map<String,dynamic> data) async{

           http.Response response;
        List<CustomerIncidence> customerIncidenceList = [];
        Map<String, dynamic> returnRes;
        List res = [];
        
        /*
        *Note
        * API endpoint is not working properly
        */
        print(data["accountNo"]);
        print(data["dateOfLastPayment"]);
        print(data["accountType"]);
        print(data["reasonForDisconnectionId"]);
        print(data["phase"]);

        try{
            response = 
            await http.post("$_baseUrl/DisconnectionCustomerIncidences",
            body: {
              "AccountNo": data["accountNo"],
              "DateOfLastPayment": data["dateOfLastPayment"],
              "AccountType": data["accountType"],
              "ReasonForDisconnectionId": data["reasonForDisconnectionId"],
              "Phase": data["phase"]
            });
        
            print("incidencessss ${response.body}");

            if(response.statusCode == 200){
                res = json.decode(response.body);
                print(res.length.toString());
              

                //parse API response endpoint
                res.forEach((item){
                    CustomerIncidence incidence = CustomerIncidence.createCustomerIncidence(item);
                    customerIncidenceList.add(incidence);
                });

                return returnRes = {
                    "status": "SUCCESS",
                    "data": customerIncidenceList,
                    "message": "SUCCESS"
                };

            }
            else{
                return returnRes = {
                    "status": "FAILED",
                    "data": customerIncidenceList,
                    "message": "No incidence found"
                };
            }
        }
        catch(e){
             returnRes = {
                    "status": "ERROR",
                    "data": customerIncidenceList,
                    "message": "System couldn't fetch incidences. Please try again!"
                };
        }

        return returnRes;

    }

    Future<Map<String, dynamic>> verifyReconnectionStatus(String accountNo) async{
        
        http.Response response;
        List<Customer> rcList = [];
        Map<String, dynamic> res;
        var responseData;

        try{
          response = 
          await http.post("$_baseUrl/CheckEligibilityForReconnection", 
          body: {
            "AccountNo": accountNo,
          });

          print(response.body);
          print(response.statusCode.toString());
          responseData = json.decode(response.body);
              
          if(response.statusCode == 200){
                                      
              //parse API response endpoint
              responseData.forEach((item){
                  Customer customer = Customer.createCustomer(item);
                  rcList.add(customer);
              });
              
              //print(dcList.length.toString());

              return res = {
                "status": "SUCCESS",
                "data": rcList,
                "message": "SUCCESS"
              };
                  
            }
            else{
                return res = {
                  "status": "FAILED",
                  "message": response.statusCode == 404 ? responseData["Message"] : "Encountered an error..."
                };
            }

        }
        catch(e){
            print(e.toString());
            res = {
              "status": "ERROR",
              "message": "Ooop..System couldn't initiate your request. Please try again"
            };
        }

        return res;
    }
}