
import '../../data/authenticated_staff.dart';
import '../../data/active_dtr.dart';
import 'package:flutter/material.dart';

class CustomerManagementHomeScreen extends StatelessWidget {

  
  Widget accountItemCard(BuildContext context, IconData leadingIcon, Color color, String title, {isFirstItem = false}){

      double deviceWidth = MediaQuery.of(context).size.width;
      double deviceHeight = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: (){
            if(title == "CUSTOMER ONBOARDING"){
              //rcdcActivityFlag = "DC";
              //Navigator.pushNamed(context, '/activity_rcdc');
              Navigator.pushNamed(context, '/rpd_onboarding');
            }
            if(title == "ACCOUNT SEPERATION"){
                activeMISDisconnect = "ACCOUNT_SEPERATION";
                Navigator.pushNamed(context, '/mis_find_customer');
            }
            if(title == "TARIFF CHANGE"){
                activeMISDisconnect = "TARRIF_CHANGE";
                Navigator.pushNamed(context, '/mis_find_customer');
            }
            
            /*
            if(title == "i-Reports"){
              Navigator.pushNamed(context, '/activity_ireport');
              //print("logged out");
            }
            if(title == "Account Seperations"){
              Navigator.pushNamed(context, '/activity_seperation');
              //print("logged out");
            }
            if(title == "New Customers"){
              Navigator.pushNamed(context, "/activity_new_customer");
              //print("logged out");
            }
            */
          },
          child: Container(
          margin: isFirstItem ? 
          EdgeInsets.only(top: deviceHeight / 4.0, left: 24.0, right: 24.0, bottom: 8.0) : 
          EdgeInsets.only(top: 4, bottom: 4.0),
          padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0, bottom: 12.0),
          width: deviceWidth - 50,
          //height: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0,2),
                blurRadius: 6.0
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(   
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                crossAxisAlignment: CrossAxisAlignment.center,            
                children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(leadingIcon,size: 24.0, color: color,),
                        SizedBox(width: 10.0),
                        Text(title)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16.0,)
                ]
              ),
              
            ],
          ),
      ),
    );
      
  }

  Future<bool> _onBackPressed(BuildContext context) async {
      Navigator.pushReplacementNamed(context, '/modules');
      return true;
  }
  
  @override
  Widget build(BuildContext context) {

      return WillPopScope(
            onWillPop: (){ return _onBackPressed(context);},
            child: Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  //color: Colors.blue,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bgg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
                      )
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ProfileImageUpload(),
                      SizedBox(width: 10.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hello, ${authenticatedStaff.name.toLowerCase()}", 
                            overflow: TextOverflow.ellipsis, 
                            style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16.0, color: Colors.white)
                          ),
                          SizedBox(height: 8.0),
                            Container(
                              //width: MediaQuery.of(context).size.width - 50,
                              child: Text("Select an action to manage customer", 
                              overflow: TextOverflow.visible, 
                              style: TextStyle(fontWeight:FontWeight.bold, fontSize: 14.0, color: Colors.white70)
                          ),
                            ),
                        ],
                      ),
                    ]
                  )
                ),
                accountItemCard(context, Icons.person, Colors.cyan, "CUSTOMER ONBOARDING", isFirstItem: true),
              ],
            ),              
            //accountItemCard(context, Icons.assignment, Colors.green,  "CUSTOMER ONBOARDING",),
            accountItemCard(context, Icons.refresh, Colors.amber,  "TARIFF CHANGE",),
            accountItemCard(context, Icons.transfer_within_a_station, Colors.blue, "ACCOUNT SEPERATION"),
          
            //accountItemCard(context, Icons.exit_to_app, Colors.deepOrange, "Account Seperations"),
          ],
        ),
    ),
        ),
      );
  }
}