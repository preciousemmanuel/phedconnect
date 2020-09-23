
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/base_url.dart';


/*
* Handles all actions regarding I-report module
*/
class IReportController{

  //String _baseUrl = "https://insight.phed.com.ng/api/PHEDConnectAPI";
  String _baseUrl = baseUrl;

   Future<Map<String,dynamic>> submit(Map<String,dynamic> data) async{


          http.Response response;
          Map<String, dynamic> _res = {};

          try{          

              print('submitting disconnection details...');
              print("i-report: => "+ json.encode(data));

              /*
              "Zone": "PH-Zone1",
                  "CustomerName": "emma",
                  "IreportersPhoneNo": "383323233",
                  "IreportersEmail;": "ema@gmail.com",
                  "Status": "i-report",
                  "FeederId": "108",
                  "AccountName": "ema",
                  "Address": "Abouloma",
                  "DTR_Id": "152",
                  "Comments": "stealing energy",
                  "StaffId": "29323",
                  "ReportCategory": "energy",
                  "ReportSubCategory": "theft",
                  "PhoneNo": "89898989",
                  "Email": "ekj@gmail.com",
                  "AccountNo": "898989898989",
                  "DateReported": "24/3/3",
                  "Latitude": "7.323233",
                  "Longitude": "3.32323",
                  "UserId": "eeewewe"
                */
             
              response = await http.post("$_baseUrl/Ireport", 
                body: {
                  "Zone": data["Zone"],
                  "CustomerName": data["CustomerName"],
                  "IreportersPhoneNo": data["IreportersPhoneNo"],
                  "IreportersEmail": data["IreportersEmail"],
                  "Status": data["Status"],
                  "FeederId": data["FeederId"],
                  "AccountName": data["CustomerAccountName"],
                  "Address": data["CustomerAddress"],
                  "DTR_Id": data["DTR_Id"],
                  "Comments": data["Comments"],
                  "StaffId": data["StaffId"],
                  "ReportCategory": data["ReportCategory"],
                  "ReportSubCategory": data["ReportSubCategory"],
                  "PhoneNo": data["CustomerPhoneNo"],
                  "Email": data["CustomerEmail"],
                  "AccountNo": data["CustomerAccountNo"],
                  "DateReported": data["DateReported"],
                  "Latitude": data["Latitude"],
                  "Longitude": data["Longitude"],
                  "UserId": data["UserId"],
                  "filePaths": data["filePaths"]
                }
              );
             
              //print("disconn response: " + response.body);
              //print("response "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("UPLOAD RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "i-Report sumbitted successfully\nThank you for your time"
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