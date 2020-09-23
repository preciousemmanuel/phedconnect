import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/settlement_duration.dart';
import 'package:http/http.dart' as http;

class SettlementDurationController{

      String _baseUrl = baseUrl;

      Future<Map<String, dynamic>> getSettlementDuration() async{
          
      http.Response response;
      var decodedRes;
      List<SettlementDuration> list = [];
      Map<String,dynamic> res;

      print("get settlement duration successful");

      try{

          print("get settlement duration call initiated...");
         
          response = await http.post("$_baseUrl/GetSettlementDuration");

          print("settlement api call response returned");
          print("response: ${response.body}");
          decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("dtr api call succssful");
               //parse API response endpoint
              decodedRes.forEach((item){
                  SettlementDuration sd = SettlementDuration.createSettlementDuration(item);
                  list.add(sd);
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
                "data": list,
                "message": "Couldn't fetch data"
              };

            }
      }
      catch(e){
            res = {
              "status": "FAILED",
              "data": list,
              "message": "Encountered an error. Couldn't connect to the server"
            };
            print(e.toString());
      }
      return res;
  }
}

