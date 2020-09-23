
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/base_url.dart';


/*
* Handles all actions regarding I-report module
*/
class FeedbackController{

  //String _baseUrl = "https://insight.phed.com.ng/api/PHEDConnectAPI";
  String _baseUrl = baseUrl;

   Future<Map<String,dynamic>> submit(Map<String,dynamic> data) async{


          http.Response response;
          Map<String, dynamic> _res = {};

          try{          

              print('submitting disconnection details...');
              print("feedback-report: => "+ json.encode(data));
      
              response = await http.post("$_baseUrl/GetStaffSuggestions", 
                body: {
                  "StaffId": data["StaffId"],
                  "StaffName": data["StaffName"],
                  "StaffPhone": data["StaffPhone"],
                  "Email": data["Email"],
                  "Comments": data["Comments"],
                  "Latitude": data["Latitude"],
                  "Longitude": data["Longitude"],
                  "ModuleName": data["ModuleName"],
                }
              );
             
              print("disconn response: " + response.body);
              print("response "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("FEEDBACK RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Feedback sumbitted successfully\nThank you for your time"
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