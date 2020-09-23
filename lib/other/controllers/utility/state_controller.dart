import 'dart:convert';
import '../../data/base_url.dart';
import '../../models/utility/state.dart';
import 'package:http/http.dart' as http;

class StateController{

 String _baseUrl = baseUrl;

  Future<Map<String, dynamic>> getStates() async{
        
      http.Response response;
      var decodedRes;
      List<RCDCState> stateList = [];
      Map<String, dynamic> res;

      print("get state method call successful");

      try{
         
          print("get state call initialized");
          response = await http.post("$_baseUrl/GetRCDCState");

          print("state call response retured");
          print("response: ${response.body}");
          decodedRes = json.decode(response.body);
          

          if(response.statusCode == 200){

              //parse API response endpoint

              print("state call successful");
              decodedRes.forEach((item){
                  RCDCState state = RCDCState.createState(item);
                  stateList.add(state);
              });

                res = {
                "status": "SUCCESS",
                "data": stateList
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