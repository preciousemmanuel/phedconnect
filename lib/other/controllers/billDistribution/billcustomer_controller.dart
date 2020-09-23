import 'dart:convert';

import '../../data/authenticated_staff.dart';
import '../../models/customer.dart';
import '../../screens/bill/constans.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class BillCustomerController extends Model {
  BillCustomerController();
  Future<List<Customer>> getCustomerByAccountno(String accountno) async {
    http.Response searchResult;
    List<Customer> returnedCustomer = [];
    searchResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/searchCustomerByAccountNo?accountno=" +
        accountno);
    print("XXXwer " + searchResult.body.toString());
    var streetsJsonObjects = json.decode(searchResult.body);
    streetsJsonObjects.forEach((item) {
      print("xxx: " + item.toString());
      Customer c = Customer.searchedCustomer(item);
      print(c.accountName);
      print(c.accountNo);
      returnedCustomer.add(c);
    });

    return returnedCustomer;
  }

  Future<List<Customer>> searchDTR(String dtrname) async {
    http.Response searchResult;
    List<Customer> returnedCustomer = [];
    print(Constants.apiUrl +
        "/nomsapiwslim/v1/searchdtrbyname?dtrname=" +
        dtrname +
        "&feedermgrid=" +
        authenticatedStaff.staffId);
    searchResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/searchdtrbyname?dtrname=" +
        dtrname +
        "&feedermgrid=" +
        authenticatedStaff.staffId);
    print("XXXwer " + searchResult.body.toString());
    var streetsJsonObjects = json.decode(searchResult.body);
    streetsJsonObjects.forEach((item) {
      print("xxx: " + item.toString());
      Customer c = Customer.searcheddtrbyname(item);
      // print(c.accountName);
      // print(c.accountNo);
      returnedCustomer.add(c);
    });

    return returnedCustomer;
  }

  Future<Map<String, dynamic>> upDateBillCustomer(
      String email,
      String phoneno,
      String poleno,
      String dtrcode,
      String streetname,
      String streetno,
      String accountno,
      String userid,
      String houseHoldCountCommercial,
      String houseHoldCountResidential,
      String lat,
      String lon) async {
    http.Response response;
    Map<String, dynamic> _res;
    print("xxxdf " + streetname);
    print("houseHoldCountResidential " + houseHoldCountResidential);
    print("userid " + userid);
    print("email " + email);
    print("streetno " + streetno);
    print("dtrcode " + dtrcode);

    try {
      print('saving street...');
      //call to api
      response = await http.post(
          Constants.apiUrl + "/nomsapiwslim/v1/billUpdatecustomer",
          body: {
            "streetname": streetname,
            "dtrcode": dtrcode,
            "streetno": streetno,
            "email": email,
            "phoneno": phoneno,
            "poleno": poleno,
            "userid": userid,
            "lat": lat,
            "lon": lon,
            "accountno": accountno,
            "houseHoldCountResidential": houseHoldCountResidential,
            "houseHoldCountCommercial": houseHoldCountCommercial,
            "streetcode":
                Constants.bdCustomer == "MD" ? "0" : Constants.streetCode
          },
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print("response " + response.body);
      //decode API response
      // Map<String, dynamic> responseData = json.decode(response.body);

      //Valid staff credentials
      if (response.body.toString() == "1") {
        //success response message
        _res = {'isSuccessful': true, 'msg': "Data saved successfully"};
      }
      //Invalid staff credentials
      else {
        //error response message
        // String errorMsg = responseData["Message"];
        _res = {'isSuccessful': false, 'msg': "An error has occured!"};
      }
    } catch (e) {
      //error response message
      // String errorMsg = responseData["Message"];
      _res = {'isSuccessful': false, 'msg': "An error has occured!"};
      print(e.toString());
    }

    //return response to API calling function (lib/screens/login.dart)
    return _res;
  }

  Future<Map<String, dynamic>> addBillNewCustomer(
      String bookcode,
      String email,
      String phoneno,
      String poleno,
      String dtrcode,
      String streetname,
      String streetno,
      String accountno,
      String userid,
      String lat,
      String lon,
      String landmark,
      String customerName,
      String streetid,
      String houseHoldCountCommercial,
      String houseHoldCountResidential) async {
    http.Response response;
    Map<String, dynamic> _res;
    print("xxx " + streetid.toString());

    //try{

    //call to api
    response = await http
        .post(Constants.apiUrl + "/nomsapiwslim/v1/billaddnewcustomer", body: {
      "address": streetname,
      "bookcode": bookcode,
      "dtrcode": dtrcode,
      "streetno": streetno,
      "email": email,
      "phoneno": phoneno,
      "poleno": poleno,
      "userid": userid,
      "accountno": accountno,
      "customername": customerName,
      "lon": lon,
      "lat": lat,
      "landmark": landmark,
      "streetCode": Constants.bdCustomer == "MD" ? "0" : streetid,
      "staffId": userid,
      "houseHoldCountCommercial": houseHoldCountCommercial,
      "houseHoldCountResidential": houseHoldCountResidential
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    print("response " + response.body.toString());
    //decode API response
    // Map<String, dynamic> responseData = json.decode(response.body);

    //Valid staff credentials
    if (response.body == "1") {
      //success response message
      _res = {'isSuccessful': true, 'msg': "Data saved successfully"};
    }
    //Invalid staff credentials
    else {
      //error response message
      // String errorMsg = responseData["Message"];
      _res = {
        'isSuccessful': false,
        // 'msg': errorMsg
      };
    }

    //return response to API calling function (lib/screens/login.dart)
    return _res;
  }

  Future<Map<String, dynamic>> saveDeliverBillAction(
      String remarks,
      String action,
      String lat,
      String lon,
      String staffID,
      String presentreading,
      String streetCode,
      String accountno,
      String meterno,
      String filepath,String redPhase,String bluePhase,String yellowPhase) async {
    http.Response response;
    Map<String, dynamic> _res;
    print("xxx " + lat.toString());

    print("lat: $lat");
    print("remarks: $remarks");
    print("lon: $lon");
    print("action: $action");
    print("staff id: $staffID");
    print("presentreading: $presentreading");
    print("streetcode: ${Constants.streetCode}");
    print("accountno: $accountno");
    print("meterno: $meterno");
    print("filepath: $filepath");

    //    try{

    print('saving street...');
    //call to api
    response = await http.post(
        Constants.apiUrl + "/nomsapiwslim/v1/saveBillDeliveredAction",
        body: {
          "lat": lat,
          "remarks": remarks,
          "lon": lon,
          "action": action,
          "userid": staffID,
          "presentreading": presentreading,
          "streetCode": Constants.streetCode,
          "accountno": accountno,
          "meterno": meterno != null ? meterno : '',
          "filepath": filepath,
              "redPhase": redPhase,
          "bluePhase": bluePhase,
          "yellowPhase": yellowPhase,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    print("xxx " + response.body);
    //decode API response
    // Map<String, dynamic> responseData = json.decode(response.body);

    //Valid staff credentials
    if (response.body.toString() == "1") {
      //success response message
      _res = {'isSuccessful': true, 'msg': "Logged in successfully"};
    }
    //Invalid staff credentials
    else {
      //error response message
      // String errorMsg = responseData["Message"];
      _res = {
        'isSuccessful': false,
        // 'msg': errorMsg
      };
    }
    /* }catch(e){
              _res = {
                      'isSuccessful': false,
                      'msg': e.toString()
                    };
          }*/

    //return response to API calling function (lib/screens/login.dart)
    return _res;
  }
}
