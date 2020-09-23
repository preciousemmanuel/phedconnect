
import 'dart:convert';
import '../../data/base_url.dart';
import 'package:http/http.dart' as http;


class MapContractorController{


  String _baseUrl = baseUrl;
  Future<Map<String, dynamic>> getMapContractor(String mapVendor) async{
        
      http.Response response;
      var decodedRes;
      //var vendorList = [];
      Map<String, dynamic> res;

      print("get map vendor method call successful");
      try{
                
            print("get zone call initialized...");
            response = await http.post("$_baseUrl/GetMAPContractorDetails", body: {
              "MapVendor": mapVendor
            });

            print("map vendor call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("zone call succssful");
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