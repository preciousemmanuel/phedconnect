import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/feeder.dart';
import '../../screens/bill/constans.dart';
import 'package:http/http.dart' as http;

class FeederController{

      String _baseUrl = baseUrl;

      Future<Map<String,dynamic>> getFeederByZone(String zone) async{
          
      http.Response response;
      var decodedRes;
      List<Feeder> list = [];
      Map<String, dynamic> res;

      print("get feeder method called successful...");

      try{

        print("get feeder call initialized...");
        response = await http.post("$_baseUrl/GetRCDCFeeder",
        body: {
          "Zone" : zone
        });

          print("feeder api call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){

                //parse API response endpoint
                print("feeder call successful");
                decodedRes.forEach((item){
                    Feeder feeder = Feeder.createFeeder(item);
                    list.add(feeder);
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
                "message": "Couldn't fetch data"
              };

            }

      }
      catch(e){
          res = {
            "status": "FAILED",
            "message": "Encountered an error. Couldn't connect to the server"
          };
          print(e.toString());
          }

          return res;
      }

      Future<Map<String,dynamic>> getFeeder11ByFeeder33(String feederId) async{
          
      http.Response response;
      var decodedRes;
      List<Feeder> list = [];
      Map<String, dynamic> res;

      print("get feeder11 method called successful...");
      print("11kv feeder:"+feederId);

      try{

            print("get feeder 11 call initialized...");
            response = await http.get(Constants.apiUrl+"/nomsapiwslim/v1/getfeeder11byfeeder33kv?feeder33id=$feederId");
            
            print("feeder 11 api call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){

                //parse API response endpoint
                print("feeder 11 call successful");
                decodedRes.forEach((item){
                    Feeder feeder = Feeder.createFeeder11(item);
                    print(feeder.feederName);
                    print(feeder.feederId);
                    list.add(feeder);
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
                "message": "Couldn't fetch data"
              };

            }

      }
      catch(e){
          res = {
            "status": "FAILED",
            "message": "Encountered an error. Couldn't connect to the server"
          };
          print(e.toString());
          }

          return res;
      }
}

