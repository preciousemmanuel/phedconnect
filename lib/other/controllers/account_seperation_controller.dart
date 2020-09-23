
import 'dart:convert';
import '../screens/bill/constans.dart';
import 'package:http/http.dart' as http;
import '../data/base_url.dart';


class AccountSeperation{


          String _baseUrl = baseUrl;

          Future<Map<String,dynamic>> seperateAccount(Map<String,dynamic> data) async{

          http.Response response;
          Map<String, dynamic> _res = {};

          try{          

              print('initiating account seperation call...');
              print("account seperation payload: => "+ json.encode(data));

              String params = "primaryaccount=${data["primaryaccount"]}";
              params += "&requestbyid=${data["requestbyid"]}";
              params += "&requestbyname=${data["requestbyname"]}";
              params += "&requestdate=${data["requestdate"]}";
              params += "&noofseparation=${data["noofseparation"]}";
              params += "&dtrid=${data["dtrid"]}";
              params += "&feeder33id=${data["feeder33id"]}";
              params += "&feeder11id=${data["feeder11id"]}";

              print(params);
              print(Constants.apiUrl +"/nomsapiwslim/v1/saveaccountseperation?$params");

              Map<String, String> headers = {
                  'Content-Type': 'multipart/form-data',
                  "Cache-Control": "no-cache"
              };
      
              response = await http.post(
                Constants.apiUrl +"/nomsapiwslim/v1/saveaccountseperation?$params",
                //url,
                headers: headers
              );
             
              print("account seperation response: " + response.body);
              print("account seperation response xx: "+ response.statusCode.toString());

                //successful call
              if(response.statusCode == 200){
                 print("ACCOUNT SEPERATION RESPONSE: ${response.body}"); 
                  return _res = {
                      'isSuccessful': true,
                      'msg': "Account Seperation request for account number ${data["primaryaccount"]} submitted successfully\nThank you for your time"
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

    Future<Map<String, dynamic>> pendingApprovalParentAccount() async{

        print("pending parent account called successfully...");
        http.Response response;
        //List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;

        try{

            print("pending parent api call initiated...");
            response = await http.get(Constants.apiUrl +"/nomsapiwslim/v1/getAllPendingPrimaryAccounts");
              
            print(response.body);
            responseData = json.decode(response.body);
            
            if(response.statusCode == 200){
              
              print("pending parent items successful called...");
              print(json.decode(response.body));
                  
              return res = {
                "status": "SUCCESS",
                "data": responseData,
                "message": "SUCCESS"
              };
                
            }
            else{
              print("b");
              return res = {
                "status": "ERROR",
                "message": "We are sorry, temporarily unable to fetch pending accounts for approval. Please try again later"
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


}