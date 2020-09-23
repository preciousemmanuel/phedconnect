
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/authenticated_staff.dart';
import '../../screens/bill/constans.dart';


class Feeder33Controller{


  Future<Map<String, dynamic>> getFeeder33() async{
        
      http.Response response;
      var decodedRes;
      //var vendorList = [];
      Map<String, dynamic> res;

      print("get map vendor method call successful");
      try{
            
            String url;
            if(Constants.bdCustomer != null && Constants.bdCustomer == "MD"){
               url = Constants.apiUrl+"/nomsapiwslim/v1/getFeeder33kv?feedermgrid="
               +authenticatedStaff.staffId+"&ismd=1";
            }
            else{
              url = Constants.apiUrl+"/nomsapiwslim/v1/getFeeder33kv?feedermgrid="
               +authenticatedStaff.staffId+"&ismd=0";
            }
            print("get feeder 33kv call initialized...");
            response = await http.get(url);

            print(url);

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