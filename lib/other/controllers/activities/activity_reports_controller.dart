import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';



class ActivityReportsController{

   
    Future<Map<String, dynamic>> myActivityReports({String fromDate, String toDate}) async{

        print("activity report method called...");
        http.Response response;
        //List<Customer> dcList = [];
        Map<String, dynamic> res;
        var responseData;


        try{

            print("activity report api call initiated...");
            response = await http.post("http://10.0.2.2/PHEDSmartWorkForceActivityReport/public/activity_report", 
            body: {
              "staffId": authenticatedStaff.staffId,
              "staffEmail": authenticatedStaff.email,
              "fromDate": fromDate,
              "toDate": toDate
              //"StaffID": "27966"
            });

            //print(response.toString());

            print(response.body);
            responseData = json.decode(response.body);
            
            if(response.statusCode == 200){
              
              print("activity report successful called...");
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
                "message": "We are sorry, temporarily unable to generate reports. Please try again later"
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