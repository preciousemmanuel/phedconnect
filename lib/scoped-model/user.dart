
import 'package:customer_app/models/authmode.dart';
import 'package:customer_app/models/user.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'dart:convert';
import 'package:customer_app/models/user.dart';
import 'package:http/http.dart' as http;
// import '../data/authenticated_User.dart';
import '../other/data/base_url.dart';

// import '../models/User.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin UserModel on Model{

    User _authenticatedUser;
    

     

   String _baseUrl = baseUrl; 
    
    //getter for authenticated User
    User get user{
      return _authenticatedUser;
    }

    //setter for authenticated User
    void _setAuthUser(User user){
        //_authenticatedUser variable is from lib/data/authenticated_User.dart
        _authenticatedUser = user;
    }

    /*
    * Responsible for making call to the Login API and
    * Processing response from API call
    */
    Future<Map<String, dynamic>> login(String email, String password, [AuthMode mode = AuthMode.Login]) async{

          http.Response response;
          Map<String, dynamic> _res;

          try{          

              print('Authenticating User...');


              //call to api
              if (mode == AuthMode.Login) {
              response = await http.post("$_baseUrl/Login", body:{
                "username": email,
                "password": password
              });
              }else{
                response = await http.post("$_baseUrl/Register", body:{
                "username": email,
                "password": password
              });
              }
              //decode API response
              Map<String, dynamic> responseData = json.decode(response.body);

              //Valid User credentials
              if(response.statusCode == 200 && responseData["Status"] == "SUCCESSFUL"){    
                  print("response: ${response.statusCode.toString()}");   
                  print("responseData: ${response.body.toString()}");  
                  //print("feederId:" + responseData["FeederId"]);
                  _authenticatedUser=User(email: email, accountNo: responseData['accountNo']) ;                    
                  _create_authenticatedUser(responseData);
                  
                   //success response message
                  _res = {
                      'isSuccessful': true,
                      'msg': "Logged in successfully"
                  };

              }
              //Invalid User credentials
              else{

                    //error response message
                    String errorMsg = responseData["Message"];
                    _res = {
                      'isSuccessful': false,
                      'msg': errorMsg
                    };
              }

              //return response to API calling function (lib/screens/login.dart)
              return _res;
                    
          }
          catch(e){

            //API error call
            print('Authentication failed');
              return _res = {
                'isSuccessful': false,
                'msg': "Ooop..couldn't connect. Please try again!"
              };
          }
  
      }

      //create an authenticated User instance
      void _create_authenticatedUser(Map<String, dynamic> responseData) async{   

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("authUser", json.encode(responseData));

         // User user = User.createUser(responseData);
          // _setAuthUser(user);        
      }

} 