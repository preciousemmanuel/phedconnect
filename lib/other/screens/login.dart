



import 'dart:io';
import 'package:customer_app/models/authmode.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'package:customer_app/scoped-model/user.dart';
import 'package:flutter/material.dart';
// import '../controllers/auth_controller.dart';
import '../widgets/login/curve_clipper.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info/device_info.dart';


class LoginScreen extends StatefulWidget {

    final MainModel model = MainModel();
    //LoginScreen(this.model);

    @override
    _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   AuthMode _authMode=AuthMode.Login;
  GlobalKey<FormState> loginFormKey = new GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  
  String email;
  String password;
  bool isSubmitting = false;
  bool obscureText = true;
  String _deviceModel = "Unknown";



  _staffSignin() async{

      //start loading spinner
      setState (() => isSubmitting = true);

      Map<String, dynamic> res;
      // make call to api login
      // authentication controller @lib/controller/auth
      res = await widget.model.login(email, password);
      
      //show success snackbar
      if(res['isSuccessful']){
          setState (() => isSubmitting = false);
          _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
          _redirect();
      }
      //show failed snackbar
      else{
          _showSnackBar(isSuccessSnack: res['isSuccessful'], msg: res['msg']);
          setState (() => isSubmitting = false);
      }   
  } 



  @override
  void initState() {
    initPlatformState();
    super.initState();  
  }

  @override
  void dispose() {  
    super.dispose();
  }



  
 Future<void> initPlatformState() async {
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;
    String deviceModel;


    try {
        if (Platform.isAndroid) {
          androidInfo = await deviceInfo.androidInfo;
          deviceModel = androidInfo.model;
          print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
        } else if (Platform.isIOS) {
          iosInfo = await deviceInfo.iosInfo;
          deviceModel = iosInfo.utsname.machine;
          print('Running on ${iosInfo.utsname.machine}'); 
        }
    } on PlatformException {
        print('Error: Failed to get platform version.');
    }

    if (!mounted) return;

    setState(() {
      _deviceModel = deviceModel;
    });
  }


  

  //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg}){

        //create snackbar
        var snackBar =  SnackBar(
            backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
            duration: Duration(seconds: isSuccessSnack ? 3 : 5),
            content: Text(msg,
            style: TextStyle(
              color: Colors.white
            ),),
        );

        //show snackbar
        scaffoldKey.currentState.showSnackBar(snackBar);
        if(isSuccessSnack){
          loginFormKey.currentState.reset();
        }
  }

  //redirect on successful login
  void _redirect(){
      Future.delayed(Duration(seconds: 1), (){
          Navigator.pushReplacementNamed(context, '/');
      });
  }

  //Email Field Widget
  Widget _buildEmailTextField(){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(             
          decoration: InputDecoration(
            fillColor: Colors.grey[200],                   
            filled: true,
            hintText: "Customer Email",
            prefixIcon: Icon(Icons.account_box),
            contentPadding: EdgeInsets.only(top: 16.0),
          ),
          onSaved: (value) => email = value
        ),
      );
  }

  //Password Field Widget
  Widget _buildPasswordTextField(){
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "Password",
              prefixIcon: Icon(Icons.lock),
              contentPadding: EdgeInsets.only(top: 16.0),
              suffixIcon: IconButton(
                icon: Icon( obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: (){
                  setState(() {
                      obscureText = !obscureText;
                  });
                },
              )
            ),
            validator: (String value){
              return value.length < 6 ? "Minimum of 6 characters required": null;
            },
            onSaved: (value) => password = value
        ),
      );
  }


  

  //submit button widget
  Widget _buildSubmitButton(){
      return GestureDetector(
          onTap: (){
            if(loginFormKey.currentState.validate()){
                loginFormKey.currentState.save();
                _staffSignin();
              }
              //Navigator.pushNamed(context, '/modules');
          },
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0),
          alignment: Alignment.center,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.green
          ),
          child: Text(
            _authMode==AuthMode.Login?"LOGIN":"SIGNUP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600
              ),
          ),
        ),
      );
  }

  _launchURL() async {
    const url = 'https://insight.phed.com.ng/Account/RecoverAccount';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: deviceHeight,
          child: Form(
              key: loginFormKey,
              child: Column(
              children: <Widget>[
                Stack(
                  children:[
                     ClipPath(
                      clipper: CurveClipper(),
                      child: Image(
                      image: AssetImage("assets/images/lbg_1.jpg"),
                      height: deviceHeight / 2.5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                    child: IconButton(icon: Icon(Icons.arrow_back,size: 30.0,), onPressed: (){
                      Navigator.of(context).pop();
                    }))
                  ]
                )
                 ,
                 
                  SizedBox(height: 8.0),
                  Image(
                      image: AssetImage("assets/images/headerLogo.jpg"),
                      fit: BoxFit.contain,
                      height: 60.0,
                  ),
                  /*Text(
                    "PHEDConnect",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25.0,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold
                    ),
                  ),*/
                  // SizedBox(height: 10.0),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal:16.0),
                    child: Text(
                      "Users are to login with bill verification credentials",
                      style: TextStyle(
                        color: Colors.red
                      )
                    ),
                  ),*/
                  _buildEmailTextField(),
                  SizedBox(height: 8.0),
                 _buildPasswordTextField(),
                  SizedBox(height: 18.0),
                  !isSubmitting ? _buildSubmitButton() : CircularProgressIndicator(),
                  SizedBox(height: 15.0),
                    FlatButton(onPressed: (){
                      setState(() {
                          _authMode=_authMode==AuthMode.Login?AuthMode.Signup:AuthMode.Login;
                      });
                     
                    }, child: Text(_authMode==AuthMode.Login?"Dont have an account? Signup":"Already have an account? Login")),
                  SizedBox(height: 15.0),
                  InkWell(
                      onTap: _launchURL,
                      child: Text(
                      "Password Reset"
                    ),
                  ),
              ],
            ),
          ),
        )
      ),
        bottomSheet: Container(
              height: 20.0,
              padding: EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
               gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
               colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0, right: 8.0, left: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Text(
                        "$_deviceModel", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  
                   Expanded(
                        flex: 6,
                        child: Text(
                        "PHEDSmart WorkForce v2.1.0", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    
                    
                  ],
                ),
              ),
            ),
      
     
    );
  }
}