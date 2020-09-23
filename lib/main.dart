import 'package:customer_app/other/screens/feedback.dart';
import 'package:customer_app/other/screens/login.dart';
import 'package:customer_app/other/screens/mis/find_customer.dart';
// import 'package:customer_app/scoped-model/bill.dart';
import 'package:customer_app/scoped-model/main.dart';
import 'package:customer_app/screens/card_payment.dart';
import 'package:customer_app/screens/check_account.dart';
import 'package:customer_app/screens/customer_info.dart';
import 'package:customer_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
 State<StatefulWidget> createState() {
    return _MyAppState();
    
  } 
}

  class _MyAppState extends State<MyApp> {
   MainModel _model=MainModel();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ScopedModel<MainModel>(model: _model, child:  MaterialApp(
      title: 'PHED SERVICE',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue[-100],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        
      ),
      routes: {
        '/':(BuildContext context)=>HomeScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/checkaccount':(BuildContext context)=>CheckAccountScreen(),
        '/customer_info':(BuildContext context)=>CustomerInfoScreen(),
        '/paybills':(BuildContext context)=>CardPaymentScreen(),
        '/feedback': (BuildContext context) =>_model.user==null?LoginScreen(): FeedbackScreen(),
        '/mis': (BuildContext context) =>_model.user==null?LoginScreen():MISFindCustomer()
      },
      //home:HomeScreen() ,
    )
    );
  }
}


