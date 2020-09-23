
import '../data/active_dtr.dart';
import '../models/dashboard_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/authenticated_staff.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/utility/check_app_version.dart';



class ModulesScreen extends StatefulWidget {

    @override
    _ModulesScreenState createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen>{


  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final CheckAppVersionController model = new CheckAppVersionController();
  String appVersion;
  bool isUsingOldVersion = false;
  bool isLoading = true;
  Map<String,dynamic> res;


  @override
  void initState(){
    
    //initStateVariables();
    checkAppVersion();
    super.initState();
  }

  checkAppVersion() async{
      appVersion = "2.3.2";
      res = await model.getLatestVersion();
      print("checkappversion: " + res.toString());

      if(res["status"] == "SUCCESS"){
        print(res["version"].toString());
        print(appVersion.toString());
        if(res["version"].toString() != appVersion){
          isUsingOldVersion = true; 
        }
        setState(() {
          isLoading = false;
        });
      }
      else{
        setState(() {
          isLoading = false;
        });
      }
  }
 
  _logout() async{
      print("logout initiated...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      authenticatedStaff = null;
      prefs.remove("authStaff");
      _showSnackBar(isSuccessSnack: true, msg: "Logged out successfully");
      Future.delayed( Duration(seconds: 2), (){  
         Navigator.pushReplacementNamed(context, '/login');
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
  }

  List<DashboardMenu> dashboardMenu() {
    List<DashboardMenu> menu = List<DashboardMenu>();

          //mis
          menu.add(
            DashboardMenu(
              title: "MIS",
              onTapAction: (){
                  activeMISDisconnect = "MIS";
                  Navigator.pushNamed(context, '/mis_find_customer');
              },
              icon: Icon(Icons.assignment, color: Colors.green, size: 30.0)
            )
          );

          //i-report
          menu.add(
              DashboardMenu(
                title: "i-REPORT",
                onTapAction: () => Navigator.pushNamed(context, '/home_i_report'),
                icon: Icon(Icons.visibility, color: Colors.green, size: 30.0)
              )
          );

          //knowledge base
          menu.add(
            DashboardMenu(
              title: "KNOWLEDGE BASE",
              onTapAction: () => Navigator.pushNamed(context, '/kb_home'),
              icon: Icon(Icons.archive, color: Colors.green, size: 30.0)
            )
          );

          //customer onboarding
          menu.add(
            DashboardMenu(
                title: "CUSTOMER MANAGEMENT",
                //onTapAction: () => Navigator.pushNamed(context, '/rpd_onboarding'),
                onTapAction: () => Navigator.pushNamed(context, '/cm_home'),
                icon: Icon(Icons.person, color: Colors.green, size: 30.0)
              ), 
          );

          //enums
          menu.add(
            DashboardMenu(
                title: "ENUMS",
                //onTapAction: () => Navigator.pushNamed(context, '/rpd_onboarding'),
                onTapAction: () => Navigator.pushNamed(context, '/enums'),
                icon: Icon(Icons.person, color: Colors.green, size: 30.0)
              ), 
          );


          /*
          //tarrif change
          menu.add(
            DashboardMenu(
                title: "TARRIF CHANGE",
                onTapAction: (){
                  activeMISDisconnect = "TARRIF_CHANGE";
                  Navigator.pushNamed(context, '/mis_find_customer');
                },
                icon: Icon(Icons.refresh, color: Colors.green, size: 30.0)
            ),
          );

          //Account Seperation
          menu.add(
            DashboardMenu(
                title: "ACCOUNT SEPERATION",
                onTapAction: (){
                  activeMISDisconnect = "ACCOUNT_SEPERATION";
                  Navigator.pushNamed(context, '/mis_find_customer');
                },
                icon: Icon(Icons.transfer_within_a_station, color: Colors.green, size: 30.0)
            ),
          );
          */
          if(authenticatedStaff.modules.length > 0){

              for(int i = 0; i < authenticatedStaff.modules.length; i++){
              var access = authenticatedStaff.modules[i]["MenuText"];

                  //insight
                  if(access == "INSIGHT"){                
                    menu.add(
                        DashboardMenu(
                          title: "INSIGHT",
                          onTapAction: () {
                              Navigator.pushNamed(context, '/insight_home');
                          },
                          //onTapAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BDStreetList(selectedDTRId))),
                          icon: Icon(Icons.insert_chart,color: Colors.green, size: 30.0)
                        )
                    );
                  }
                  // dtr management
                  if(access == "BILLDISTRIBUTION"){                 
                    menu.add(
                        DashboardMenu(
                          title: "DTR MANAGEMENT",
                          onTapAction: () {
                            // _showSnackBar(isSuccessSnack: false, msg:"COMING SOON!");
                            Navigator.pushNamed(context, '/bd_home');
                          },
                          icon: Icon(Icons.settings_input_antenna,color: Colors.green, size: 30.0)
                        )
                    );
                  }
                  //rpd
                  if(access == "RPD"){
                    menu.add(
                      DashboardMenu(
                          title: "RPD",
                          onTapAction: () => Navigator.pushNamed(context, '/rpd_find_customer'),
                          icon: Icon(Icons.monetization_on, color: Colors.green, size: 30.0)
                      )
                    );
                  }
                  //rcdc
                  if(access == "RCDC"){
                      menu.add(
                        DashboardMenu(
                            title: "RCDC",
                            onTapAction: () => Navigator.pushNamed(context, '/home_rcdc'),
                            icon: Icon(Icons.power,color: Colors.green, size: 30.0)
                        ),
                      );
                  }

                  if(access == "MAP"){
                      menu.add(
                        DashboardMenu(
                            title: "MAP",
                            onTapAction: () => Navigator.pushNamed(context, '/map_home'),
                            icon: Icon(Icons.location_city,color: Colors.green, size: 30.0)
                        ),
                      );
                  }

                  if(access == "TARRIFCHANGE"){
                      menu.add(
                        DashboardMenu(
                            title: "TARRIF CHANGE",
                            onTapAction: (){
                              Navigator.pushNamed(context, '/map_home');
                            },
                            icon: Icon(Icons.location_city,color: Colors.green, size: 30.0)
                        ),
                      );
                  }
              }
                //customer onboarding
               /* menu.add(
                  DashboardMenu(
                      title: "CUSTOMER ONBOARDING",
                      onTapAction: () => Navigator.pushNamed(context, '/rpd_onboarding'),
                      icon: Icon(Icons.person, color: Colors.green, size: 30.0)
                    ), 
                );
                */
          }

          //Account Seperation
          menu.add(
            DashboardMenu(
                title: "MY ACTIVITIES",
                onTapAction: (){
                  activeMISDisconnect = "MY ACTIVITIES";
                  Navigator.pushNamed(context, '/activity_home');
                },
                icon: Icon(Icons.transfer_within_a_station, color: Colors.green, size: 30.0)
            ),
          );
         
          return menu;
  }

  Widget _buildGridView(DashboardMenu menuItem) {
    return InkWell(
      onTap: menuItem.onTapAction,
      child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          alignment: Alignment.center,
          //width: 300.0,
          //height: 100.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                    color: Colors.black12)
              ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              menuItem.icon,
              SizedBox(height: 5),
              Text(
                menuItem.title,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0
                  ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

   Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          height: MediaQuery.of(context).size.height / 5,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
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
            boxShadow: [
              BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black26)
            ]
          ),
          child: Text("Exit PHEDSmart Workforce\n\nAre you sure?",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
            color: Colors.blue,
	          textColor: Colors.white,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("CANCEL"),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
            color: Colors.red,
	          textColor: Colors.white,
            onPressed: () {
              SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
              return true;
            },
            child: Text("YES"),
            ),
          ),
        ],
      ),
    ) ?? false;
      
  }

  _gotoPlayStore() async {
    const url = 'https://play.google.com/store/apps/details?id=com.phed.smartworkforce';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            //title: Text("Home"),
            title: Image(
              image: AssetImage('assets/images/headerLogo.jpg'),
              fit: BoxFit.contain,
              width: 120,
              height: 120,
            ),
            backgroundColor: Colors.white,
            /*actions: <Widget>[
              InkWell(
                  onTap: _logout,
                  child: Container(
                  margin: EdgeInsets.only(top: 22, right: 12),
                  child: Text("Logout", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                ),
              ),
            
            ],
            */
        ),
        body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
          margin: EdgeInsets.only(bottom: 50.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
              )
          ),
          child: isUsingOldVersion ?       
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0)
              ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                      Text(
                        res["message"], 
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                      SizedBox(height: 15.0,),
                      RaisedButton(
                        child: Text(
                          "Get latest version form Play Store",
                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: _gotoPlayStore,
                        color: Colors.blue,
                      )
                 ],
               ),
             ),
           ) :
           Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 24.0),
                Text(
                "Select a module to continue",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16.0),
                Expanded(
                  child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 3
                          : 4,
                      children:
                          List.generate(dashboardMenu().length, (index) {
                          return _buildGridView(dashboardMenu()[index]);
                        //return Text("xxxx");
                      })),
                )
              ],
            ),
            ),
              ),
              
            ),
            bottomSheet: Container(
              height: 50.0,
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
                     /*Expanded(
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
                    */
                    Expanded(
                      flex: 4,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(context, '/feedback'),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              width: 30.0,
                              alignment: Alignment.center,
                              child: Icon(Icons.message, color: Colors.blue, size: 18.0,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white
                              ),
                            ),
                            Text(
                              "Feedback",
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white
                              ),
                            )
                          ],
                      ),
                        ),
                    ),
                    Expanded(
                      flex: 4,
                        child: InkWell(
                          onTap: _logout,
                          child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              width: 30.0,
                              child: Icon(Icons.exit_to_app, color: Colors.blue, size: 18.0,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white
                              ),
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                    
                   /* Expanded(
                        flex: 6,
                        child: Text(
                        "PHEDSmart WorkForce v1.0.0", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    */
                    
                  ],
                ),
              ),
            ),
        ),
      );
  }
}