import 'dart:convert';
import '../../data/base_url.dart';
import 'package:http/http.dart' as http;


class CheckAppVersionController{

     String _baseUrl = baseUrl;
     Future<Map<String,dynamic>> getLatestVersion() async{
          
      http.Response response;
      var decodedRes;
      Map<String, dynamic> res;

      print("app version call successful");
      try{
          
          print("app version call initialized");
          response = await http.post("$_baseUrl/CheckAppVersion");
            
            print("app version response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);

            print(decodedRes.toString());

            if(response.statusCode == 200){
              
                //parse API response endpoint
                res = {
                  "status": "SUCCESS",
                  "version": decodedRes["Current_Version"],
                  "message": decodedRes["UserMessage"]
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