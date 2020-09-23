import 'dart:convert';


import '../../screens/bill/constans.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class SavePremisedetailController extends Model {
   
  Future getFeederName(String feederid) async {
   
    http.Response getFeederNameResult;
   

    getFeederNameResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/getFeederNameByFeederCode?feedercode=" +
        feederid);
    print("XXXwer " + getFeederNameResult.body.toString());

    return getFeederNameResult.body.toString();
  }

  Future getDTRNameName(String dtrid, String feederid) async {
    http.Response getDTRNameResult;

    getDTRNameResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/getDTRNameByDTRCode?dtrcode=" +
        dtrid+"&feedercode=" +
        feederid);
    print("XXXwerdtr " + getDTRNameResult.body.toString());

    return getDTRNameResult.body.toString();
  }

  Future getEnrolmentAreaName(String enrolmentareaid) async {
    http.Response getEnrolmentAreaNameResult;

    getEnrolmentAreaNameResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/getVerificationAreaNameByAreaCode?enrolmentareaid=" +
        enrolmentareaid);
    print("XXXwer " + getEnrolmentAreaNameResult.body.toString());

    return getEnrolmentAreaNameResult.body.toString();
  }

  Future getStreetName(String streetid, String enrolmentareaid) async {
    http.Response getStreetNameResult;

    getStreetNameResult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/getVerificationStreetNameByStreetCodeandAreaCode?streetcode=" +
        streetid+"&enrolmentareaid=" +
        enrolmentareaid);
    print("XXXStreet streetid" + getStreetNameResult.body.toString());

    return getStreetNameResult.body.toString();
  }

 

  Future<Map<String, dynamic>> savecustomerpremisedetail(
      String selectedArea,
      String feederid,
      String dTRID,
      String poleNo,
      String upriserNo,
      String streetID,
      String streetenteringfrom,
      String pIN,
      String userid,
      String noofCustomers,
      String premisesType,
      String lat,
      String lon,
      String streetAddress,
      String closestLandMark) async {
    http.Response response;
    Map<String, dynamic> _res;
    var somearar = {
      "selectedArea": selectedArea,
      "streetAddress": streetAddress,
      "closestLandMark": closestLandMark,
      "feederid": feederid,
      "dtrcode": dTRID,
      "upriserNo": upriserNo,
      "streetID": streetID,
      "streetenteringfrom": streetenteringfrom,
      "poleno": poleNo,
      "userid": userid,
      "lat": lat,
      "lon": lon,
      "noofCustomers": noofCustomers,
      "premisesType": premisesType,
      "pin": pIN
    };
    print(somearar);

    try {
      print('saving street...');
      //call to api
      response = await http.post(
          Constants.apiUrl + "/nomsapiwslim/v1/saveEnumsVerificationPremise",
          body: {
            "selectedArea": selectedArea,
            "streetAddress": streetAddress,
            "closestLandMark": closestLandMark,
            "feederid": feederid,
            "dtrcode": dTRID,
            "upriserNo": upriserNo,
            "streetID": streetID,
            "streetenteringfrom": streetenteringfrom,
            "poleno": poleNo,
            "userid": userid,
            "lat": lat,
            "lon": lon,
            "noofCustomers": noofCustomers,
            "premisesType": premisesType,
            "pin": pIN
          },
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print("response " + response.body);
      //decode API response
      // Map<String, dynamic> responseData = json.decode(response.body);

      //Valid staff credentials
     var rowString = response.body.toString();
     rowString =rowString.replaceAll('"', '').trim();
      if (int.parse(rowString) > 0) {
         Constants.premiseid = rowString;
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

  savecustomerdetail(String isseperation,String premiseid,String nameOfCustomer, String customerPhone, String customerEmail, String ext,
   String selectedConnectionType, String selectedMeterType, String acctNo, String meterNoPostPaid,
    String tarriffclass, String vacantStatus, String meterCondition, String typeOfBuilding,String remarks) async {
    
    http.Response response;
    Map<String, dynamic> _res;
   var somearray =  {
            "nameOfCustomer": nameOfCustomer,
            "customerPhone": customerPhone,
            "customerEmail": customerEmail,
            "flatno": ext,
            "conntype": selectedConnectionType,
            "metertype": selectedMeterType,
            "acctNo": acctNo,
            "meterno": meterNoPostPaid,
            "tarriffclass": tarriffclass,
            "vacantStatus": vacantStatus,
            "meterCondition": meterCondition,
            "typeOfBuilding": typeOfBuilding,
            "userid": "authenticatedStaff.email",
            "remarks": remarks,
            "premiseid":premiseid,
            "isseperation":isseperation
          };
               print(somearray);
    try {
      //call to api
      response = await http.post(
          Constants.apiUrl + "/nomsapiwslim/v1/saveEnumsVerificationCustomerDetail",
          body: {
            "nameOfCustomer": nameOfCustomer,
            "customerPhone": customerPhone,
            "customerEmail": customerEmail,
            "flatno": ext,
            "conntype": selectedConnectionType,
            "metertype": selectedMeterType,
            "acctNo": acctNo,
            "meterno": meterNoPostPaid,
            "tarriffclass": tarriffclass,
            "vacantStatus": vacantStatus,
            "meterCondition": meterCondition,
            "typeOfBuilding": typeOfBuilding,
            "userid": "authenticatedStaff.email",
            "remarks": remarks,
            "premiseid":Constants.premiseid, 
            "isseperation":isseperation
          },
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print("response " + response.body);
      //decode API response
      // Map<String, dynamic> responseData = json.decode(response.body);

      //Valid staff credentials
      if (response.body.toString()!= "0") {
         
        //success response message
        _res = {'isSuccessful': true, 'msg': "Data saved successfully"};
      }
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

  getAccountNo(String acctNo) async {
   http.Response getacctnameresult = await http.get(Constants.apiUrl +
        "/nomsapiwslim/v1/getAccountnamebyaccountno?acctno=" +
        acctNo);
    print("XXXwer " + getacctnameresult.body.toString());

    return getacctnameresult.body.toString();
  }

   Future<Map<String, dynamic>> getalltariff() async {
 http.Response response;
    var decodedRes;
     Map<String, dynamic> res;
     try{
     response = await http.get(Constants.apiUrl +"/nomsapiwslim/v1/getalltarriff");
    print("response " + response.body.toString());
     decodedRes = json.decode(response.body);
 //parse API response endpoint
      if (response.statusCode == 200) {
       

        res = {"status": "SUCCESS", "data": decodedRes};
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

}
