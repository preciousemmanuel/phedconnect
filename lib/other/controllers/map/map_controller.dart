import 'dart:convert';
import '../../controllers/utility/map_contractor_controller.dart';
import '../../data/base_url.dart';
import 'package:http/http.dart' as http;



class MapController{
   
  String _baseUrl = baseUrl;
  MapContractorController mcc = MapContractorController();


    Future<void> test() async{

      http.get('url').timeout(
        Duration(seconds: 1),
        onTimeout: () {
          // time has run out, do what you wanted to do
          return null;
        },
      );

    }


  Future<Map<String, dynamic>> findCustomer(String accountNo) async{

        
        http.Response response;
        //List<Customer> rcList = [];
        //var customerD;
        Map<String, dynamic> res;
        var responseData;

        try{
          response = 
          await http.post("$_baseUrl/GetMAPCustomerDetails", 
          body: {
            "AccountNo": accountNo,
          });

          print(response.body);
          print("ddss :" +response.statusCode.toString());
          responseData = json.decode(response.body);
          
              
          if(response.statusCode == 200){
             
             if(responseData.length > 0){
                
                String mapVendor = "${responseData[0]["MAPVendor"]}";
                var contractors = await mcc.getMapContractor(mapVendor);
            
                  //parse API response endpoint
                /*  responseData.forEach((item){
                      Customer customer = Customer.createCustomer(item);
                      rcList.add(customer);
                  });
                */ 
                  //print(dcList.length.toString());

                  res = {
                    "status": "SUCCESS",
                    "contractorsList": contractors["data"],
                    "customerDetails": responseData[0],
                    "message": "SUCCESS",
                    "customerExist": true
                  };

                  print(json.encode(res));
                  
                  return res;
             }
             else{
                res = {
                    "status": "SUCCESS",
                    "contractorsList": [],
                    "customerDetails": null,
                    "message": "SUCCESS",
                    "customerExist": false
                  };
             }

             return res;
            
                  
            }
            else{
                return res = {
                  "status": "FAILED",
                  "message": response.statusCode == 404 ? responseData["Message"] : "Encountered an error..."
                };
            }

        }
        catch(e){
            print(e.toString());
            res = {
              "status": "ERROR",
              "message": "Ooop..System couldn't initiate your request. Please try again"
            };
        }

        return res;
    }

  Future<Map<String,dynamic>> submit(Map<String,dynamic> data) async{


      http.Response response;
      Map<String, dynamic> _res = {};

      try{      

         print(data["staffId"]);
         print(data["poleNo"]);
         print(data["sealOne"]);
         print(data["sealTwo"]);
         print(data["mapVendor"]);
         print(data["meterNo"]);
         print(data["meterInstallationComment"]);
         print(data["staffName"]);
         print(data["latitude"]);
         print(data["longitude"]);
         print(data["mapInstallerId"]);
         print(data["mapInstallerName"]);
         print(data["mapContractorId"]);
         print(data["mapContractorName"]);
         print(data["ticketId"]);

            
          print('submitting map capturing details...');
          print("map details: => "+ json.encode(data));

         /* response = await http.post("$_baseUrl/InstallMeters", 
            body: {
              "StaffId": data["staffId"],
              "PoleNo": data["poleNo"],
              "SealNo1": data["sealOne"],
              "SealNo2": data["sealTwo"],
              "MapVendor": data["mapVendor"],
              "MeterNo": data["meterNo"],
              "MeterInstallationComment": data["meterInstallationComment"],
              "StaffName": data["staffName"],
              "Latitude": data["latitude"],
              "Longitude": data['longitude'],
              "InstallerId": data["mapInstallerId"],
              "InstallerName": data["mapInstallerName"],
              "ContractorId": data["mapContractorId"],
              "ContractorName": data["mapContractorName"],
              "TicketID": data["ticketId"]
            }
          );
          */

           response = await http.post("$_baseUrl/InstallMeters", 
            body: {
             
              "MeterNo": data["meterNo"],
              "TicketId": data["ticketId"],
              "SealNo1": data["sealOne"],
              "SealNo2": data["sealTwo"],
              "InstallerId": data["mapInstallerId"],
              "ContractorID": data["mapContractorId"],
              "Latitude": data["latitude"],
              "Longitude": data['longitude'],
              "MapVendor": data["mapVendor"],
              "StaffId": data["staffId"],
              "AccountNo": "841758076001",
              "PoleNo": data["poleNo"],
              "MeterInstallationComment": data["meterInstallationComment"],
              "StaffName": data["staffName"],             
              "InstallerName": data["mapInstallerName"],
              "ContractorName": data["mapContractorName"],
              "filePahts": data["filePaths"]
            }
          );
          
          
          print("statusCode: "+ response.statusCode.toString());
        
          if(response.statusCode == 200){
              print("UPLOAD RESPONSE: ${response.body}"); 
              return _res = {
                  'isSuccessful': true,
                  'msg': "Meter captured successfully\nThank you for your time"
              }; 
            
          }
          //failed call
          else{
            print("UPLOAD RESPONSE: ${response.body}");
              return  _res = {
                  'isSuccessful': false,
                  'msg': "Aiish..Operation failed. Please try again!"
              };  
          }

          
  
      }
      catch(e){

          print(e.toString());          
          _res = {
            'isSuccessful': false,
            'msg': "Ooops..system couldn't complete action.Please try again"
          };
        
      }
      return _res;
      
  }



}

