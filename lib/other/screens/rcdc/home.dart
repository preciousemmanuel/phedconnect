import 'package:flutter/material.dart';
import '../../data/authenticated_staff.dart';
import '../../models/dashboard_menu.dart';

class ModuleRCDCScreen extends StatefulWidget {
  
  //final MainModel model;
  //ModuleRCDCScreen(this.model);

  @override
  _ModuleRCDCScreenState createState() => _ModuleRCDCScreenState();
}

class _ModuleRCDCScreenState extends State<ModuleRCDCScreen> {

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

List<DashboardMenu> dashboardMenu(){

    List<DashboardMenu> dashboardMenuItem = [
    
      DashboardMenu(
        title: "DC Entry", 
        onTapAction: () => Navigator.pushNamed(context, '/disconnection_list'),
        icon: Icon(Icons.vertical_align_center, color: Colors.green, size: 30.0) 
      ),
      DashboardMenu(
        title: "RC Entry", 
         onTapAction: () => Navigator.pushNamed(context, '/reconnection_list'),
        icon: Icon(Icons.settings_input_antenna, color: Colors.green, size: 30.0) 
      ),
      /*DashboardMenu(
        title: "RPD", 
        onTapAction: () => Navigator.pushNamed(context, '/rpd'),
        //onTapAction: () => _showSnackBar(isSuccessSnack: true, msg: "COMING SOON"),
        icon: Icon(Icons.monetization_on, color: Colors.green, size: 30.0) 
      )
      DashboardMenu(
        title: "Status", 
        //onTapAction: () => Navigator.pushNamed(context, '/status'),
        onTapAction: () => _showSnackBar(isSuccessSnack: true, msg: "COMING SOON"),
        icon: Icon(Icons.settings_backup_restore, color: Colors.green, size: 30.0)  
      ),
      
      DashboardMenu(
        title: "Bill Distribution", 
        onTapAction: () => print("Bill Distribution"),
        icon: Icon(Icons.transfer_within_a_station, color: Colors.green, size: 30.0) 
      ),
     
      DashboardMenu(
        title: "i-Report", 
        onTapAction: () => Navigator.push(context, MaterialPageRoute(builder: (_)=> StatusScreen())),
        icon: Icon(Icons.visibility, color: Colors.green, size: 30.0)  
      ), */
    ];  

    return dashboardMenuItem;
}


/*
    //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg, int duration}){

        //create snackbar
        var snackBar =  SnackBar(
            duration: Duration(seconds: duration != null ? duration: 5),
            //backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(msg,
            style: TextStyle(
              color: Colors.white
            ),),
        );

        //show snackbar
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  */
  

Widget _buildGridView(DashboardMenu menuItem){

    return InkWell(
        onTap: menuItem.onTapAction,
        child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        alignment: Alignment.center,
        width:300.0,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(blurRadius: 4.0, offset: Offset(0, 2), color: Colors.black12)
            ]
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
                    fontWeight: FontWeight.w400
                  ),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),  
            ],
          )
      ),
    );

}


Future<bool> _onBackPressed() async {
    Navigator.pushReplacementNamed(context, '/modules');
    return true;
}


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24.0,
              onPressed: () => Navigator.pushReplacementNamed(context, '/modules'),
            ),
            title: Text("RCDC Modules")
          ),
          body: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
              )
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 4.0, offset: Offset(0, 2), color: Colors.black12)
                    ]
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Text(authenticatedStaff.feederId),
                        SizedBox(height: 3.0),
                        authenticatedStaff != null ? Text(authenticatedStaff != null ? authenticatedStaff.name : "") : Container(),
                        SizedBox(height: 3.0),
                        authenticatedStaff != null ? Text(authenticatedStaff.email != null ? authenticatedStaff.email : "") : Container(),
                        SizedBox(height: 3.0),
                        authenticatedStaff != null ? Text(authenticatedStaff.staffId != null ? authenticatedStaff.staffId : "") : Container()
                      ],
                    )
                ),
                Divider(height: 5.0),
                Expanded(
                  child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
                  children: List.generate(dashboardMenu().length, (index){
                    return _buildGridView(dashboardMenu()[index]);
                    //return Text("xxxx");
                  })
                    ),
                )
               
              ]
              
            ),
          ),
      ),
    );
  }
}