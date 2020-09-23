
import 'package:flutter/material.dart';
import '../../controllers/billDistribution/dtr_to_executive_controller.dart';
import '../../data/active_dtr.dart';
import '../../data/authenticated_staff.dart';
import '../../models/billDistribution/DTRToExec.dart';
import '../../models/dashboard_menu.dart';
import '../../screens/bill/constans.dart';
import '../../utilities/styles.dart';

class BillHomeScreen extends StatefulWidget {
  @override
  _BillHomeScreenState createState() => _BillHomeScreenState();
}

class _BillHomeScreenState extends State<BillHomeScreen> {
  String selectedDTRId;
  DTRToExecutiveController dtec = DTRToExecutiveController();
  List<DTRToExecutive> _dtrList = []; // Option 2
  bool isLoading = true;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getListOfExecutiveDTRs();
    super.initState();
  }

  getListOfExecutiveDTRs() async {
    Map<String, dynamic> res =
        await dtec.getDTRByStaffId(authenticatedStaff.staffId);
    if (res["status"] == "SUCCESS") {
      _dtrList.clear();
      setState(() {
        _dtrList = res["data"];
        isLoading = false;
      });
    } else {
      _showSnackBar(
          isSuccessSnack: false, msg: "No DTR has been profiled to you");
    }

    print("Homeeee " + res.toString());
  }

  //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg}) {
    //create snackbar
    var snackBar = SnackBar(
      backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    //show snackbar
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  List<DashboardMenu> dashboardMenu() {
    List<DashboardMenu> dashboardMenuItem = [
      DashboardMenu(
          title: "NON-MD\nBILL DISTRIBUTION",
          onTapAction: () {
            if (selectedDTRId == null || selectedDTRId.trim().length == 0) {
              _showSnackBar(
                  isSuccessSnack: false,
                  msg: "Please select a DTR to continue");
            } else {
              activeDTR = selectedDTRId;
              Constants.bdCustomer = "NON-MD";
              Navigator.pushNamed(context, '/bd_street_list');
            }
          },
          //onTapAction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BDStreetList(selectedDTRId))),
          icon: Icon(Icons.vertical_align_center,
              color: Colors.green, size: 30.0)),
      DashboardMenu(
          title: "MD\nBILL DISTRIBUTION",
          onTapAction: () {
            // _showSnackBar(isSuccessSnack: false, msg:"COMING SOON!");
            Constants.bdCustomer = "MD";
            Navigator.pushNamed(context, '/bd_search_customer');
          },
          icon: Icon(Icons.settings_input_antenna,
              color: Colors.green, size: 30.0)),
      DashboardMenu(
          title: "ASSIGN DTR",
          onTapAction: () => Navigator.pushNamed(context, '/bd_searchdtr'),
          icon: Icon(Icons.monetization_on, color: Colors.green, size: 30.0)
      ),
      DashboardMenu(
          title: "DISCONNECT",
          onTapAction: (){
              activeMISDisconnect = "DTR_DISCONNECT";
              Navigator.pushNamed(context, '/mis_find_customer');
          },
          icon: Icon(Icons.settings_backup_restore,color: Colors.green, size: 30.0)
      ),
     /*
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

  Widget _buildGridView(DashboardMenu menuItem) {
    return InkWell(
      onTap: menuItem.onTapAction,
      child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          alignment: Alignment.center,
          width: 300.0,
          height: 100.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                    color: Colors.black12)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              menuItem.icon,
              SizedBox(height: 5),
              Text(
                menuItem.title,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.pushNamed(context, '/modules');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushNamed(context, '/modules')),
            title: Text("DTR MANAGEMENT")),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bgg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(1.0), BlendMode.dstATop))),
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                              color: Colors.black12)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        authenticatedStaff != null
                            ? Text(
                                "Hello, " + authenticatedStaff.name,
                                style: expansionPanelHeading,
                              )
                            : Container(),
                        //SizedBox(height: 3.0),
                        //authenticatedStaff != null ? Text(authenticatedStaff.staffId) : Container()
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: DropdownButton(
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          hint: Text(
                            'Please choose a DTR',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ), // Not necessary for Option 1
                          value: selectedDTRId,
                          onChanged: (newValue) {
                            setState(() {
                              selectedDTRId = newValue;
                              print(selectedDTRId);
                            });
                          },
                          items: _dtrList.map((dtr) {
                            return DropdownMenuItem(
                              child: Text(
                                "${dtr.dtrName} - ${dtr.dtrId}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: "${dtr.dtrName} - ${dtr.dtrId}",
                            );
                          }).toList(),
                        )),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "What do you want to do?",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        children:
                            List.generate(dashboardMenu().length, (index) {
                            return _buildGridView(dashboardMenu()[index]);
                          //return Text("xxxx");
                        })),
                  )
                ]),
              ),
      ),
    );
  }
}
