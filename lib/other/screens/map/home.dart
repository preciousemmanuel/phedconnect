import 'package:flutter/material.dart';
import '../../controllers/map/map_controller.dart';
import '../../controllers/utility/map_installer_controller.dart';
import '../../data/authenticated_staff.dart';
import '../../services/location_service.dart';
import '../../utilities/alert_dialog.dart';
import '../../widgets/customer_info_text.dart';
import '../../widgets/submit_btn.dart';

class MapHomeScreen extends StatefulWidget {
  @override
  _MapHomeScreenState createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MapController mc = MapController();
  final MapInstallerController mic = MapInstallerController();

  String accountNoOrBrd;
  String sealOne;
  String sealTwo;
  String meterNo;
  String longitude;
  String latitude;
  String mapContractor;
  String mapContractorId;
  String mapContractorName;
  String mapInstaller;
  String mapInstallerId;
  String mapInstallerName;
  String comment;
  bool isLoading = true;
  List contractorList = List();
  Map<String,dynamic> customerDetails;
  

  List<DropdownMenuItem> dropdownItemsMapContractor = [
        DropdownMenuItem(
          child: Text(
            "Select Map Contractor**",
            style: TextStyle(color: Colors.red),
          ), 
          value: ""
        ),
  ];

  List<DropdownMenuItem> dropdownItemsMapInstaller = [
        DropdownMenuItem(
          child: Text(
            "Select Map Installer**",
            style: TextStyle(color: Colors.red),
          ), 
          value: ""
        ),
        DropdownMenuItem(
          child: Text(
            "Ebuka",
            //style: TextStyle(color: Colors.red),
          ), 
          value: "Ebuka"
        ),
        DropdownMenuItem(
          child: Text(
            "Emma",
            //style: TextStyle(color: Colors.red),
          ), 
          value: "Emma"
        )
  ];

  @override
  void initState(){
    mapContractor = dropdownItemsMapContractor[0].value;
    mapInstaller = dropdownItemsMapInstaller[0].value;
    //searchCustomer();
    super.initState();
  }


  searchCustomer() async{

    //isLoading = true;"9725268650"
    print("searching...");
   
    if(accountNoOrBrd.toString().trim().length == 0){
      _showSnackBar(isSuccessSnack: false, msg: "Please enter an account number");
      return;
    }

    showAlertDialog(
      context: context, 
      isLoading: true, 
      loadingMsg: "fetching customer...please wait"
    );
        
    Map<String,dynamic> res = await mc.findCustomer(accountNoOrBrd.trim());

    if(res != null && res["status"] == "SUCCESS" && res["customerExist"]){

        contractorList = res["contractorsList"];
        customerDetails = res["customerDetails"];

        if(dropdownItemsMapContractor.length > 1){       
            setState(() {
                dropdownItemsMapContractor.removeRange(1, dropdownItemsMapContractor.length);
            });
        }

        contractorList.forEach((element) {
          dropdownItemsMapContractor.add(
              DropdownMenuItem(
                child: Text(
                  element["ContractorName"],
                  //style: TextStyle(color: Colors.red),
                ), 
                value: "${element["ContractorName"]}|${element["ContractorId"]}"
              )
          );
        });
        
        Navigator.pop(context);
        setState(() {
          isLoading = false;
        });
      
    }
    if(res != null && res["status"] == "SUCCESS" && !res["customerExist"]){
        Navigator.pop(context);
          showAlertDialog(
            context: context, 
            isLoading: false, 
            isSuccess: false,
            completedMsg: "No customer found"
          );
    }
    if(res != null && res["status"] != "SUCCESS"){
          Navigator.pop(context);
           showAlertDialog(
            context: context, 
            isLoading: false, 
            isSuccess: false,
            completedMsg: "Ooops...We couldn't complete this operation"
          );
    }
    
   
  }

  getMapInstaller() async{
       if(dropdownItemsMapInstaller.length > 1){       
            setState(() {
                dropdownItemsMapInstaller.removeRange(1, dropdownItemsMapInstaller.length);
            });
        }
        
        var mapC = mapContractor.split("|");
        mapContractorName = mapC[0];
        mapContractorId = mapC[1];
        print(mapContractorId);
        print(mapContractorName);

        if(mapContractorId.trim().length == 0 || mapContractorId == null){
          _showSnackBar(isSuccessSnack: false, msg: "Please select a contractor");
          return;
        }
        showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving Map Installers");
        

        var mapInstallerList = List();
        Map<String, dynamic> res = await mic.getMapInstaller(mapContractorId);
        if(res["status"] == "SUCCESS"){  
          mapInstallerList.clear();
          mapInstallerList = res["data"];          
          mapInstallerList.forEach((element) {
          dropdownItemsMapInstaller.add(
                DropdownMenuItem(
                  child: Text(element["Name"], overflow: TextOverflow.visible),
                  value: "${element["Name"]}|${element["InstallerId"]}",
                ),
            );
          }); 
          
        }
        else{
          _showSnackBar(isSuccessSnack: false, msg: "No Map Installer for the selected Map contractor");
        }
        Navigator.pop(context);
  }


//Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg, int duration}){
        //create snackbar
        var snackBar =  SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
            content: Text(msg,
            style: TextStyle(
              color: Colors.white
            ),),
        );

        //show snackbar
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  submit(){
    _getGeoPoints();
  }

  Future _getGeoPoints() async {
    showAlertDialog(
        context: context,
        isLoading: true,
        loadingMsg: "submitting details..."); 

    try {
      var latLng = await LocationService.checkLocationPermissionStatus(context);
      print(latLng.toString());

      if (latLng["isServiceEnabled"] &&
          latLng["latitude"] != null &&
          latLng["longitude"] != null) {
          latitude = latLng["latitude"].toString();
          longitude = latLng["longitude"].toString();

        print(latLng["latitude"]);

        completeAction();
      } else {
        setState(() {
          isLoading = false;
        });
         Navigator.pop(context);
        _showSnackBar(isSuccessSnack: false, msg: "Please put on your location");
      }
    } catch (e) {
      print("dc_details: error fetching lat/lng");
      print("dc_details: " + e.toString());
    }

    Navigator.of(context).pop();
    print(longitude);
    print(latitude);
  }

  
  String validateInput(){
      
      if(sealOne == null || sealOne.toString().trim().length == 0){
        return "Please enter seal one value";
      }
      if(sealTwo == null || sealTwo.toString().trim().length == 0){
          return "Please enter seal two value";
      }
      if(meterNo == null || meterNo.toString().trim().length == 0){
            return "Please enter Meter Number";
      }
      if(mapInstaller == null || mapInstaller.toString().trim().length == 0){
            return "Please select a Map Installer";
      }
      if(mapContractor == null || mapContractor.toString().trim().length == 0){
            return "Please select a Map Vendor";
      }
      return null;
  }

  
  void completeAction() async{

      if(validateInput() != null){
        _showSnackBar(isSuccessSnack: false, msg: validateInput());
        return;
      }

      Navigator.pop(context);
      showAlertDialog(
        context: context,
        isLoading: true,
        loadingMsg: "submitting details...");

      Map<String,dynamic> data = {
        "staffId": authenticatedStaff.staffId,
        "poleNo": "NULL",
        "sealOne": sealOne,
        "sealTwo": sealTwo,
        "mapVendor": customerDetails.containsKey("MAPVendor") && customerDetails["MAPVendor"] != null ? customerDetails["MAPVendor"]: null,
        "meterNo": meterNo,
        "meterInstallationComment": comment,
        "staffName": authenticatedStaff.name,
        "latitude": latitude,
        "longitude": longitude,
        "mapContractorId": mapContractorId,
        "mapContractorName": mapContractorName,
        "mapInstallerId": mapInstallerId,
        "mapInstallerName": mapInstallerName,
        "ticketId": customerDetails.containsKey("TransactionID") && customerDetails["TransactionID"] != null ? customerDetails["TransactionID"]: null,
        
      };

      Map<String, dynamic> res = await mc.submit(data);

      //submission was successful
      if(res != null){
        if(res['isSuccessful']){
          setState(()=>isLoading = false); 
          showAlertDialog(
            context: context,
            navigateTo: '/modules',
            isLoading: false, 
            isSuccess: true, 
            completedMsg: res['msg']);
        }
        //submission failed
        else{
          Navigator.pop(context);
          setState(()=>isLoading = false); 
          showAlertDialog(context: context, isLoading: false, isSuccess: false, completedMsg: res['msg']);
        }
      }
      

  }


  //builds the search text field
  Widget _buildSearchTextField(){
        return  Container(
          child: Row(
            children: <Widget>[
              Expanded(                    
                    child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Account/Meter Number",
                      hintText: "Enter Here",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, size: 24.0,),
                        onPressed: () => searchCustomer()
                          //print("fdsdsd");
                      ),
                    ),
                    onChanged: (value){
                      accountNoOrBrd = value;
                    },
                  ),
              ),
            ],
          ),
        );
  }

  Widget _buildDropDownButtonMapInstaller(){

      Widget dropdownButton;
      dropdownButton = Container(
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.all(8.0),
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: DropdownButton(
          items: dropdownItemsMapInstaller,
          onChanged: (dynamic value){
            print("dropdown value: $value");
            setState(() {
              mapInstaller = value;
            });
             var mapI = mapInstaller.split("|");
              mapInstallerName = mapI[0];
              mapInstallerId = mapI[1];
          },
          value: mapInstaller,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
      );

      return dropdownButton;
  }

  Widget _buildDropDownButtonMapContractor(){

      Widget dropdownButton;
      dropdownButton = Container(
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.all(8.0),
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: DropdownButton(
          items: dropdownItemsMapContractor,
          onChanged: (dynamic value){
            print("dropdown value: $value");
            setState(() {
              mapContractor = value;
            });
            getMapInstaller();
          },
          value: mapContractor,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
      );

      return dropdownButton;
  }

  Widget _buildSealOneTextField(){
    return  TextFormField(             
      decoration: InputDecoration(
        labelText: "Seal 1",
        hintText: "",
        prefixIcon: Icon(Icons.verified_user),
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.length == 0 || value == null){
          return "Please enter seal one.";
        }
        return null;
      },
      onSaved: (newValue) => sealOne = newValue,
      onChanged: (String value) => sealOne = value,
    );
  }

  Widget _buildSealTwoTextField(){
    return  TextFormField(             
      decoration: InputDecoration(
        labelText: "Seal 2",
        hintText: "",
        prefixIcon: Icon(Icons.verified_user),
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.length == 0 || value == null){
          return "Please enter an seal two.";
        }
        return null;
      },
      onSaved: (newValue) => sealTwo = newValue,
      onChanged: (String value) => sealTwo = value,
    );
  }

  Widget _buildMeterNoTextField(){
    return  TextFormField(             
      decoration: InputDecoration(
        labelText: "Meter Number",
        hintText: "",
        prefixIcon: Icon(Icons.verified_user),
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.length == 0 || value == null){
          return "Please enter Meter number";
        }
        return null;
      },
      onSaved: (newValue) => meterNo = newValue,
      onChanged: (String value) => meterNo = value,
    );
  }

  Widget _buildCommentTextField(){
    return  TextFormField(             
      decoration: InputDecoration(
        labelText: "Comment",
        hintText: "",
        prefixIcon: Icon(Icons.verified_user),
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.length == 0 || value == null){
          return "Please enter a comment";
        }
        return null;
      },
      onSaved: (newValue) => comment = newValue,
      onChanged: (String value) => comment = value,
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("MAP Meter Capturing")
        ),
        body: Container(
          decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
                )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
            child: Column(
              children: <Widget>[
                _buildSearchTextField(),
                //SizedBox(height: 15.0,),
                customerDetails == null ? Container() : Expanded(
                      child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                        SizedBox(height: 25.0,),
                        SizedBox(height: 15.0),
                        isLoading ? Container() : Container(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                                CustomerInfoText("NAME: ", customerDetails["CustomerName"] != null ? customerDetails["CustomerName"] : ''),
                                CustomerInfoText("ACCOUNT NO: ", customerDetails["CustomerReference"] != null ? customerDetails["CustomerReference"] : ''),
                                CustomerInfoText("METER NO: ", customerDetails["AlternateCustReference"] != null ? customerDetails["AlternateCustReference"] : ''),
                                CustomerInfoText("ACCOUNT TYPE: ", customerDetails["AccountType"] != null ? customerDetails["AccountType"] : ''),
                                CustomerInfoText("ARREARS: ",  customerDetails["BRC_Arrears"] != null ? customerDetails["BRC_Arrears"] : ''),
                                CustomerInfoText("DTR: ", customerDetails["DTR_NAME"] != null ? customerDetails["DTR_NAME"] : ''),
                                CustomerInfoText("CIN: ", customerDetails["CIN"] != null ? customerDetails["CIN"] : ''),
                                CustomerInfoText("ZONE: ", customerDetails["IBC"] != null ? customerDetails["IBC"] : ''),
                                CustomerInfoText("FEEDER: ", customerDetails["BSC"] != null ? customerDetails["BSC"] : ''),
                                CustomerInfoText("PHASE: ", customerDetails["MeterPhase"] != null ? customerDetails["MeterPhase"].toString().trim() : ''),
                            ],
                          ),
                        ),
                       // FileUploadButton(_setImages),
                        SizedBox(height: 15.0),  
                        Text(
                          "Please complete the following fields",
                          //textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ), 
                        SizedBox(height: 15.0,),
                        _buildDropDownButtonMapContractor(),
                        SizedBox(height: 15.0,),
                        _buildDropDownButtonMapInstaller(), 
                        SizedBox(height: 15.0,),
                        _buildSealOneTextField(),
                        SizedBox(height: 15.0,),
                        _buildSealTwoTextField(),
                        SizedBox(height: 15.0,),
                        _buildMeterNoTextField(),
                         SizedBox(height: 15.0,),
                        _buildCommentTextField(),
                        SizedBox(height: 25.0,),
                        SubmitButton(submit, isLoading, "SUBMIT")
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ); 
  }
 

}
