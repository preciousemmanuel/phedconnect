// import 'package:SmartWorkForce/enumsVerification/screens/savecustomerpremisedetail_screen.dart';
// import 'package:SmartWorkForce/screens/activities/ireport.dart';
// import 'package:SmartWorkForce/screens/activities/new_customer.dart';
// import 'package:SmartWorkForce/screens/activities/rcdc.dart';
// import 'package:SmartWorkForce/screens/activities/home.dart';
// import 'package:SmartWorkForce/screens/activities/seperation.dart';
// import 'package:SmartWorkForce/screens/activities/tariff_change.dart';
// import 'package:SmartWorkForce/screens/customermanagement/home.dart';
// import 'package:SmartWorkForce/screens/customermanagement/accountseperation/pendind_account_seperation.dart';
// import 'package:SmartWorkForce/screens/rpdonboarding/home.dart';
// import 'package:flutter/material.dart';
// import 'package:SmartWorkForce/screens/bill/streets/search_dtr.dart';
// import 'package:SmartWorkForce/screens/bill/streets/street_add.dart';
// import 'package:SmartWorkForce/screens/bill/streets/street_customer.dart';
// import 'package:SmartWorkForce/screens/bill/streets/street_list.dart';
// import 'package:SmartWorkForce/screens/knowledgebase/home.dart';
// import 'package:SmartWorkForce/screens/mis/find_customer.dart';
// import 'package:SmartWorkForce/screens/map/home.dart';
// import 'package:SmartWorkForce/screens/onboarding.dart';

// import 'package:SmartWorkForce/screens/bill/home.dart';
// import 'package:SmartWorkForce/screens/ireport/home.dart';
// import 'package:SmartWorkForce/screens/login.dart';
// import 'package:SmartWorkForce/screens/module.dart';
// import 'package:SmartWorkForce/screens/feedback.dart';
// import 'package:SmartWorkForce/screens/rcdc/disconnection_list.dart';
// import 'package:SmartWorkForce/screens/rcdc/home.dart';
// import 'package:SmartWorkForce/screens/rcdc/reconnection_list.dart';
// import 'package:SmartWorkForce/screens/rcdc/reconnection_verify.dart';
// import 'package:SmartWorkForce/screens/rcdc/status.dart';
// import 'package:SmartWorkForce/screens/rpd/home.dart';
// import 'package:SmartWorkForce/screens/rpd/rpd_calculator.dart';
// import 'package:SmartWorkForce/screens/rpd/rpd_find_customer.dart';
// import 'package:SmartWorkForce/screens/insight/home.dart';

// void main() {
//   runApp(MyApp());
// }


// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PHED SmartWorkForce',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Montserrat',
//       ),
//       //Routes Registration
//       routes: {
//         //'/': (BuildContext context) => LoginScreen(),
//         '/': (BuildContext context) => OnBoardingScreen(),
//         '/login': (BuildContext context) => LoginScreen(),
//         '/modules': (BuildContext context) => ModulesScreen(),
//         '/feedback': (BuildContext context) => FeedbackScreen(),
//         '/status': (BuildContext context) => StatusScreen(),
//         '/disconnection_list': (BuildContext context) => DisconnectionListScreen(),
//         '/reconnection_list': (BuildContext context) => ReconnectionListScreen(),
//         '/reconnection_verify': (BuildContext context) => VerifyReconnectionScreen(),
//         '/home_i_report': (BuildContext context) => IReportHomeScreen(),
//         '/home_rcdc': (BuildContext context) => ModuleRCDCScreen(),

//         //bill distribution
//         '/bd_home': (BuildContext context) => BillHomeScreen(),
//         '/bd_street_list': (BuildContext context) => BDStreetList(),
//         '/bd_street_add': (BuildContext context) => BDStreetAdd(),
//         '/bd_search_customer': (BuildContext context) => BDCustomerSearch(),
//         '/bd_searchdtr': (BuildContext context) => BDDTRSearch(),

//         //rpd
//         '/rpd_home': (BuildContext context) => RPDHomeScreen(),
//         '/rpd_calc': (BuildContext context) => RPDCalculator(),
//         '/rpd_find_customer': (BuildContext context) => RPDFindCustomer(),

//         //map
//         '/map_home': (BuildContext context) => MapHomeScreen(),
  
//         //mis
//         '/mis_find_customer': (BuildContext context) => MISFindCustomer(),

//         //knowledge base
//         '/kb_home': (BuildContext context) => KBHomeScreen(),

//         //insight
//          '/insight_home': (BuildContext context) => InsightHomeScreen(),

//          //RPD Onboarding
//          '/rpd_onboarding': (BuildContext context) => RPDOnboardingHomeScreen(),

//          //activity 
//          '/activity_home': (BuildContext context) => ActivityHomeScreen(),
//          '/activity_rcdc': (BuildContext context) => RCDCActivitiesScreen(),
//          '/activity_tariff_change' : (BuildContext context) => TariffChangeActivitiesScreen(),
//          '/activity_ireport' : (BuildContext context) => IreportActivitiesScreen(),
//          '/activity_seperation' : (BuildContext context) => SeperationActivitiesScreen(),
//          '/activity_new_customer': (BuildContext context) => NewCustomerActivitiesScreen(),

//           //customer management
//           '/cm_home': (BuildContext context) =>  CustomerManagementHomeScreen(),

//           //enums
//           '/enums' : (BuildContext context) => SaveCustomerVerificationPremiseDetail(),

//           '/pending_account_seperation': (BuildContext context) => PendingAccountSeperationScreen(),
//           '/pending_subaccount_seperation': (BuildContext context) => PendingAccountSeperationScreen(), 

//         //'/streetscustomer_list': (BuildContext context) => StreetCustomerList(),
//       },
//       //home: MyApp()
//     );
//   }
// }
