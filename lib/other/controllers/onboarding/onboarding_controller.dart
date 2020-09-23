
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/base_url.dart';


/*
* Handles all actions regarding I-report module
*/
class OnboardingController{

  //String _baseUrl = "https://insight.phed.com.ng/api/PHEDConnectAPI";
  String _baseUrl = baseUrl;

   Future<Map<String,dynamic>> submit(Map<String,dynamic> data) async{
    
          http.Response response;
          Map<String, dynamic> _res = {};

          try{          

              print('submitting onboarding customer details...');
              print("Onboarding => "+ json.encode(data));
               
              response = await http.post("$_baseUrl/OnboardNewCustomer", 
                body: {
                "ApplicantsSignature": data["ApplicantsSignature"],
                "BookCode": data["BookCode"],
                "CapturedBy": data["CapturedBy"],
                "CommunityName": data["CommunityName"],
                "CustomerEmail": data["CustomerEmail"],
                "CustomerLoad": data["CustomerLoad"],
                "DTRCode": data["DTRCode"],
                "DTRName": data["DTRName"],
                "FeederId": data["FeederId"],               
                'FeederName':data["FeederName"],
                'filePaths': data["filePaths"],
                "HouseNo": data["HouseNo"],
                'LandMark': data["LandMark"],
                "Latitude": data["Latitude"],
                "Longitude": data["Longitude"],
                "LGA": data["LGA"],
                "MDA": data["MDA"],
                "MeansOfIdentification": data["MeansOfIdentification"],
                'MeterNo': data["MeterNo"],
                "NearbyAccountNo": data["NearbyAccountNo"],
                "Occupation": data["Occupation"],
                "OfficeEmail": data["OfficeEmail"],
                "DebulkingNumber": data["DebulkingNumber"],
                "OnboardCategory": data["OnboardCategory"],
                "OtherNames": data["OtherNames"],
                "ParentAccountNo": data["ParentAccountNo"],
                "Passport": data["Passport"],
                "PhoneNumber1": data["PhoneNumber1"],
                "PhoneNumber2": data["PhoneNumber2"],
                "State": data["State"],
                "Status": data["Status"],
                "StreetName": data["StreetName"],
                "Surname": data["Surname"],
                "TypeOfMeterRequired": data["TypeOfMeterRequired"],
                "TypeOfPremises": data["TypeOfPremises"],
                "UseOfPremises": data["UseOfPremises"],
                "UserId": data["UserId"],
                "ZipCode": data["ZipCode"],
                "Zone": data["Zone"],
                }
              );
             
              //print("disconn response: " + response.body);
              //print("response "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("UPLOAD RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Customer details captured and sumbitted successfully\nThank you for your time"
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