
import '../../controllers/activities/activity_reports_controller.dart';
import '../../data/authenticated_staff.dart';
import '../../data/active_dtr.dart';
import '../../utilities/alert_dialog.dart';
import 'package:flutter/material.dart';



class ActivityHomeScreen extends StatefulWidget {
  @override
  _ActivityHomeScreenState createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends State<ActivityHomeScreen> {
  
  bool isLoading = false;

  Widget accountItemCard(BuildContext context, IconData leadingIcon, Color color, String title, {isFirstItem = false}){

      double deviceWidth = MediaQuery.of(context).size.width;
      double deviceHeight = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: (){
            if(title == "Disconnections"){
              rcdcActivityFlag = "DC";
              Navigator.pushNamed(context, '/activity_rcdc');
            }
            if(title == "Reconnections"){
              rcdcActivityFlag = "RC";
              Navigator.pushNamed(context, '/activity_rcdc');
            }
            if(title == "Tariff Changes"){
              Navigator.pushNamed(context, '/activity_tariff_change');
            }
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
              //print("logged out");Generate ReportGenerate Report
            }
            if(title == "Generate Report"){       
                generateReport();       
            }
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
                        SizedBox(width: 5.0),
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
  
  void generateReport() async{
      //setState(() => isLoading = true);
      showAlertDialog(
        context: context, 
        isLoading: true, 
        loadingMsg: "Please wait. We are sending the reports to your email"
      );

      ActivityReportsController arc  =  ActivityReportsController();
      
      Map<String,dynamic> res;
      res = await arc.myActivityReports(fromDate: "2/3/3", toDate: "3/3/3");

      if(res != null){
        if(res["status"] == "SUCCESS"){         
            Navigator.pop(context);
            showAlertDialog(
              context: context,
              isLoading: false,
              isSuccess: true, 
              completedMsg: "Your PHED SmartWorkForce activities report successfully generated and sent to ${authenticatedStaff.email} with staff Id ${authenticatedStaff.staffId}"
            );

        }
      }
      else{
        Navigator.pop(context);
        showAlertDialog(
          context: context, 
          isLoading: false, 
          isSuccess: false, 
          completedMsg: "We are sorry, temporarily unable to generate your activity reports. Please try later"
        );
      }
  }


  @override
  Widget build(BuildContext context) {

      return WillPopScope(
            onWillPop: (){ return _onBackPressed(context);},
            child: Scaffold(
            body: isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                              child: Text("View your activities on the \nPHED SmartWorkForce", 
                              overflow: TextOverflow.visible, 
                              style: TextStyle(fontWeight:FontWeight.bold, fontSize: 14.0, color: Colors.white70)
                          ),
                            ),
                        ],
                      ),
                    ]
                  )
                ),
                accountItemCard(context, Icons.assignment, Colors.cyan, "Disconnections", isFirstItem: true),
              ],
            ),              
            accountItemCard(context, Icons.assignment, Colors.green,  "Reconnections",),
            accountItemCard(context, Icons.assignment, Colors.amber,  "Bill Distribution",),
            accountItemCard(context, Icons.assignment, Colors.blue, "i-Reports"),
            accountItemCard(context, Icons.assignment, Colors.purple, "Account Seperations"),
            accountItemCard(context, Icons.assignment, Colors.red, "Tariff Changes"),
            accountItemCard(context, Icons.assignment, Colors.lime, "New Customers"),
            accountItemCard(context, Icons.table_chart, Colors.lime, "Generate Report"),
            //accountItemCard(context, Icons.exit_to_app, Colors.deepOrange, "Account Seperations"),
          ],
        ),
      ),
        ),
      );
  }
}