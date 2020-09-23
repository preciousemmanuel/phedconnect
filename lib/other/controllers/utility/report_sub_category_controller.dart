import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/report_sub_category.dart';
import 'package:http/http.dart' as http;

class ReportSubCategoryController{

      String _baseUrl = baseUrl;
      Future<Map<String,dynamic>> getSubReportCategory(String reportCatId) async{
          
      http.Response response;
      var decodedRes;
      List<ReportSubCategory> list = [];
      Map<String, dynamic> res;

      print("report category sub  method called successful...");

      try{

        print("get report sub category call initialized...");
        response = await http.post("$_baseUrl/GetReportSubCategory",
        body: {
          "ReportCategoryId" : reportCatId
        });
      

            print("get sub report api call response returned");
            print("response: ${response.body}");
            print("response: ${response.statusCode}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){

                //parse API response endpoint
                print("report sub category call successful");
                decodedRes.forEach((item){
                    ReportSubCategory reportSubCategory = ReportSubCategory.createReportSubCategory(item);
                    list.add(reportSubCategory);
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

