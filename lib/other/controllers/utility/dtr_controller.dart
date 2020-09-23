import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/dtr.dart';
import 'package:http/http.dart' as http;

class DTRController{

      String _baseUrl = baseUrl;

      Future<Map<String, dynamic>> getDTRByFeeder(String feederId) async{
          
      http.Response response;
      var decodedRes;
      List<DTR> list = [];
      Map<String,dynamic> res;

      print("get dtr method call successful");
    
      try{

          print("get dtr api call initiated...");
         
          response = await http.post("$_baseUrl/GetRCDCDTR",
            body: {
              "FeederId" : feederId
            }
          );

          print("dtr api call response returned");
          print("response: ${response.body}");
          decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("dtr api call succssful");
               //parse API response endpoint
              decodedRes.forEach((item){
                  DTR dtr = DTR.createDTR(item);
                  list.add(dtr);
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

