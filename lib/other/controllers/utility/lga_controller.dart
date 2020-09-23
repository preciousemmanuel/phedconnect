import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/lga.dart';
import 'package:http/http.dart' as http;


class LGAController{

     String _baseUrl = baseUrl;
     Future<Map<String,dynamic>> getLGAs(String stateId) async{
          
      http.Response response;
      var decodedRes;
      List<LGA> list = [];
      Map<String, dynamic> res;

      print("lga method call successful");
      try{
          
          print("get lga call initialized");
          response = await http.post("$_baseUrl/GetRCDCLGA",
            body: {
              "State_Id" : stateId
            }
          );

            print("lga call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);

            if(response.statusCode == 200){
              
              //parse API response endpoint
              print("lga call successful");
              decodedRes.forEach((item){
                  LGA state = LGA.createState(item);
                  list.add(state);
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