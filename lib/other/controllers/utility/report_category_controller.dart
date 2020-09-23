import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/report_category.dart';
import 'package:http/http.dart' as http;

class ReportCategoryController{


      String _baseUrl = baseUrl;
      Future<Map<String,dynamic>> getReportCategory() async{
          
      http.Response response;
      var decodedRes;
      List<ReportCategory> list = [];
      Map<String, dynamic> res;

      print("report category method called successful...");

      try{

        print("get report category call initialized...");
        response = await http.post("$_baseUrl/GetReportCategory");
      

            print("get report api call response returned");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){

                //parse API response endpoint
                print("report category call successful");
                decodedRes.forEach((item){
                    ReportCategory reportCategory = ReportCategory.createReportCategory(item);
                    list.add(reportCategory);
                });

                res = {
                  "status": "SUCCESS",
                  "data": list
                };

                print(res);
                return res;
            }
            else{
              res = {
                "status": "FAILED",
                "message": "Couldn't fetch data",
                "data": list
              };

            }

      }
      catch(e){
          res = {
            "status": "FAILED",
            "message": "Encountered an error. Couldn't connect to the server",
            "data": list
          };
          print(e.toString());
          }

          return res;
      }
}

