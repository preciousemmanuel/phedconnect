import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/zone.dart';
import 'package:http/http.dart' as http;



class ZoneController{
   
  String _baseUrl = baseUrl;

   Future<Map<String, dynamic>> getZones() async{
        
      http.Response response;
      var decodedRes;
      List<Zone> zoneList = [];
      Map<String, dynamic> res;

      print("get zone method call successful");
      try{
                
            print("get zone call initialized...");
            response = await http.post("$_baseUrl/GetRCDCZones");

            print("zone call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("zone call succssful");
              decodedRes.forEach((item){
                Zone zone = Zone.createZone(item);
                zoneList.add(zone);
              });

              res = {
                "status": "SUCCESS",
                "data": zoneList
              };

              print(res);
             
            }
            else{
              res = {
                "status": "FAILED",
                "message": "Couldn't fetch data"
              };

            }

             return res;
      
      }
      catch(e){
            res = {
              "status": "FAILED",
              "message": "Encountered an error. Couldn't connect to the server"
            };
            print(e.toString());
            return res;
      }

      

  }
}

