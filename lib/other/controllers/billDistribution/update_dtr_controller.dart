import 'package:http/http.dart' as http;
import '../../screens/bill/constans.dart';

class UpdateDTRController {
  Future<Map<String, dynamic>> updateDTR(Map<String, dynamic> data) async {
    http.Response response;
    //var vendorList = [];
    Map<String, dynamic> res;

    print("get  method call successful");
    try {
      print(data["feeder33name"]);
      print(data["feeder11name"]);
      print(data["dtrName"]);
      print(data["accountNo"]);
      print(data["staffId"]);

      print("get zone call initialized...");
      response = await http.post(
          Constants.apiUrl+"/nomsapiwslim/v1/mdUpdateDTRDetails",
          body: {
            "feeder33name": data["feeder33name"],
            "feeder11name": data["feeder11name"],
            "dtrname": data["dtrName"].toString(),
            "accountno": data["accountNo"].toString(),
            "staffid": data["staffId"].toString(),
            "lat": data["latitude"],
            "lon": data["longitude"],
            "dtrid": data["dtrid"],
            "capacity": data["capacity"]
          });

      print("map vendor call response retured");
      print("response: ${response.body}");
      //decodedRes = json.decode(response.body);

      //parse API response endpoint
      if (response.statusCode == 200) {
        print("zone call succssful");
        /* decodedRes.forEach((item){
                Vendor vendor = Vendor.createZone(item);
                vendorList.add(vendor);
              });
              */

        res = {"status": "SUCCESS", "data": 'DTR updated successfully'};
        // return decodedRes;

        print(res);
      } else {
        res = {"status": "FAILED", "message": "Couldn't fetch data"};
      }

      return res;
    } catch (e) {
      res = {
        "status": "FAILED",
        "message": "Encountered an error. Couldn't connect to the server"
      };
      print(e.toString());
      return res;
    }
  }

  Future<Map<String, dynamic>> updateNewDTR(Map<String, dynamic> data) async {
      http.Response response;
      //var vendorList = [];
      Map<String, dynamic> res;

      print("get  method call successful");
      try {
        print(data["feeder33name"]);
        print(data["feeder11name"]);
        print(data["dtrName"]);
        print(data["accountNo"]);
        print(data["staffId"]);

        print("get zone call initialized...");
        response = await http.post(
            Constants.apiUrl+"/nomsapiwslim/v1/mdUpdateNewDTRDetails",
            body: {
              "feeder33name": data["feeder33name"],
              "feeder11name": data["feeder11name"],
              "dtrname": data["dtrName"].toString(),
              "accountno": data["accountNo"].toString(),
              "staffid": data["staffId"].toString(),
              "lat": data["latitude"],
              "lon": data["longitude"],
              "dtrid": data["dtrid"],
              "capacity": data["capacity"],
              "feeder33id": data["feeder33id"],
              "feeder11id": data["feeder11id"],
              "dtrexec": data["dtrexec"],
            });

          print("map vendor call response retured");
          print("response: ${response.body}");
          //decodedRes = json.decode(response.body);

          //parse API response endpoint
          if (response.statusCode == 200) {
            print("zone call succssful");
            /* decodedRes.forEach((item){
                    Vendor vendor = Vendor.createZone(item);
                    vendorList.add(vendor);
                  });
                  */

            res = {"status": "SUCCESS", "data": response.body};
            // return decodedRes;

            print(res);
          } else {
            res = {"status": "FAILED", "message": "Couldn't save data"};
          }

          return res;
        } catch (e) {
          res = {
            "status": "FAILED",
            "message": "Encountered an error. Couldn't connect to the server"
          };
          print(e.toString());
          return res;
        }
  }
}
