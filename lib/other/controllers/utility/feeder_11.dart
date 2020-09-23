
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../screens/bill/constans.dart';


class Feeder11Controller{


  Future<Map<String, dynamic>> getFeeder11(String feederId) async{
        
      http.Response response;
      var decodedRes;
      //var vendorList = [];
      Map<String, dynamic> res;

      print("get map vendor method call successful");
      try{
                
            print("get feeder 11kv call initialized...");
            response = await http.get(Constants.apiUrl+"/nomsapiwslim/v1/getfeeder11byfeeder33kv?feeder33id=$feederId");

            print("map vendor call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("feeder 33kv call succssful");
             /* decodedRes.forEach((item){
                Vendor vendor = Vendor.createZone(item);
                vendorList.add(vendor);
              });
              */

              res = {
                "status": "SUCCESS",
                "data": decodedRes
              };
             // return decodedRes;

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