import 'dart:convert';

import '../../models/billDistribution/DTRToExec.dart';
import '../../screens/bill/constans.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;


class DTRToExecutiveController extends Model{


  Future<Map<String, dynamic>> getDTRByStaffId(String staffId) async{

    List<DTRToExecutive> list = [];
    http.Response response;
    var decodedRes;
    Map<String, dynamic> res;

    print("get dtr by staff method call successful");

    try{

      print("get dtr by staff id call initialized");
      response =
      await http.get(Constants.apiUrl +"/nomsapiwslim/v1/getDTRExecutiveDTRS?staffid=$staffId");

    
      print("state call response retured");
      print("response: ${response.body}");
      decodedRes = json.decode(response.body);
      print(decodedRes);


      if(response.statusCode == 200){

        //parse API response endpoint

        decodedRes.forEach((item){
          DTRToExecutive dtr = DTRToExecutive.createDTRToExecutive(item);
          list.add(dtr);
        });


        res = {
          "status": "SUCCESS",
          "data": list
        };

        //print(res);
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