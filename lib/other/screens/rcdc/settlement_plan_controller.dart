

/*

import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

class SettlementPlanController extends Model{

  //Method for handling the submission of "settlement plan" details
  //accepts a formData parameter
  Future<Map<String, dynamic>> uploadSettlementPlanDetails(FormData formData) async{

        Response response;
        Map<String, dynamic> _res;
          try {
              print("DIO: calling end upload endpoint....");
              Options options = Options(
                  headers: {
                    "Content-Type": "multipart/form-data"
                  }
              );
              response = await Dio().post("http://10.0.2.2/PHEDConnect/index.php", 
                data: formData, 
                options: options,
                onSendProgress: (sent, total) {
                    if (total != -1) {
                      print("Sending: "+ (sent / total * 100).toStringAsFixed(0) + "%");
                    }
                },
                onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print("Recieving: "+ (received / total * 100).toStringAsFixed(0) + "%");
                    }
                },
              );  

              //successful call
              if(response.statusCode == 200){
                  _res = {
                      'isSuccessful': true,
                      'msg': "Operation successful"
                  }; 
                  print("UPLOAD RESPONSE: $response"); 
              }
              //failed call
              else{
                  _res = {
                      'isSuccessful': false,
                      'msg': "Operation failed"
                  }; 
                  print("UPLOAD RESPONSE: $response"); 
              }
          } catch (e) {
            // error in calling the API point
              _res = {
                  'isSuccessful': false,
                  'msg': "Ooops..something went wrong."
              }; 
              print("DIO: Erro occured => $e");
          }

          return _res;
   }
}

*/