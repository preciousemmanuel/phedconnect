import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';
import '../../data/base_url.dart';
import '../../models/customer.dart';
import '../../models/payment_history.dart';
import '../../models/rcdc_incidence.dart';
import '../../models/customer_incidence.dart';
import 'package:scoped_model/scoped_model.dart';



class DisconnectionController extends Model{

  
   // String _baseUrl = "http://insight.phed.com.ng/api/PHEDConnectAPI";

    String _baseUrl = baseUrl;


    Future<Map<String,dynamic>> disconnect(Map<String,dynamic> data) async{


          http.Response response;
          Map<String, dynamic> _res;

          print("Lat: ${data['Latitude']}");
          print("Long: ${data['latitude']}");
          print("tarif: ${data['Tariff']}");
          print("phase: ${data['Phase']}");
          print(data.toString());

         
          try{          

              print('submitting disconnection details...');
              print("disconn Details: " + json.encode(data));
              response = await http.post("$_baseUrl/DisconnectCustomer", 
                body: {
                "GangID": data["GangID"],
                "Longitude": data["Latitude"],
                "Latitude": data["Longitude"],
                "Comments": data["Comments"],
                "DisconnId": data["DisconnId"],
                "UserId": data["UserId"],
                "AccountType": data["AccountType"],
                "AccountNo": data["AccountNo"],
                "StaffId": data["StaffId"],
                "CustomerEmail": data["CustomerEmail"],
                "CustomerPhone": data["CustomerPhone"],
                "AverageBillReading": data["AverageBillReading"],
                "DateOfLastPayment": data["DateOfLastPayment"],
                "ReasonForDisconnectionId": data["ReasonForDisconnectionId"],
                "Phase": data["Phase"],
                "Tariff": data["Tariff"],
                "filePaths": data["filePaths"],
                "Settlement_Period": data["Settlement"],
                "Settlement_Amount": data["SettlementAmount"],
                "Settlement_Status": data["SettlementStatus"],
                "Flag": data["flag"],
                "ListOfAppliances": data["listOfAppliances"]
              }
                  
                
              );

              print("flsdfd");
             
             print("disconn response: " + response.body);
             print("response "+ response.statusCode.toString());

              Map<String,dynamic> res = json.decode(response.body);

                //successful call
              if(response.statusCode == 200){
                 print("UPLOAD RESPONSE: ${response.body}"); 
                 print(res["Message"]);
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Customer with Account Number ${data["AccountNo"]} successfully disconnected!"
                  }; 
                
              }
              //failed call
              else{
                print("fsfdsdfds");
                //print("UPLOAD RESPONSE: ${response.body}");
                 return  _res = {
                      'isSuccessful': false,
                      'msg': "Operation failed"
                  };  
              }
     
          }
          catch(e){
              print("fsfsdffooooooo");
              print(e.toString());          
             _res = {
                'isSuccessful': false,
                'msg': "Ooops..system couldn't complete action.Please try again"
              };
              return _res;
          }

          

          
    }


    //This function calls the API end to fetch customers disconnection list
    //Method is executed from the "lib/screens/disconnection_list.dart" file
    Future<Map<String, dynamic>> fetchCustomerDisconnectionList() async{

        http.Response response;
        List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;

        //API call
        //response = await http.get("http://10.0.2.2/PHEDConnect/rclist.php");
        try{
          //print("a");
              response = await http.post("$_baseUrl/DisconnectionList", 
              body: {
                "Zone": authenticatedStaff.zone,
                "FeederId": authenticatedStaff.feederId
              });

             // print(response.toString());

            print(response.body);
            responseData = json.decode(response.body);
            
            if(response.statusCode == 200){
              //  print(json.decode(response.body));
                
                
               //parse API response endpoint
                responseData.forEach((item){
                  // print("xxx: "+ item.toString());
                    Customer customer = Customer.createCustomer(item);
                    dcList.add(customer);
                });
                
                //print(dcList.length.toString());

                return res = {
                  "status": "SUCCESS",
                  "data": dcList,
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
          res = {
                "status": "ERROR",
                "message": "Encountered an error...Please try again"
              };
        }

        return res;
        
    }

    // Handles the API call to fetch RCDC incidences
    Future<List<RCDCIncidence>> fetchListOfIncidences() async{

        http.Response response;
        List<RCDCIncidence> incidenceList = [];

        response = 
        await http.post("$_baseUrl/GetRCDCReasonsForDisconnection");

        print("incidences: "+ response.body);
        var res = json.decode(response.body);
        print("incidences01"+ res.toString());
       
        //parse API response endpoint
        res.forEach((item){
            RCDCIncidence incidence = RCDCIncidence.createRCDCIncidence(item);
            incidenceList.add(incidence);
        });

        return incidenceList;
 
    }

    //Handles the API call to fetch customer payment History
    Future<Map<String,dynamic>> fetchPaymentHistory(String accountNo) async{
        
        http.Response response;
        Map<String, dynamic> historyDetails;
        Map<String, dynamic> res;
        List<PaymentHistory> paymentHistoryList = [];

        //print("accountNo: dfsflkdflsfdsl");

        /*
        *Note
        * API endpoint is not working properly
        */

        try{

          response = 
          await http.post("$_baseUrl/GetCustomerPaymentHistory",
          body: {
            "AccountNo": accountNo,
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
       // print(paymentHistoryList.length.toString());

    }


    //Handles the API call for fetching
    Future<Map<String, dynamic>> fetchCustomerIncidences(Map<String, dynamic> data) async{
        http.Response response;
        List<CustomerIncidence> customerIncidenceList = [];
        Map<String, dynamic> returnRes;
        List res = [];
        bool hasSettlement = false;
        String settlementAmount;
        
        /*
        *Note
        * API endpoint is not working properly
        */
        print(data["accountNo"]);
        print(data["dateOfLastPayment"]);
        print(data["accountType"]);
        print(data["reasonForDisconnectionId"]);
        print(data["phase"]);
        print(data["flag"]);
        print(data["loadProfile"].toString());
        print(data["availability"].toString());
        print(data["duration"].toString());
        print(data["tariff"].toString());
        //data["dateOfLastPayment"] = "6/5/2020";'
     

        try{
            response = 
            await http.post("$_baseUrl/DisconnectionCustomerIncidences",
            body: {
              "AccountNo": data["accountNo"],
              "DateOfLastPayment": data["dateOfLastPayment"] != null ? data["dateOfLastPayment"] : "6/6/2020",
              "AccountType": data["accountType"],
              "ReasonForDisconnectionId": data["reasonForDisconnectionId"],
              "Phase": data["phase"],
              "Tariff": data["tariff"],
              "Flag": data["flag"],
              "LoadProfile": data["loadProfile"].toString(),
              "Duration": data["duration"] != null ? data["duration"] : '',
              "Availability": data['availability'] != null ? data["availability"] : ''
            });
        
           print("incidencessss ${response.body}");

            if(response.statusCode == 200){
                res = json.decode(response.body);
                print(res.length.toString());
              

                //parse API response endpoint
                res.forEach((item){
                    
                    if(item["Settlement"] == "YES"){
                       hasSettlement = true;
                       settlementAmount = item["SettlementAmount"];
                        print(item["hasSettlement"]);
                        print(item["SettlementAmount"]);

                    }
                    CustomerIncidence incidence = CustomerIncidence.createCustomerIncidence(item);
                    customerIncidenceList.add(incidence);
                });

                return returnRes = {
                    "status": "SUCCESS",
                    "data": customerIncidenceList,
                    "hasSettlement": hasSettlement,
                    "settlementAmount": settlementAmount,
                    "message": "SUCCESS"
                };

            }
            else{
                return returnRes = {
                    "status": "FAILED",
                    "data": customerIncidenceList,
                    "hasSettlement": hasSettlement,
                    "settlementAmount": settlementAmount,
                    "message": "No incidence found"
                };
            }
        }
        catch(e){
             returnRes = {
                    "status": "ERROR",
                    "data": customerIncidenceList,
                    "hasSettlement": hasSettlement,
                    "settlementAmount": settlementAmount,
                    "message": "System couldn't fetch incidences. Please try again!"
                };
        }

        return returnRes;

              
    }

}