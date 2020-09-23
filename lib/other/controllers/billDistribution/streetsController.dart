import 'dart:convert';

import '../../data/active_dtr.dart';
import '../../data/authenticated_staff.dart';
import '../../models/billDistribution/streets_model.dart';
import '../../models/customer.dart';
import '../../screens/bill/constans.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class StreetsController extends Model {
  Future<Map<String, dynamic>> getStreetsByDtrid() async {
    http.Response response;
    List<StreetsModel> streets = [];
    Map<String, dynamic> res;

    try {
      response = await http.get(Constants.apiUrl +"/nomsapiwslim/v1/getstreetsbyDtrid?dtrid=$activeDTR");

      print("XXXwer " + response.body.toString());
      if (response.statusCode == 200) {
        var streetsJsonObjects = json.decode(response.body);

        streetsJsonObjects.forEach((item) {
          print("xxx: " + item.toString());
          StreetsModel streetsModel = StreetsModel.createStreets(item);
          print(streetsModel.community);
          print(streetsModel.streetName);
          print(streetsModel.streetcode);
          streets.add(streetsModel);
        });

        print(streets.toString());

        res = {
          "status": "SUCCESS",
          "data": streets,
          "message": "Successfully fetched streets"
        };
      } else {
        res = {
          "status": "FAILED",
          "data": streets,
          "message": "Operation failed...Couldn't fetch streets"
        };
      }
    } catch (e) {
      res = {
        "status": "FAILED",
        "data": streets,
        "message":
            "Operation failed...Encountered an error while trying to connect.Please try again"
      };
    }

    return res;
  }

  //get customers by streets

  Future<Map<String, dynamic>> getCustomersByStreets(String streetId) async {
    print("xxxx2-streetid: " + streetId);
    http.Response response;
    List<Customer> customers = List<Customer>();
    List streetsJsonObjects = List();
    String actionCount = '';
    Map<String, dynamic> res;

    try {
      print(
          Constants.apiUrl+"/nomsapiwslim/v1/getcustomersbystreetid?streetId=" +
              streetId);
      print(Constants.apiUrl+"/nomsapiwslim/v1/getcustomersbystreetid?streetId=" +
              streetId+"&staffid="+authenticatedStaff.staffId);
              
      response = await http.get(
          Constants.apiUrl+"/nomsapiwslim/v1/getcustomersbystreetid?streetId=" +
              streetId+"&staffid="+authenticatedStaff.staffId);

      print("XXXwer " + response.body.toString());

      if (response.statusCode == 200) {
        
        streetsJsonObjects = json.decode(response.body);

        if(streetsJsonObjects.length > 0){
            
            var dataList = streetsJsonObjects[0];
            var cntList = streetsJsonObjects[1];
            actionCount = cntList[0]["cnt"];
            print("Action countL: " +actionCount.toString());


            dataList.forEach((item) {
              print("xxx: " + item.toString());

              Customer customer = Customer.createCustomersbystreets(item);

              print(customer.accountName);
              print(customer.address);
              customers.add(customer);
            });

            res = {
              "status": "SUCCESS",
              "data": customers,
              "count": actionCount,
              "message": "API call was successful"
            };
        }
        else{
            res = {
              "status": "SUCCESS",
              "data": customers,
              "count": actionCount,
              "message": "API call was successful"
            };
        }
       
      } else {
        res = {
          "status": "FAILED",
          "data": customers,
          "count": '',
          "message": "API call failed"
        };
      }

      return res;
    } catch (e) {
      return res = {
        "status": "FAILED",
        "data": customers,
        "count": '',
        "message": "Error Occurred"
      };
    }
  }

  /*
    * Responsible for making call to the Login API and
    * Processing response from API call
    */

  Future<Map<String, dynamic>> addStreet(
      String state,
      String lga,
      String community,
      String lastbusstop,
      String nlandmark,
      String streetname,
      String dtrid,
      String staffid,
      String streettype) async {
    http.Response response;
    Map<String, dynamic> _res;
    print("xxx " + dtrid);

    print("state: $state");
    print("lga: $lga");
    print("community: $community");
    print("lastbusstop: $lastbusstop");
    print("nlandmark: $nlandmark");
    print("streetname: $streetname");
    print("dtrid: $dtrid");
    print("userid: $staffid");
    print("streettype: $streettype");

    try {
      print('saving street...');
      //call to api
      response = await http.post(
          Constants.apiUrl+"/nomsapiwslim/v1/addstreettoDtrid",
          body: {
            "Stateid": state, //state,
            "lgaid": lga, //lga,
            "nlandmark": nlandmark,
            "last_bus_stop": lastbusstop,
            "street_name": streetname,
            "dtrid": dtrid,
            "community": community,
            "userid": authenticatedStaff.staffId,
            "streettype": streettype
          },
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print("xxy " + response.body);

      //Successful call
      if (response.body.toString() == "1") {
        //print(response.body);
        //print("added successfully");

        //success response message
        _res = {'isSuccessful': true, 'msg': "Street Added successfully"};
      }
      //Invalid staff credentials
      else {
        _res = {
          'isSuccessful': false,
          'msg': "Failed to add street. Please try again"
        };
      }

      return _res;
    } catch (e) {
      _res = {'isSuccessful': false, 'msg': "Failed to add street"};
    }

    return _res;
  }
}
