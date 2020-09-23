import 'dart:convert';
import 'package:http/http.dart' as http;



class KnoledgeBase{

   
    Future<Map<String, dynamic>> fetchKess({String fromDate, String toDate}) async{

        print("kess called successfully...");
        http.Response response;
        //List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;


        try{

            print("activity report api call initiated...");
            response = await http.get("http://10.0.2.2/PHEDSmartWorkForceUtility/public/fetch_kess"); 
            
            //print(response.toString());

            print(response.body);
            responseData = json.decode(response.body);
            
            if(response.statusCode == 200){
              
              print("kess items successful called...");
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
                "message": "We are sorry, temporarily unable to fetch kess items. Please try again later"
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