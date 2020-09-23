 import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';
import '../../data/base_url.dart';
import '../../models/customer.dart';
import '../../data/active_dtr.dart';


class RCDCActivitiesController{

    String _baseUrl = baseUrl;
   
    //This function calls the API end to fetch customers disconnection list activities
    //Method is executed from the "lib/screens/disconnection_list.dart" file
    Future<Map<String, dynamic>> myActivityDisconnection() async{

        http.Response response;
        List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;

        var endPoint = rcdcActivityFlag == "DC" ? "MyActivityDisconnection" : "MyActivityReconnection";
      
        try{
          //print("a");
              response = await http.post("$_baseUrl/$endPoint", 
              body: {
                "StaffID": authenticatedStaff.staffId,
                //"StaffID": "FT00300"
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
 } 