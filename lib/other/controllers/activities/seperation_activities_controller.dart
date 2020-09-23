import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';
import '../../data/base_url.dart';


class SeperationActivityController{

    String _baseUrl = baseUrl;
   
    //This function calls the API end to fetch customers disconnection list activities
    //Method is executed from the "lib/screens/disconnection_list.dart" file
    Future<Map<String, dynamic>> myActivitySeperation() async{

        http.Response response;
        //List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;

        try{
         
            response = await http.post("$_baseUrl/MyActivitySeparation", 
            body: {
              "StaffID": authenticatedStaff.staffId,
              //"StaffID": "27966"
            });

            //print(response.toString());

            print(response.body);
            responseData = json.decode(response.body);
            
            if(response.statusCode == 200){
              
              print(json.decode(response.body));
                 
                //print(dcList.length.toString());
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
 } 