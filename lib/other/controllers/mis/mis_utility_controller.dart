
import 'dart:convert';
import '../../screens/bill/constans.dart';
import 'package:http/http.dart' as http;
import '../../data/base_url.dart';


/*
* Handles all actions regarding I-report module
*/
class MISUtilityController{

  //String _baseUrl = "https://insight.phed.com.ng/api/PHEDConnectAPI";
  String _baseUrl = baseUrl;

   Future<Map<String,dynamic>> dtrDisconnect(Map<String,dynamic> data) async{


          http.Response response;
          Map<String, dynamic> _res = {};

          try{          
              print('initiating dtr disconnect call...');
              print("dtr-disconnect-report: => "+ json.encode(data));
      
              response = await http.post("$_baseUrl/DisconnectCustomerDTR", 
                body: {
                  "AccountNumber": data["AccountNumber"],
                  "AccountType": data["AccountType"],
                  "Phase": data["Phase"],
                  "AverageBillReading": data["AverageBillReading"],
                  "Comments": data["Comments"],
                  "Tariff": data["Tariff"],
                  "TariffRate": data["TariffRate"],
                  "StaffId": data["StaffId"],
                  "GangID": data["GangID"],
                  "Latitude": data["Latitude"],
                  "Longitude": data["Longitude"],
                  "CustomerEmail": data["CustomerEmail"],
                  "CustomerPhone": data["CustomerPhone"],
                  "DisconNoticeNo": data["DisconnectionNoticeNo"],
                  "ReasonForDisconnectionId": data["ReasonForDisconnection"],
                  "DisconnID": data[ "DisconnID"]               
                }
              );
             
              print("dtr disconnect response: " + response.body);
              print("dtrD responsexx: "+ response.statusCode.toString());

              //successful call
              if(response.statusCode == 200){
                 print("DTR  DISCONNECT RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Customer with account number ${data["AccountNumber"]} was disconnected successfully\nThank you for your time"
                  }; 
                
              }
              //failed call
              else{
                print("UPLOAD RESPONSE: ${response.body}");
                 return  _res = {
                      'isSuccessful': false,
                      'msg': "Aiish..Operation failed. Please try again!"
                  };  
              }
     
          }
          catch(e){

              print(e.toString());          
              _res = {
                'isSuccessful': false,
                'msg': "Ooops..system couldn't complete action.Please try again"
              };
            
          }
          return _res;
          
    }


    Future<Map<String,dynamic>> tarrifChange(Map<String,dynamic> data) async{


          http.Response response;
          Map<String, dynamic> _res = {};

          try{          

              print('initiating tarrif change call...');
              print("tarrif-change-report: => "+ json.encode(data));
      
              response = await http.post("$_baseUrl/TariffClassChange", 
                body: {
                  "CapturedBy" : data["CapturedBy"],
                  "CustomerEmail" : data["CustomerEmail"],
                  "CustomerPhone" : data["CustomerPhone"],
                  "DTRCode": data["DTRCode"],
                  "DTRName" : data["DTRName"],
                  "FeederId" : data["FeederId"],
                  "FeederName" : data["FeederName"],
                  "HouseNo" : data["HouseNo"],
                  "Latitude": data["Latitude"],
                  "Longitude": data["Longitude"],
                  "MeterNo": data["MeterNo"],
                  "ParentAccountNo": data["AccountNo"],
                  "UseOfPremises" : data["UseOfPremises"],
                  "AccountName": data["AccountName"],
                  "StreetName": data["StreetName"],
                  "TypeOfPremises": data["TypeOfPremises"],
                  "UserId": data["UserId"],
                  "StaffId": data["StaffId"],
                  "Zone": data["Zone"],
                  "OldTariff": data["OldTariff"],
                  "NewTariff": data["NewTariff"],
                  "Comment": data["Comment"],
                  
                }
              );
             
              print("tarrif change response: " + response.body);
              print("tarrif response xx: "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("DTR  DISCONNECT RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Tariff change request for account number ${data["AccountNo"]} submitted successfully\nThank you for your time"
                  }; 
                
              }
              //failed call
              else{
                print("UPLOAD RESPONSE: ${response.body}");
                 return  _res = {
                      'isSuccessful': false,
                      'msg': "Aiish..Operation failed. Please try again!"
                  };  
              }
     
          }
          catch(e){

              print(e.toString());          
              _res = {
                'isSuccessful': false,
                'msg': "Ooops..system couldn't complete action.Please try again"
              };
            
          }
          return _res;
          
    }

}