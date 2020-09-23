import 'dart:convert';


import 'package:http/http.dart' as http;
import '../../data/base_url.dart';
import '../../models/customer.dart';
import 'package:scoped_model/scoped_model.dart';
String _baseUrl = baseUrl;

class RPDController extends Model{

  
    Future<Map<String, dynamic>> findCustomer(String accountNo) async{
        
        http.Response response;
        List<Customer> rcList = [];
        Map<String, dynamic> res;
        var responseData;

        try{
          response = 
          await http.post("$_baseUrl/GetcustomerdetailsByAccountNo", 
          body: {
            "AccountNo": accountNo,
          });

          print(response.body);
          print(response.statusCode.toString());
          responseData = json.decode(response.body);
              
          if(response.statusCode == 200){
                                      
              //parse API response endpoint
              responseData.forEach((item){
                  Customer customer = Customer.createCustomer(item);
                  rcList.add(customer);
              });
              
              //print(dcList.length.toString());

              return res = {
                "status": "SUCCESS",
                "data": rcList,
                "message": "SUCCESS"
              };
                  
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
}