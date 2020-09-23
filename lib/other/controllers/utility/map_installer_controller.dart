import 'dart:convert';
import '../../data/base_url.dart';
import 'package:http/http.dart' as http;

class MapInstallerController{

    String _baseUrl = baseUrl;
    Future<Map<String, dynamic>> getMapInstaller(String contractorId) async{
        
      http.Response response;
      var decodedRes;
      //List<Installer> installerList = [];
      Map<String, dynamic> res;

      print("get vendor method call successful");
      try{
                
            print("get map instller call initialized...");
            response = await http.post("$_baseUrl/GetMAPInstallerDetails", body: {
              "ContractorId": contractorId
            });

            print("map instller call response retured");
            print("response: ${response.body}");
            decodedRes = json.decode(response.body);
          

            //parse API response endpoint
            if(response.statusCode == 200){
              
              print("zone call succssful");
            /*  decodedRes.forEach((item){
                Installer installer = Installer.createZone(item);
                installerList.add(installer);
              });
            */

              res = {
                "status": "SUCCESS",
                "data": decodedRes
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

